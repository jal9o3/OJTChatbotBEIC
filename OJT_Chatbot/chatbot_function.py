from llama_index.embeddings.huggingface import HuggingFaceEmbedding
from llama_index.core import Settings
from llama_index.core import PromptTemplate
from llama_index.core import VectorStoreIndex
from llama_index.core.tools import QueryEngineTool, ToolMetadata
from llama_index.core import load_index_from_storage, StorageContext
from llama_index.core.node_parser import SentenceSplitter
import os
from llama_index.core.agent import ReActAgent
from llama_index.core.objects import ObjectIndex
from prompts import agent_prompt, sub_agent_prompt
import psycopg2
from llama_index.core import Document
import numpy as np
import random
import torch

# Setting seeds
np.random.seed(122)
random.seed(122)
torch.manual_seed(122)
if torch.cuda.is_available():
    torch.cuda.manual_seed(122)
    torch.cuda.manual_seed_all(122)
    

# --- Load Selected Documents ---
def load_selected_documents(selected_documents: list, db_setting):
    # Connect to the DB to get the Chunks
    conn = psycopg2.connect(
        dbname=db_setting[0],
        user=db_setting[1],
        password=db_setting[2],
        host=db_setting[3],
        port=db_setting[4]
    )

    papers = {}

    for doc in selected_documents:
        id = doc[0]
        title = doc[1]
        author = doc[2]
        tags = doc[4]

        print(f"LOADING {title}")

        # --- Find the Chunks in the database related to the documents using the ID
        cur = conn.cursor()
        cur.execute(f"""SELECT c.*
        FROM chunks AS c
        WHERE c.paper_id = '{id}'
        ORDER BY c.chunk_order ASC;""")

        # --- Build the chunks
        chunks = cur.fetchall()

        chunks_text = [chunk[1] for chunk in chunks]

        text = "\n\n".join(chunks_text)

        # --- Build the Document
        documents = [Document(text=text, metadata={"title": title, "author": author, "tags": tags})]

        # --- Store papers
        papers[title] = documents

    return papers


# --- Build Agents ---
def build_tools(selected_documents, document, llm):
    Settings.llm = llm

    # Split the Context into Chunks
    node_parser = SentenceSplitter(chunk_size=2000, chunk_overlap=400)

    # Build Sub Agents Dictionary
    agents = {}
    query_engines = {}

    all_nodes = []

    for idx, doc in enumerate(selected_documents):
        title = doc[1]

        nodes = node_parser.get_nodes_from_documents(document[title])
        all_nodes.extend(nodes)

        if not os.path.exists(f"./data/{title}"):
            # Build Vector Index
            vector_index = VectorStoreIndex(nodes)
            vector_index.storage_context.persist(
                persist_dir=f"./data/{title}"
            )
        else:
            # Retrieve Vector Index in directory if it exists
            vector_index = load_index_from_storage(
                StorageContext.from_defaults(persist_dir=f"./data/{title}"),
            )

        # build summary index
        # summary_index = SummaryIndex(nodes)
        # Define Query Engines
        vector_query_engine = vector_index.as_query_engine(Settings.llm)
        summary_query_engine = vector_index.as_query_engine(Settings.llm)

        # Define the Tools to be used by the Sub Agents
        query_engine_tools = [
            QueryEngineTool(
                query_engine=vector_query_engine,
                metadata=ToolMetadata(
                    name="vector_tool",
                    description=(
                        f"Useful for questions related to specific aspects of DOCUMENT NUMBER {idx+1}:"
                        f" {title} (e.g. the title, author,"
                        " data, contents, or more)."
                    ),
                ),
            ),

            QueryEngineTool(
                query_engine=summary_query_engine,
                metadata=ToolMetadata(
                    name="summary_tool",
                    description=(
                        f"Useful for any requests that require a holistic summary"
                        f" of EVERYTHING about of DOCUMENT NUMBER {idx+1} which is about {title}. "
                        f"For questions about more specific sections, please use the vector_tool."
                    ),
                ),
            ),
        ]

        # Build the Sub Agents
        function_llm = Settings.llm
        agent = ReActAgent.from_tools(
            query_engine_tools,
            llm=function_llm,
            verbose=True,
            system_prompt=f"""\
                You are a specialized agent designed to answer queries about DOCUMENT {idx+1} {title}.
                You must ALWAYS use at least one of the tools provided when answering a question; do NOT rely on prior knowledge.\
                """,
        )

        agent.update_prompts({"agent_worker:system_prompt": PromptTemplate(sub_agent_prompt)})

        i = f"Document_{idx+1}"
        agents[i] = agent
        query_engines[i] = vector_index.as_query_engine(
            similarity_top_k=5
        )

    # define tool for each document agent
    all_tools = []
    for idx, doc in enumerate(selected_documents):
        title = doc[1]

        doc_summary = (
            f"This content paper about Document {idx+1} which is about the paper {title}."
            f" Use this tool if you want to answer any questions about Document {idx+1}: {title}.\n"
        )

        i = f"Document_{idx+1}"
        doc_tool = QueryEngineTool(
            query_engine=agents[i],
            metadata=ToolMetadata(
                name=f"tool_{i}",
                description=doc_summary,
            ),
        )
        all_tools.append(doc_tool)

    return all_tools



Settings.embed_model = HuggingFaceEmbedding(model_name="sentence-transformers/all-MiniLM-L6-v2")


def agent(query, tools, selected_documents, history, llm):

    Settings.llm = llm
    obj_index = ObjectIndex.from_objects(
        tools,
        index_cls=VectorStoreIndex,
    )

    # Create Context for the Agent
    content = ""
    for idx, doc in enumerate(selected_documents):
        title = doc[1]

        content += f"tool_Document_{idx + 1} that refers to DOCUMENT {idx + 1} with a title of {title}\n"

    context = f"""You are an agent that will help answer queries about a set of documents
        If query is answerable using the CHAT HISTORY, DO NOT USE A TOOL(S) and provide an answer immediately.
    
        If TOOLS ARE NEEDED, 
        Here are some tool you can use:
        {content}

        Each tools also has a vector_tool and a summary_tool 
        
        REMEMBER ANSWER FOR EACH TOOLS AND PROVIDE A FINAL ANSWER AT THE END
        Make sure that the format for the answer of the tools stays the same for the FINAL ANSWER. 
        The FINAL ANSWER should HAVE DOUBLE SPACES AND EASY TO READ.

        ALWAYS USE THE TOOLS for each query, Your knowledge should only accepts information 
        provided by the tools and the chat history,
        If there are no tools that you can use, just reply with I don't know
        """

    top_agent = ReActAgent.from_tools(
        tool_retriever=obj_index.as_retriever(similarity_top_k=3),
        llm= Settings.llm,
        # system_prompt=f""" \
        #         You are an agent designed to answer queries about a set of research papers.
        #         ALWAYS USE THE TOOLS for each query. You are only to rely on information provided by the tools
        #         and the chat history,
        #         Here are some tools you can use. Each tool also has a vector_tool and a summary_tool.
        #         {content}.
        #
        #         REMEMBER ANSWER FOR EACH TOOLS AND PROVIDE A FINAL ANSWER AT THE END
        #         """,
        verbose=True,
        context=context,
    )

    # Update Prompt for the Top Agent
    top_agent.update_prompts({"agent_worker:system_prompt": PromptTemplate(agent_prompt)})

    print(history)

    return top_agent.chat(query, history)
