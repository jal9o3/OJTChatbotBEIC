import streamlit as st
from tweaker import st_tweaker
import fitz  # PyMuPDF
from PIL import Image
from huggingface_hub import InferenceClient
from langchain_community.embeddings import HuggingFaceBgeEmbeddings
from langchain_community.vectorstores import Chroma
import torch

# Open Chat
if "chat_open" not in st.session_state:
    st.session_state.chat_open = False

if not st.session_state.chat_open:
    st.set_page_config(page_title="irayaDocs", layout="wide")
else:
    st.set_page_config(page_title="irayaDocs", layout="centered")

# Selected Paper
if "selected_page" not in st.session_state:
    st.session_state.selected_page = None


# Get Documents from SQL (Title, Author, etc)
def get_documents():

    sample_doc = [
        {"id": 0,
         "title": "A Case Study of Understanding the Bonaparte Basin using Unstructured Data Analysis with Machine Learning Techniques",
         "authors": "Name of Authors",
         "tags": ["Artificial Intelligence", "Machine Learning", "Economy"]},
        {"id": 1,
         "title": "An Automated Information Retrieval Platform For Unstructured Well Data Utilizing Smart Machine Learning Algorithms Within A Hybrid Cloud Container",
         "authors": "Name of Authors",
         "tags": ["Artificial Intelligence"]},
        {"id": 2, "title": " Supporting the UN 2050 Net Zero goals by reading the earth better",
         "authors": "Name of Authors",
         "tags": ["Machine Learning"]},
        {"id": 3,
         "title": " Scaling and optimizing performance and cost of machine learning ingestion on unstructured data for subsurface applications",
         "authors": "Name of Authors",
         "tags": ["Artificial Intelligence", "Machine Learning"]},
        {"id": 4,
         "title": "Sustainable data mining AI_ML-based parameter extraction, data visualization and connectivity to upcycle big-data for basin analysis ",
         "authors": "Name of Authors",
         "tags": ["Machine Learning"]},
        {"id": 5,
         "title": "Utilizing Machine Learning to Gain Geological Insights through Unstructured Data for  Sustainable Exploration Activities",
         "authors": "Name of Authors",
         "tags": ["Machine Learning"]},
        {"id": 6,
         "title": "Double funnel approach for screening of potential CO2 storage opportunities in the Norwegian Continental Shelf",
         "authors": "Name of Authors",
         "tags": [ "Economy"]},
        {"id": 7,
         "title": "Sand Production and Control Benchmarking through Unstructured Data Analysis with Machine Learning in the North Sea",
         "authors": "Name of Authors",
         "tags": ["Machine Learning"]},
        {"id": 8, "title": "Hello World",
         "authors": "Name of Authors",
         "tags": []},
    ]

    return sample_doc


# Function to check if a document's tags match the selected options
def document_matches_options(doc, options):
    return all(tag in doc['tags'] for tag in options)


# Default Page
def load_default():

    # --- Load documents ---
    documents = get_documents()

    max_char_len = 50

    # --- Show Available Documents ---
    with st_tweaker.container(id="main-container"):
        st.title("Available Papers")

        # --- Filter ---
        options = st.multiselect(
            "Filter",
            ["Artificial Intelligence", "Machine Learning", "Economy"],
            [])

        # Filter documents based on selected tags
        filtered_documents = [doc for doc in documents if document_matches_options(doc, options)]

        col1, col2, col3 = st.columns(3)

        for i, doc in enumerate(filtered_documents):
            col = i % 3
            title = doc['title']
            author = doc['authors']
            tags = doc['tags']

            # Truncate title if it exceeds max_char_len and add ellipsis
            title = title[:max_char_len] + ('...' if len(title) > max_char_len else '')

            match col:
                case 0:
                    with col1:
                        with st.container(height=200, border=True):
                            if st.button(f"{title}", type="primary"):
                                st.session_state.chat_open = True
                                st.session_state.selected_page = i
                                st.rerun()
                            st.markdown(author, unsafe_allow_html=True)
                            st.markdown(tags, unsafe_allow_html=True)
                case 1:
                    with col2:
                        with st.container(height=200, border=True):
                            if st.button(f"{title}", type="primary"):
                                st.session_state.chat_open = True
                                st.session_state.selected_page = i
                                st.rerun()
                            st.markdown(author, unsafe_allow_html=True)
                            st.markdown(tags, unsafe_allow_html=True)
                case 2:
                    with col3:
                        with st.container(height=200, border=True):
                            if st.button(f"{title}", type="primary"):
                                st.session_state.chat_open = True
                                st.session_state.selected_page = i
                                st.rerun()
                            st.markdown(author, unsafe_allow_html=True)
                            st.markdown(tags, unsafe_allow_html=True)


# Load Document (Selected Document)
def load_database(index: int, document: list):
    return document[index]


@st.cache_resource
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


if "retrieved_text" not in st.session_state:
    st.session_state.retrieved_text = ""


def retrieve_context(prompt: str, k):
    database_path = "Database2"

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

    text_result = ""
    for result in filtered_results:
        text_result += f"METADATA: {result[0].metadata['source']}\nSCORE: {result[1]}\nContent: {result[0].page_content}\n\n====================================\n\n"

    st.session_state.retrieved_text = text_result

    content = ""
    for i in filtered_results:
        content += f"{i[0].page_content} \n =================== \n"

    prompt_template = f"""
        You are a helpful Assistant,
        you have to be professional on how you answer, provide only the answer that is asked nothing else.

        Answer the question based on the content (if empty, just converse normally):
        If context is provided, 

        Content: {content}

        Answer this question based on the content above: {prompt}
        """

    return prompt_template


# Load View of the PDF
def load_pdf():
    pdf_file_path = "SamplePDF/2021 - A Case Study of Understanding the Bonaparte Basin using Unstructured Data Analysis with Machine Learning Techniques.pdf"

    if pdf_file_path:
        doc = fitz.open(pdf_file_path)
        num_pages = len(doc)

        page_number = st.number_input("", 1, num_pages, 1)

        page = doc.load_page(page_number - 1)
        pix = page.get_pixmap(matrix=fitz.Matrix(2, 2))
        img = Image.frombytes("RGB", [pix.width, pix.height], pix.samples)

        with st.container(border=True, height=500):
            st.image(img, use_column_width=True)

        st_tweaker.markdown(f"Page {page_number} of {num_pages}", id="page_number")


# Load Document Chat
def load_chat():
    client = InferenceClient("microsoft/Phi-3-mini-4k-instruct")

    generation_args = {
        "max_tokens": 400,
        "temperature": 0.5,
    }

    if "messages" not in st.session_state:
        st.session_state.messages = []

    if "messages" not in st.session_state:
        st.session_state.messages = []

    chat_col1, chat_col2 = st.columns(2)

    with chat_col1:
        if st.button("Return"):
            st.session_state.chat_open = False
            st.session_state.messages = []
            st.rerun()

        data = load_database(st.session_state.selected_page, get_documents())
        st.subheader(data['title'])
        st.markdown(data['authors'])

        load_pdf()

    with chat_col2:

        # for message in st.session_state.messages:
        #     with st.chat_message(message['role']):
        #         st.markdown(message['content'])
        #
        # prompt = st.chat_input("What is up?")
        #
        # if prompt:
        #     if prompt == "clear":
        #         st.session_state.messages = []
        #     else:
        #
        #         st.session_state.messages.append({"role": "user", "content": prompt})
        #         st.session_state.messages.append({"role": "assistant", "content": prompt})
        #
        response_container = st_tweaker.container(id="response")

        def printContainer():
            with response_container:
                for message in st.session_state.messages:
                    with st.chat_message(message['role']):
                        st.markdown(message['content'])

        input_container = st.container()

        with input_container:
            prompt = st.chat_input("What's Up")

            if prompt:
                response = "You are welcome"
                st.session_state.messages.append({"role": "user", "content": prompt})
                st.session_state.messages.append({"role": "assistant", "content": response})
                printContainer()


def load_chat2():
    client = InferenceClient("microsoft/Phi-3-mini-4k-instruct")

    generation_args = {
        "max_tokens": 400,
        "temperature": 0.5,
    }

    if "prompt_message" not in st.session_state:
        st.session_state.prompt_message = []

    if "messages" not in st.session_state:
        st.session_state.messages = []

    with st.sidebar:
        st.logo("Logo2.png")
        # if st.button("Return"):
        #     st.session_state.chat_open = False
        #     st.rerun()

        if st.button(label="Return"):
            st.session_state.chat_open = False
            st.session_state.messages = []
            st.session_state.prompt_message = []
            st.rerun()

        data = load_database(st.session_state.selected_page, get_documents())
        st.subheader(data['title'])
        st.markdown(data['authors'])

        load_pdf()

    st.logo("Logo2.png")
    st.write(data['title'])

    for message in st.session_state.messages:
        with st.chat_message(message['role']):
            st.markdown(message['content'])

    prompt = st.chat_input("What is up?")
    if prompt:
        # User Prompt
        with st.chat_message("user"):
            st.markdown(prompt)

        # RAG Implementation
        st.session_state.retrieved_text = retrieve_context(prompt, 3)

        # Add to chat history
        user_input = {"role": "user", "content": prompt}
        st.session_state.messages.append(user_input)

        prompt_AI = f"""A Case Study of Understanding the Bonaparte Basin using Unstructured Data Analysis with Machine Learning Techniques
        {prompt}"""

         # Add to prompt history
        user_prompt = {"role": "user", "content": retrieve_context(prompt_AI, 3)}
        st.session_state.prompt_message.append(user_prompt)

        # Assistant Response
        with st.chat_message("assistant"):
            with st.spinner("Typing..."):
                response = client.chat_completion(st.session_state.prompt_message, **generation_args)

                st.markdown(response.choices[0].message.content)

        # Add to chat history
        assistant_input = {"role": "assistant", "content": response.choices[0].message.content}
        st.session_state.messages.append(assistant_input)
        st.session_state.prompt_message.append(assistant_input)

        st.session_state.prompt_message = []



def main():
    # --- CSS ---
    with open('style_docBase.css') as f:
        st.markdown(f'<style>{f.read()}</style>', unsafe_allow_html=True)

    if not st.session_state.chat_open:
        load_default()
    else:
        load_chat2()


if __name__ == "__main__":
    main()
