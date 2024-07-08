from huggingface_hub import InferenceClient
from langchain_community.embeddings import HuggingFaceBgeEmbeddings
from langchain_community.vectorstores import Chroma
import torch
import os

from llama_index.llms.ollama import Ollama
from llama_index.embeddings.huggingface import HuggingFaceEmbedding
from llama_index.core import Settings

from llama_index.core import (
    VectorStoreIndex,
    SimpleKeywordTableIndex,
    SimpleDirectoryReader,
)

from llama_index.core import SummaryIndex
from llama_index.core.schema import IndexNode
from llama_index.core.tools import QueryEngineTool, ToolMetadata
from llama_index.core.callbacks import CallbackManager

from llama_index.core import load_index_from_storage, StorageContext
from llama_index.core.node_parser import SentenceSplitter
import os
from llama_index.core.agent import ReActAgent

from llama_index.core.objects import ObjectIndex



# def get_documents():
#
#     sample_doc = [
#         {"id": 0,
#          "title": "A Case Study of Understanding the Bonaparte Basin using Unstructured Data Analysis with Machine Learning Techniques",
#          "authors": "A.N.N. Sazali, N.M. Hernandez, F. Baillard, K.G. Maver",
#          "tags": ["Artificial Intelligence", "Machine Learning", "Economy"],
#          "file_name": "2021 - A Case Study of Understanding the Bonaparte Basin using Unstructured Data Analysis with Machine Learning Techniques.pdf"},
#
#         {"id": 1,
#          "title": "An Automated Information Retrieval Platform For Unstructured Well Data Utilizing Smart Machine Learning Algorithms Within A Hybrid Cloud Container",
#          "authors": "N.M. Hernandez, P.J. Lucafias', J.C. Graciosa', C. Mamador, L. Caezar', I. Panganiban, C. Yu', K.G",
#          "tags": ["Artificial Intelligence"],
#          "file_name": "2021 - An Automated Information Retrieval Platform For Unstructured Well Data Utilizing Smart Machine Learning Algorithms Within A Hybrid Cloud Container.pdf"},
#
#         {"id": 2, "title": " Supporting the UN 2050 Net Zero goals by reading the earth better",
#          "authors": "Nina Marie Hernandez, Kim Gunn Maver and Charmyne Mamador",
#          "tags": ["Machine Learning"],
#          "file_name": "2021 - Supporting the UN 2050 Net Zero goals by reading the earth better.pdf"},
#
#         {"id": 3,
#          "title": "Scaling and optimizing performance and cost of machine learning ingestion on unstructured data for subsurface applications",
#          "authors": "L.C.L. Panganiban, F. Baillard', N.M. Hernandez!",
#          "tags": ["Artificial Intelligence", "Machine Learning"],
#          "file_name": "2022 - Scaling and optimizing performance and cost of machine learning ingestion on unstructured data for subsurface applications.pdf"},
#     ]
#
#     return sample_doc



os.environ['HF_API_KEY'] = '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'

# Set the seed
torch.manual_seed(42)

def get_embedding():
    model_name = "sentence-transformers/all-MiniLM-L6-v2"
    encode_kwargs = {"normalize_embeddings": True}

    # Check if GPU is available and set the device accordingly
    device = "cuda" if torch.cuda.is_available() else "cpu"
    model_kwargs = {"device": device}

    # Initialize the HuggingFaceBgeEmbeddings with the model name and kwargs
    hf = HuggingFaceBgeEmbeddings(
        model_name=model_name, model_kwargs=model_kwargs, encode_kwargs=encode_kwargs
    )

    return hf


def retrieve_context(prompt: str, k):
    database_path = "Whole_Data"

    # Prepare the DB
    embedding = get_embedding()
    db = Chroma(
        persist_directory=database_path,
        embedding_function=embedding
    )

    # Search the DB.
    results = db.similarity_search_with_score(prompt, k)

    # Filter results with score <= 1
    filtered_results = [(chunk, score) for chunk, score in results if score <= 1.4]

    content = ""
    for i in filtered_results:
        content += f"{i[0].page_content} \n =================== \n"

    prompt_template = f"""
        You are a helpful Assistant,
        you have to be professional on how you answer, provide only the answer that is asked nothing else.
        Your response should be easy to read.

        You are to use the content if necessary. If the content is unrelated to the prompt or question, then converse normally.
        Do not use the content when the it is unrelated and not necessary to the prompt of the user.

        For example:
            user: -- instruction from user --
                  -- Random Content From System --
                  -- Answer this question based on the content above: Hello --
            assistant: Hello what can I do for you.

        When replying, you are not allowed to say "base from the content" or anything similar, as it lowers the confidence of the response.

        This is thecd Content from the Retrieval Augmented Generation System:

        Content: {content}

        Answer this question based on the content above: {prompt}
        """

    return prompt_template


def response(message: list):
    client = InferenceClient("mistralai/Mistral-7B-Instruct-v0.3")

    generation_args = {
        "max_tokens": 400,
        "temperature": 0.5,
    }

    output = client.chat_completion(message, **generation_args)

    return output.choices[0].message.content


# --- Load Selected Documents ---
def load_selected_documents(selected_documents: list):

    for doc in selected_documents:
        doc['file_name'] = doc['file_name'].replace('.pdf', '.txt')

    papers = {}
    for doc in selected_documents:
        print(f"Loading File: {doc['title']}")
        papers[doc["title"]] = SimpleDirectoryReader(
            input_files=[f"data/{doc["file_name"]}"]
        ).load_data()

    return papers


# --- Build Agents ---
def build_tools(selected_documents, document):
    node_parser = SentenceSplitter()

    # Build agents dictionary
    agents = {}
    query_engines = {}

    # this is for the baseline
    all_nodes = []

    for idx, doc in enumerate(selected_documents):
        nodes = node_parser.get_nodes_from_documents(document[doc['title']])
        all_nodes.extend(nodes)

        if not os.path.exists(f"./data/{doc['title']}"):
            # build vector index
            vector_index = VectorStoreIndex(nodes)
            vector_index.storage_context.persist(
                persist_dir=f"./data/{doc['title']}"
            )
        else:
            vector_index = load_index_from_storage(
                StorageContext.from_defaults(persist_dir=f"./data/{doc['title']}"),
            )

        # build summary index
        summary_index = SummaryIndex(nodes)
        # define query engines
        vector_query_engine = vector_index.as_query_engine(llm=Settings.llm)
        summary_query_engine = vector_index.as_query_engine(llm=Settings.llm)

        # define tools
        query_engine_tools = [
            QueryEngineTool(
                query_engine=vector_query_engine,
                metadata=ToolMetadata(
                    name="vector_tool",
                    description=(
                        f"Useful for questions related to specific aspects of DOCUMENT NUMBER {idx+1}:"
                        f" {doc['title']} (e.g. the title, author,"
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
                        f" of EVERYTHING about of DOCUMENT NUMBER {idx+1} which is about {doc['title']}. "
                        f"For questions about more specific sections, please use the vector_tool."
                    ),
                ),
            ),
        ]

        # build agent
        function_llm = Settings.llm
        agent = ReActAgent.from_tools(
            query_engine_tools,
            llm=function_llm,
            verbose=True,
            system_prompt=f"""\
    You are a specialized agent designed to answer queries about DOCUMENT {idx+1} {doc['title']}.
    You must ALWAYS use at least one of the tools provided when answering a question; do NOT rely on prior knowledge.\
    """,
        )

        i = f"Document_{idx+1}"
        agents[i] = agent
        query_engines[i] = vector_index.as_query_engine(
            similarity_top_k=2
        )

    # define tool for each document agent
    all_tools = []
    for idx, doc in enumerate(selected_documents):
        wiki_summary = (
            f"This content paper about Document {idx+1} which is about the paper {doc['title']}."
            f" Use this tool if you want to answer any questions about Document {idx+1}: {doc['title']}.\n"
        )

        i = f"Document_{idx+1}"
        doc_tool = QueryEngineTool(
            query_engine=agents[i],
            metadata=ToolMetadata(
                name=f"tool_{i}",
                description=wiki_summary,
            ),
        )
        all_tools.append(doc_tool)

    return all_tools


# Load Model and Embeddings
llm = Ollama(
    model="mistral",
    base_url="https://9788-35-197-25-42.ngrok-free.app",
    request_timeout=200.0
)

Settings.llm = llm
Settings.embed_model = HuggingFaceEmbedding(model_name="sentence-transformers/all-MiniLM-L6-v2")


def agent(query, tools, selected_documents):
    obj_index = ObjectIndex.from_objects(
        tools,
        index_cls=VectorStoreIndex,
    )

    content = ""
    for idx, doc in enumerate(selected_documents):
        content += f"tool_Document_{idx + 1} that refers to DOCUMENT {idx + 1} with a title of {doc['title']}\n"

    context = f"""You are an agent that will help answer queries about a set of documents
        Here are some tool you can use:
        {content}

        Each tools also has a vector_tool and a summary_tool 

        ALWAYS USE THE TOOLS for each query, even if you have prior knowledge. Do not rely on prior knowledge.
        If there are no tools that you can use, just reply with I don't know
        """

    top_agent = ReActAgent.from_tools(
        tool_retriever=obj_index.as_retriever(similarity_top_k=3),
        system_prompt=f""" \
            You are an agent designed to answer queries about a set of research papers.
            ALWAYS USE THE TOOLS for each query, even if you have prior knowledge. Do not rely on prior knowledge.
            Here are some tools you can use. Each tool also has a vector_tool and a summery_tool 
            {content}.
            """,
        verbose=True,
        context=context
    )

    return top_agent.chat(query)


# def main():
#     selected = get_documents()
#
#     # for doc in selected:
#     #     doc['file_name'] = doc['file_name'].replace('.pdf', '.txt')
#     #     print(doc['file_name'])
#
#     # documents = load_selected_documents(selected)
#     #
#     # tools = build_tools(selected, documents)
#
#     # print(tools)
#     #
#     # obj_index = ObjectIndex.from_objects(
#     #     tools,
#     #     index_cls=VectorStoreIndex,
#     # )
#     #
#     # content = ""
#     # for idx, doc in enumerate(get_documents()):
#     #     content += f"tool_Document_{idx+1} that refers to DOCUMENT {idx + 1} with a title of {doc['title']}\n"
#     #
#     # context = f"""You are an agent that will help answer queries about a set of documents
#     # Here are some tool you can use:
#     # {content}
#     #
#     # Each tools also has a vector_tool and a summary_tool
#     #
#     # ALWAYS USE THE TOOLS for each query, even if you have prior knowledge. Do not rely on prior knowledge.
#     # If there are no tools that you can use, just reply with I don't know
#     # """
#     #
#     # top_agent = ReActAgent.from_tools(
#     #     tool_retriever=obj_index.as_retriever(similarity_top_k=1),
#     #     system_prompt=f""" \
#     #     You are an agent designed to answer queries about a set of research papers.
#     #     ALWAYS USE THE TOOLS for each query, even if you have prior knowledge. Do not rely on prior knowledge.
#     #     Here are some tools you can use. Each tool also has a vector_tool and a summery_tool
#     #     {content}.
#     #     """,
#     #     verbose=True,
#     #     context=context
#     # )
#     #
#     # while True:
#     #     query = input("You: ")
#     #     answer = agent(query, tools)
#     #     print(answer)


#
# if __name__ == "__main__":
#     main()