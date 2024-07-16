import streamlit as st
import fitz  # PyMuPDF
from PIL import Image
from tweaker import st_tweaker
import chatbot_function as chat

import numpy as np
import random
import torch

from llama_index.core.llms import ChatMessage

import psycopg2

from llama_index.llms.ollama import Ollama

# Setting seeds
np.random.seed(122)
random.seed(122)
torch.manual_seed(122)
if torch.cuda.is_available():
    torch.cuda.manual_seed(122)
    torch.cuda.manual_seed_all(122)

# --- SESSION STATES ---
if "setup_done" not in st.session_state:
    st.session_state.setup_done = False

if "document_select" not in st.session_state:
    st.session_state.document_select = True

if st.session_state.document_select:
    st.set_page_config("Chatbot", layout="wide")
else:
    st.set_page_config("Chatbot", layout="centered")

if "filter" not in st.session_state:
    st.session_state.filter = []

if 'selected_document' not in st.session_state:
    st.session_state.selected_document = []

if 'chat_documents' not in st.session_state:
    st.session_state.chat_documents = None

if 'chat_tools' not in st.session_state:
    st.session_state.chat_tools = []

if 'page' not in st.session_state:
    st.session_state.page = [0, 9]

if 'llm' not in st.session_state:
    st.session_state.llm = None

if 'llm_setting' not in st.session_state:
    st.session_state.llm_setting = [None, "", 0, ""]

if 'db_setting' not in st.session_state:
    st.session_state.db_setting = ["knowledge_base", "postgres", "password", "", "5432"]

if 'database_address' not in st.session_state:
    st.session_state.database_address = ""


# --- Document Selector ---
def select_documents():
    st.title("Select Paper")
    col1, col2 = st.columns([1,3])

    with col1:
        show_selected_documents()
        if st.button("Settings"):
            settings()

    with col2:
        load_documents()


# --- Retrieve Documents from Database ---
@st.cache_data
def get_data_database():
    conn = psycopg2.connect(
        dbname=st.session_state.db_setting[0],
        user=st.session_state.db_setting[1],
        password=st.session_state.db_setting[2],
        host=st.session_state.db_setting[3],
        port=st.session_state.db_setting[4]
    )
    cur = conn.cursor()

    cur.execute("SELECT * FROM paper_titles;")

    documents = cur.fetchall()

    modified_data = []
    for paper in documents:
        list_item = list(paper)  # Convert tuple to list
        list_item[1] = list_item[1].replace("_", " ")  # Replace underscores with spaces in the title
        modified_data.append(list_item)  # Append the modified list to the new list

    return modified_data


def reset():
    st.session_state.page[0] = 0
    st.session_state.page[1] = 9


# --- Document Loader ---
def load_documents():
    with st.container():
        try:
            # --- Load the documents ---
            documents = get_data_database()
        except:
            return error(0)


        with st_tweaker.container(id="document_action"):
            col1, col2, col3 = st.columns(3)

            # --- Filter Option ---
            with col1:
                tags = st.multiselect(
                    " ",
                    ["Artificial Intelligence", "Machine Learning",
                     "Well Completion Report", "Unstructured Data",
                     "Data Analysis", "Climate Change",
                     "Digitalization", "Data Mining",
                     "Waste Management", "Micro Service",
                     "Global Warming", "Data Visualization",
                     "Mining", "Exploration", "Other"],
                    [],placeholder="Filter", on_change=reset)

            # --- Search Option ---
            with col2:
                search = st.text_input(" ")

            # --- Start Chat Option ---
            with col3:
                if st_tweaker.button("Start Chat", id="start_chat"):
                    if st.session_state.llm is None:
                        set_up_llm_popup(0)
                    elif len(st.session_state.selected_document) == 0:
                        warning(0)
                    else:

                        st.session_state.chat_documents = chat.load_selected_documents(
                            st.session_state.selected_document,
                            st.session_state.db_setting
                        )

                        st.session_state.chat_tools = chat.build_tools(
                            st.session_state.selected_document,
                            st.session_state.chat_documents,
                            st.session_state.llm
                        )

                        st.session_state.document_select = False
                        st.rerun()

        # Use the Tags to Filter
        filtered_documents = [doc for doc in documents if filter_documents(doc, tags)]

        # Search for specific Papers
        if search:
            filtered_documents = [doc for doc in filtered_documents if search.lower() in doc[1].lower()]
            st.write(f"Results for '{search}':")

        # Extract IDs of selected items
        selected_ids = {item[0] for item in st.session_state.selected_document}

        # Store only papers that are in the filtered documents and are not in the selected document list
        show_documents = [doc for doc in filtered_documents if doc[0] not in selected_ids]

        # --- Display the documents ---
        col1, col2, col3 = st.columns(3)

        # Pages
        start = st.session_state.page[0]
        end = st.session_state.page[1]

        # Load the documents and show to user (3 columns)
        for i, doc in enumerate(show_documents[start:end]):

            col = i % 3
            title = doc[1]
            author = doc[2]
            tags = doc[4]

            match col:
                case 0:
                    with col1:
                        with st.container(height=200, border=True):
                            if st.button(f"{title}", type="primary"):
                                if len(st.session_state.selected_document) == 3:
                                    warning(1)
                                else:
                                    st.session_state.selected_document.append(doc)
                                    st.rerun()
                            st.markdown(f"<p class = ""additional_info"f">{author}</p>", unsafe_allow_html=True)
                            st.markdown(f"<p class = ""additional_info"f">{tags}</p>", unsafe_allow_html=True)
                case 1:
                    with col2:
                        with st.container(height=200, border=True):
                            if st.button(f"{title}", type="primary"):
                                if len(st.session_state.selected_document) == 3:
                                    warning(1)
                                else:
                                    st.session_state.selected_document.append(doc)
                                    st.rerun()
                            st.markdown(f"<p class = ""additional_info"f">{author}</p>", unsafe_allow_html=True)
                            st.markdown(f"<p class = ""additional_info"f">{tags}</p>", unsafe_allow_html=True)
                case 2:
                    with col3:
                        with st.container(height=200, border=True):
                            if st.button(f"{title}", type="primary"):
                                if len(st.session_state.selected_document) == 3:
                                    warning(1)
                                else:
                                    st.session_state.selected_document.append(doc)
                                    st.rerun()
                            st.markdown(f"<p class = ""additional_info"f">{author}</p>", unsafe_allow_html=True)
                            st.markdown(f"<p class = ""additional_info"f">{tags}</p>", unsafe_allow_html=True)

    pageB1, pageB2, pageB3 = st.columns([4, 1, 1])

    # Previous Page Button
    with pageB2:
        if st.session_state.page[0] == 0:
            st.button("---", disabled=True, key="Back")
        else:
            if st.button("Back", type='secondary'):
                st.session_state.page[1] = st.session_state.page[0]
                st.session_state.page[0] = st.session_state.page[0] - 9
                st.rerun()

    # Next Page Button
    with pageB3:
        if st.session_state.page[1] >= len(filtered_documents):
            st.button("---", disabled=True, key="Next")
        else:
            if st.button("Next"):
                st.session_state.page[0] = st.session_state.page[1]
                st.session_state.page[1] = st.session_state.page[1] + 9
                st.rerun()


# --- Filter Documents ---
def filter_documents(doc, options):
    return all(tag in doc[4] for tag in options)


# --- Show Selected Documents ---
def show_selected_documents():
    with st.container(border=True):

        if st.session_state.document_select:
            st.subheader("Selected Paper")

        # Load / SHow the Selected Documents
        for i in range(len(st.session_state.selected_document)):
            with st_tweaker.container(border=True, id="selected_doc"):
                col1, col2 = st.columns([6, 1])

                with col1:
                    # Limit the max char for the title
                    if st.session_state.document_select:
                        max_chars = 50
                    else:
                        max_chars = 80
                    title = st.session_state.selected_document[i][1]
                    title = title[:max_chars] + ('...' if len(title) > max_chars else '')

                    st.markdown(f"{title}")

                # Remove Selected Document
                if st.session_state.document_select:
                    with col2:
                        if st.button(f"x", key=i,  type="secondary"):
                            del st.session_state.selected_document[i]
                            st.markdown(i)
                            st.rerun()


# --- Load Chat ---
def load_chat():
    # Create Context for the AI Agent
    content = ""
    for idx, doc in enumerate(st.session_state.selected_document):
        title = doc[1]

        content += f"tool_Document_{idx + 1}  that refers to DOCUMENT {idx + 1} with a title of {title}\n"

    # Store Messages
    if "messages" not in st.session_state:
        st.session_state.messages = []

    if "history" not in st.session_state:
        st.session_state.history = []

    # Sidebar
    with st.sidebar:
        # Return to default (document select)
        if st.button("Return", type="primary"):
            reset()
            st.session_state.messages = []
            st.session_state.selected_document = []
            st.session_state.chat_tools = []
            st.session_state.chat_documents = []
            st.session_state.history = []
            st.session_state.document_select = True
            st.rerun()

        # Show selected documents
        if len(st.session_state.selected_document) > 0:
            with st.expander("Show Selected Documents", expanded=True):
                show_selected_documents()

        # Allow user to select documents if no documents are selected
        if len(st.session_state.selected_document) == 0:
            if st.button("Select Paper", type="primary"):
                st.session_state.document_select = True
                st.rerun()

    try:
        # Print messages from the history
        for message in st.session_state.messages:
            with st.chat_message(message['role']):
                st.markdown(message['content'])

        # Enter prompt
        prompt = st.chat_input("What's Up")

        if prompt:
            # Show user prompt
            with st.chat_message("user"):
                st.markdown(prompt)

            # Store to history
            user_input = {"role": "user", "content": prompt}
            st.session_state.messages.append(user_input)
            st.session_state.history.append(ChatMessage.from_str(prompt, "user"))

            # Show AI response
            with st.chat_message("assistant"):
                with st.spinner("Thinking"):
                    # Call AI Agent to create response
                    response = chat.agent(prompt, st.session_state.chat_tools,
                                          st.session_state.selected_document,
                                          st.session_state.history,
                                          st.session_state.llm)
                    st.markdown(response)

            # Store AI Response
            ai_response = {"role": "assistant", "content": response}
            st.session_state.messages.append(ai_response)
            st.session_state.history.append(ChatMessage.from_str(str(response), "assistant"))
    except:
        st.session_state.messages.pop()
        st.session_state.history.pop()
        if st.session_state.llm_setting[0] == "Locally":
            return llm_error(1)
        else:
            return llm_error(2)


# Set up the LLM
def set_up_llm(code):
    st.title("Setup OLLAMA")

    # Method of Running List
    method = ["Locally", "API (Ngrok + Google Colab)"]

    selected_method = st.selectbox(
        "How would you like to run your OLLAMA Model?",
        method,
        index=st.session_state.llm_setting[0],
        placeholder="Select method...",
    )

    url = ""
    if selected_method == "API (Ngrok + Google Colab)":
        url = st.text_input("URL for API", st.session_state.llm_setting[1])

    # Large Language Model List
    models = ["llama3"]

    selected_model = ""
    if selected_method == "Locally" or (selected_method == "API (Ngrok + Google Colab)" and url != ""):
        selected_model = st.selectbox(
            "Select Local Model",
            models,
            index=st.session_state.llm_setting[2],
            placeholder="Select Language Model",
        )

    if code == 0:
        action = "Setup"
    else:
        action = "Retry"

    if selected_model in models:
        if selected_method == "Locally":
            if st.button(action):
                # Load Model and Embeddings
                llm = Ollama(
                    model=selected_model,
                    request_timeout=200.0,
                    temperature=0.2,
                )
                st.session_state.llm = llm

                st.session_state.llm_setting[0] = method.index(selected_method)
                st.session_state.llm_setting[2] = models.index(selected_model)

                st.rerun()
        else:
            if st.button(action):
                # Load Model and Embeddings
                llm = Ollama(
                    model=selected_model,
                    base_url=url,
                    request_timeout=200.0,
                    temperature=0.2,
                )

                st.session_state.llm = llm

                st.session_state.llm_setting[0] = method.index(selected_method)
                st.session_state.llm_setting[1] = url
                st.session_state.llm_setting[2] = models.index(selected_model)

                print(url)

                st.rerun()


@st.experimental_dialog(" ")
def set_up_llm_popup(code):
    set_up_llm(code)


def setup_database():
    st.title("Setup Database")
    st.text_input()


# --- Initial Setup ---
def initial_setup():
    st.title("Initial Setup")

    col1, col2 = st.columns(2)

    with col1:
        st.divider()

        st.subheader("DATABASE SETTINGS")

        db_name = st.text_input("Database Name", st.session_state.db_setting[0])
        user = st.text_input("User", st.session_state.db_setting[1])
        password = st.text_input("Password", st.session_state.db_setting[2])
        db_address = st.text_input("Database Container Address", st.session_state.db_setting[3])
        port = st.text_input("Port", st.session_state.db_setting[4])

        st.divider()

    with col2:
        st.divider()
        st.subheader("OLLAMA SETTINGS")

        # Method of Running List
        method = ["Locally", "API (Ngrok + Google Colab)"]

        selected_method = st.selectbox(
            "How would you like to run your OLLAMA Model?",
            method,
            index=st.session_state.llm_setting[0],
            placeholder="Select method...",
        )

        url = ""
        if selected_method == "API (Ngrok + Google Colab)":
            url = st.text_input("URL for API", st.session_state.llm_setting[1])

        # Large Language Model List
        models = ["llama3"]

        selected_model = ""
        if selected_method == "Locally" or (selected_method == "API (Ngrok + Google Colab)" and url != ""):
            selected_model = st.selectbox(
                "Select Local Model",
                models,
                index=st.session_state.llm_setting[2],
                placeholder="Select Language Model",
            )

        if selected_model in models:
            if selected_method == "Locally":
                if st.button("Setup", key="setup1"):
                    if not all([db_name, user, password, db_address, port]):
                        st.toast("Please fill in all fields.")
                    else:
                        # Load Model and Embeddings
                        llm = Ollama(
                            model=selected_model,
                            request_timeout=200.0,
                            temperature=0.2,
                        )
                        st.session_state.llm = llm

                        # Set the Database Settings
                        st.session_state.db_setting[0] = db_name
                        st.session_state.db_setting[1] = user
                        st.session_state.db_setting[2] = password
                        st.session_state.db_setting[3] = db_address
                        st.session_state.db_setting[4] = port

                        # Set the LLM Settings
                        st.session_state.llm_setting[0] = method.index(selected_method)
                        st.session_state.llm_setting[2] = models.index(selected_model)

                        st.session_state.setup_done = True
                        st.rerun()
            else:
                if st.button("Setup", key="setup2"):
                    if not all([db_name, user, password, db_address, port, url]):
                        st.toast("Please fill in all fields.")
                    else:
                        # Load Model and Embeddings
                        llm = Ollama(
                            model=selected_model,
                            base_url=url,
                            request_timeout=200.0,
                            temperature=0.2,
                        )

                        st.session_state.llm = llm

                        # Set the Database Settings
                        st.session_state.db_setting[0] = db_name
                        st.session_state.db_setting[1] = user
                        st.session_state.db_setting[2] = password
                        st.session_state.db_setting[3] = db_address
                        st.session_state.db_setting[4] = port

                        # Set the LLM Settings
                        st.session_state.llm_setting[0] = method.index(selected_method)
                        st.session_state.llm_setting[1] = url
                        st.session_state.llm_setting[2] = models.index(selected_model)

                        st.session_state.setup_done = True
                        st.rerun()


@st.experimental_dialog(" ")
def settings():
    st.title("Settings")
    with st.expander("Database Settings"):
        db_name = st.text_input("Database Name", st.session_state.db_setting[0])
        user = st.text_input("User", st.session_state.db_setting[1])
        password = st.text_input("Password", st.session_state.db_setting[2])
        db_address = st.text_input("Database Container Address", st.session_state.db_setting[3])
        port = st.text_input("Port", st.session_state.db_setting[4])

    with st.expander("LLM Settings"):
        # Method of Running List
        method = ["Locally", "API (Ngrok + Google Colab)"]

        selected_method = st.selectbox(
            "How would you like to run your OLLAMA Model?",
            method,
            index=st.session_state.llm_setting[0],
            placeholder="Select method...",
        )

        url = ""
        if selected_method == "API (Ngrok + Google Colab)":
            url = st.text_input("URL for API", st.session_state.llm_setting[1])

        # Large Language Model List
        models = ["llama3"]

        selected_model = ""
        if selected_method == "Locally" or (selected_method == "API (Ngrok + Google Colab)" and url != ""):
            selected_model = st.selectbox(
                "Select Local Model (Preferably use llama3)",
                models,
                index=st.session_state.llm_setting[2],
                placeholder="Select Language Model",
            )

    if st.button("Save"):
        if selected_method == "Locally":
            if not all([db_name, user, password, db_address, port]):
                st.toast("Please fill in all fields.")
            else:
                # Load Model and Embeddings
                llm = Ollama(
                    model=selected_model,
                    request_timeout=200.0,
                    temperature=0.2,
                )
                st.session_state.llm = llm

                # Set the Database Settings
                st.session_state.db_setting[0] = db_name
                st.session_state.db_setting[1] = user
                st.session_state.db_setting[2] = password
                st.session_state.db_setting[3] = db_address
                st.session_state.db_setting[4] = port

                # Set the LLM Settings
                st.session_state.llm_setting[0] = method.index(selected_method)
                st.session_state.llm_setting[2] = models.index(selected_model)

                st.session_state.setup_done = True
                st.rerun()
        else:
            if not all([db_name, user, password, db_address, port]):
                st.toast("Please fill in all fields.")
            else:
                # Load Model and Embeddings
                llm = Ollama(
                    model=selected_model,
                    base_url=url,
                    request_timeout=200.0,
                    temperature=0.2,
                )

                st.session_state.llm = llm

                # Set the Database Settings
                st.session_state.db_setting[0] = db_name
                st.session_state.db_setting[1] = user
                st.session_state.db_setting[2] = password
                st.session_state.db_setting[3] = db_address
                st.session_state.db_setting[4] = port

                # Set the LLM Settings
                st.session_state.llm_setting[0] = method.index(selected_method)
                st.session_state.llm_setting[1] = url
                st.session_state.llm_setting[2] = models.index(selected_model)

                st.session_state.setup_done = True
                st.rerun()


# --- Error Information ---
def error(code):
    e1, e2, e3 = st.columns([1, 3, 1])

    if code == 0:
        st.title("Error: Unable to Retrieve Data")
        st.subheader("We encountered an issue while trying to access the data.")
        st.write("Please verify the following:")
        st.write("- The database container is exists.")
        st.write("- The database container is running.")
        st.write("- You have inputted the right database information")
        col1, col2 = st.columns(2)

        with col1:
            db_name = st.text_input("Database Name", st.session_state.db_setting[0])
            user = st.text_input("User", st.session_state.db_setting[1])
            password = st.text_input("Password", st.session_state.db_setting[2])

        with col2:
            db_address = st.text_input("Database Container Address", st.session_state.db_setting[3])
            port = st.text_input("Port", st.session_state.db_setting[4])

        st.write("- Your network connection is stable.")
        st.write("- All required services are operational.")
        st.write("If the issue persists, please refer to the manual.")
        if st.button("Retry"):
            # Set the Database Settings
            st.session_state.db_setting[0] = db_name
            st.session_state.db_setting[1] = user
            st.session_state.db_setting[2] = password
            st.session_state.db_setting[3] = db_address
            st.session_state.db_setting[4] = port
            st.rerun()
    elif code == 1:
        st.title("Error: Large Language Model")
        st.subheader("We encountered an error while communicating with the LLM Locally.")
        st.write("Please verify the following:")
        st.write("- OLLAMA is Installed.")
        st.write("- OLLAMA is Running.")
        st.write("- Model has been Installed")
        st.write("- All required services are operational.")
        st.write("If the issue persists, please refer to the manual.")
    else:
        st.title("Error: Large Language Model")
        st.subheader("We encountered an error while communicating with the OLLAMA API.")
        st.write("Please verify the following:")
        st.write("- Google Colab is Running.")
        st.write("- Ngrok Host is Running.")
        st.write("- URL is Correct")
        st.write("- Model has been Installed.")
        st.write("- Your network connection is stable.")
        st.write("- All required services are operational.")
        st.write("Please refer to the manual.")


@st.experimental_dialog(" ")
def llm_error(code):
    st.markdown('<style>div[data-testid="stModal"] div[tabindex="-1"]{'
                'display: flex; '
                'flex-direction: column ;'
                'justify-content: start;'
                'width: 50%;'
                'background-color:var(--lighter);'
                'box-shadow: 10px 10px 10px black;}</style>', unsafe_allow_html=True)

    c1, c2 = st.columns([2, 1])

    with c1:
        error(code)
    with c2:
        set_up_llm(1)


@st.experimental_dialog(" ")
def warning(mode):
    # --- CSS ---
    st.markdown('<style>div[data-testid="stModal"] div[tabindex="-1"]{'
                'display: flex; '
                'flex-direction: column ;'
                'justify-content: start;'
                'width: auto;'
                'background-color:var(--lighter);'
                'box-shadow: 10px 10px 10px black;}</style>', unsafe_allow_html=True)

    if mode == 0:
        st.subheader("No Paper has been selected")
        st.markdown("Please select a paper first")

        col1, col2 = st.columns(2)

        with col2:
            if st.button("Return"):
                st.rerun()
        # with col2:
        #     if st.button("Continue"):
        #         st.session_state.document_select = False
        #         st.rerun()
    else:
        st.subheader("Maximum Number of Document Reached")
        st.markdown("The maximum number of document is 3")

        col1, col2 = st.columns(2)

        with col2:
            if st.button("Return"):
                st.rerun()
        # with col2:
        #     if st.button("Continue"):
        #         st.session_state.document_select = False
        #         st.rerun()


def main():

    # documents = get_data_database()
    # for doc in documents:
    #     print(doc[1])

    if not st.session_state.setup_done:
        # --- CSS ---
        with open('style.css') as f:
            st.markdown(f'<style>{f.read()}</style>', unsafe_allow_html=True)

        col1, col2, col3= st.columns([1,5,1])

        with col2:
            initial_setup()



    else:
        if st.session_state.document_select:
            # --- CSS ---
            with open('style.css') as f:
                st.markdown(f'<style>{f.read()}</style>', unsafe_allow_html=True)

            select_documents()
        else:
            # --- CSS ---
            with open('style_chat.css') as f:
                st.markdown(f'<style>{f.read()}</style>', unsafe_allow_html=True)

            load_chat()


if __name__ == "__main__":
    main()