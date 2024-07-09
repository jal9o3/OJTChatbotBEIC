import streamlit as st
import fitz  # PyMuPDF
from PIL import Image
from tweaker import st_tweaker
import chatbot_function as chat

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


# --- Document Selector ---
def select_documents():
    st.title("Select Paper")
    col1, col2 = st.columns([1,3])

    with col1:
        show_selected_documents()
    with col2:
        load_documents()


# --- Retrieve Documents ---
def get_documents():

    sample_doc = [
        {"id": 0,
         "title": "A Case Study of Understanding the Bonaparte Basin using Unstructured Data Analysis with Machine Learning Techniques",
         "authors": "Name of Authors",
         "tags": ["Artificial Intelligence", "Machine Learning", "Economy"],
         "file_name": "2021 - A Case Study of Understanding the Bonaparte Basin using Unstructured Data Analysis with Machine Learning Techniques.pdf"},

        {"id": 1,
         "title": "An Automated Information Retrieval Platform For Unstructured Well Data Utilizing Smart Machine Learning Algorithms Within A Hybrid Cloud Container",
         "authors": "Name of Authors",
         "tags": ["Artificial Intelligence"],
         "file_name": "2021 - An Automated Information Retrieval Platform For Unstructured Well Data Utilizing Smart Machine Learning Algorithms Within A Hybrid Cloud Container.pdf"},

        {"id": 2, "title": " Supporting the UN 2050 Net Zero goals by reading the earth better",
         "authors": "Name of Authors",
         "tags": ["Machine Learning"],
         "file_name": "2021 - Supporting the UN 2050 Net Zero goals by reading the earth better.pdf"},

        {"id": 3,
         "title": "Scaling and optimizing performance and cost of machine learning ingestion on unstructured data for subsurface applications",
         "authors": "Name of Authors",
         "tags": ["Artificial Intelligence", "Machine Learning"],
         "file_name": "2022 - Scaling and optimizing performance and cost of machine learning ingestion on unstructured data for subsurface applications.pdf"},

        {"id": 5,
         "title": "Utilizing Machine Learning to Gain Geological Insights through Unstructured Data for  Sustainable Exploration Activities",
         "authors": "Name of Authors",
         "tags": ["Machine Learning"],
         "file_name": "2022 - Utilizing Machine Learning to Gain Geological Insights through Unstructured Data for  Sustainable Exploration Activities.pdf"},

        {"id": 6,
         "title": "Double funnel approach for screening of potential CO2 storage opportunities in the Norwegian Continental Shelf",
         "authors": "Name of Authors",
         "tags": [ "Economy"],
         "file_name": "2023 - Double funnel approach for screening of potential CO2 storage opportunities in the Norwegian Continental Shelf.pdf"},

        {"id": 7,
         "title": "Sand Production and Control Benchmarking through Unstructured Data Analysis with Machine Learning in the North Sea",
         "authors": "Name of Authors",
         "tags": ["Machine Learning"],
         "file_name": "2023 - Sand Production and Control Benchmarking through Unstructured Data Analysis with Machine Learning in the North Sea.pdf"},

        {"id": 8,
         "title": "A dsadsaanding the Bonaparte Basin using Unstructured Data Analysis with Machine Learning Techniques",
         "authors": "Name of Authors",
         "tags": ["Artificial Intelligence", "Machine Learning", "Economy"],
         "file_name": "2021 - A Case Study of Understanding the Bonaparte Basin using Unstructured Data Analysis with Machine Learning Techniques.pdf"},

        {"id": 9,
         "title": "A Cdsadasing the Bonaparte Basin using Unstructured Data Analysis with Machine Learning Techniques",
         "authors": "Name of Authors",
         "tags": ["Artificial Intelligence", "Machine Learning", "Economy"],
         "file_name": "2021 - A Case Study of Understanding the Bonaparte Basin using Unstructured Data Analysis with Machine Learning Techniques.pdf"},

        {"id": 10,
         "title": "Asdas",
         "authors": "Name of Authors",
         "tags": ["Artificial Intelligence", "Machine Learning", "Economy"],
         "file_name": "2021 - A Case Study of Understanding the Bonaparte Basin using Unstructured Data Analysis with Machine Learning Techniques.pdf"},

        {"id": 11,
         "title": "Asdass",
         "authors": "Name of Authors",
         "tags": ["Artificial Intelligence", "Machine Learning", "Economy"],
         "file_name": "2021 - A Case Study of Understanding the Bonaparte Basin using Unstructured Data Analysis with Machine Learning Techniques.pdf"},

        {"id": 12,
         "title": "Asdasds",
         "authors": "Name of Authors",
         "tags": ["Artificial Intelligence", "Machine Learning", "Economy"],
         "file_name": "2021 - A Case Study of Understanding the Bonaparte Basin using Unstructured Data Analysis with Machine Learning Techniques.pdf"},

        {"id": 13,
         "title": "Asdsadsadas",
         "authors": "Name of Authors",
         "tags": ["Artificial Intelligence", "Machine Learning", "Economy"],
         "file_name": "2021 - A Case Study of Understanding the Bonaparte Basin using Unstructured Data Analysis with Machine Learning Techniques.pdf"},

        {"id": 14,
         "title": "Asdsadsdas",
         "authors": "Name of Authors",
         "tags": ["Artificial Intelligence", "Machine Learning", "Economy"],
         "file_name": "2021 - A Case Study of Understanding the Bonaparte Basin using Unstructured Data Analysis with Machine Learning Techniques.pdf"},

        {"id": 15,
         "title": "Adsadsadassdas",
         "authors": "Name of Authors",
         "tags": ["Artificial Intelligence", "Machine Learning", "Economy"],
         "file_name": "2021 - A Case Study of Understanding the Bonaparte Basin using Unstructured Data Analysis with Machine Learning Techniques.pdf"},

        {"id": 16,
         "title": "Asddsadsadsaas",
         "authors": "Name of Authors",
         "tags": ["Artificial Intelligence", "Machine Learning", "Economy"],
         "file_name": "2021 - A Case Study of Understanding the Bonaparte Basin using Unstructured Data Analysis with Machine Learning Techniques.pdf"},

        {"id": 17,
         "title": "Asddsddddddas",
         "authors": "Name of Authors",
         "tags": ["Artificial Intelligence", "Machine Learning", "Economy"],
         "file_name": "2021 - A Case Study of Understanding the Bonaparte Basin using Unstructured Data Analysis with Machine Learning Techniques.pdf"},

        {"id": 18,
         "title": "Asddsdddddddddddddas",
         "authors": "Name of Authors",
         "tags": ["Artificial Intelligence", "Machine Learning", "Economy"],
         "file_name": "2021 - A Case Study of Understanding the Bonaparte Basin using Unstructured Data Analysis with Machine Learning Techniques.pdf"},

        {"id": 19,
         "title": "Asddsdddddddsasdsadasadsadsas",
         "authors": "Name of Authors",
         "tags": ["Artificial Intelligence", "Machine Learning", "Economy"],
         "file_name": "2021 - A Case Study of Understanding the Bonaparte Basin using Unstructured Data Analysis with Machine Learning Techniques.pdf"},
    ]

    return sample_doc


def reset():
    st.session_state.page[0] = 0
    st.session_state.page[1] = 9

# --- Document Loader ---
def load_documents():
    with st.container():
        # --- Load the documents ---
        documents = get_documents()


        with st_tweaker.container(id="document_action"):
            col1, col2, col3 = st.columns(3)

            # --- Filter Option ---
            with col1:
                tags = st.multiselect(
                    " ",
                    ["Artificial Intelligence", "Machine Learning", "Economy"],
                    [],placeholder="Filter", on_change=reset)

            # --- Search Option ---
            with col2:
                search = st.text_input(" ")

            # --- Start Chat Option ---
            with col3:
                if st_tweaker.button("Start Chat", id="start_chat"):
                    if len(st.session_state.selected_document) == 0:
                        warning(0)
                    else:

                        st.session_state.chat_documents = chat.load_selected_documents(
                            st.session_state.selected_document
                        )
                        st.session_state.chat_tools = chat.build_tools(
                            st.session_state.selected_document,
                            st.session_state.chat_documents
                        )
                        st.session_state.document_select = False
                        st.rerun()

        # Use the Tags to Filter
        filtered_documents = [doc for doc in documents if filter_documents(doc, tags)]

        # Search for specific Papers
        if search:
            filtered_documents = [doc for doc in filtered_documents if search.lower() in doc['title'].lower()]
            st.write(f"Results for '{search}':")

        # Extract IDs of selected items
        selected_ids = {item['id'] for item in st.session_state.selected_document}

        # Store only papers that are in the filtered documents and are not in the selected document list
        show_documents = [doc for doc in filtered_documents if doc['id'] not in selected_ids]

        # --- Display the documents ---
        col1, col2, col3 = st.columns(3)

        start = st.session_state.page[0]
        end = st.session_state.page[1]
        for i, doc in enumerate(show_documents[start:end]):

            col = i % 3
            title = doc['title']
            author = doc['authors']
            tags = doc['tags']

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
                                    # st.session_state.selected_document.append(filtered_documents[i])
                                    # st.rerun()
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
                                    # st.session_state.selected_document.append(filtered_documents[i])
                                    # st.rerun()
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
                                    # st.session_state.selected_document.append(filtered_documents[i])
                                    # st.rerun()
                            st.markdown(f"<p class = ""additional_info"f">{author}</p>", unsafe_allow_html=True)
                            st.markdown(f"<p class = ""additional_info"f">{tags}</p>", unsafe_allow_html=True)

    pageB1, pageB2, pageB3 = st.columns([4,1,1])

    with pageB2:
        if st.session_state.page[0] == 0:
            st.button("---", disabled=True, key="Back")
        else:
            if st.button("Back", type='secondary'):
                st.session_state.page[1] = st.session_state.page[0]
                st.session_state.page[0] = st.session_state.page[0] - 9
                st.rerun()
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
    return all(tag in doc['tags'] for tag in options)


# --- Show Selected Documents ---
def show_selected_documents():
    with st.container(border=True):

        if st.session_state.document_select:
            st.subheader("Selected Paper")

        for i in range(len(st.session_state.selected_document)):
            with st_tweaker.container(border=True, id="selected_doc"):
                col1, col2 = st.columns([6,1])

                with col1:

                    if st.session_state.document_select:
                        max_chars = 50
                    else:
                        max_chars = 80
                    title = st.session_state.selected_document[i]['title']
                    title = title[:max_chars] + ('...' if len(title) > max_chars else '')

                    st.markdown(f"{title}")

                if st.session_state.document_select:
                    with col2:
                        if st.button(f"x", key=i,  type="secondary"):
                            del st.session_state.selected_document[i]
                            st.markdown(i)
                            st.rerun()


# --- Load PDF View ---
@st.experimental_dialog("Paper Info")
def load_pdf(document):
    col1, col2 = st.columns(2)

    with col1:

        pdf_file_path = f"SamplePDF/{document['file_name']}"

        if pdf_file_path:
            doc = fitz.open(pdf_file_path)
            num_pages = len(doc)

            page_number = st.number_input(" ", 1, num_pages, 1)

            page = doc.load_page(page_number - 1)
            pix = page.get_pixmap(matrix=fitz.Matrix(2, 2))
            img = Image.frombytes("RGB", [pix.width, pix.height], pix.samples)

            with st.container(border=True, height=500):
                st.image(img, use_column_width=True)

            st.markdown(f"Page {page_number} of {num_pages}")

    with col2:
        st.title(document['title'])

        if st.button("Add Paper"):
            if len(st.session_state.selected_document) == 100:
                st.markdown("You've reached the maximum number of selected paper (3)")

            else:
                st.session_state.selected_document.append(document)
                st.rerun()


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


# --- Load Chat ---
def load_chat():

    # Store messages
    if "messages" not in st.session_state:
        st.session_state.messages = []

    if "prompts" not in st.session_state:
        st.session_state.prompts = []

    # Sidebar
    with st.sidebar:
        # Return to default (document select)
        if st.button("Return", type="secondary"):
            st.session_state.messages = []
            st.session_state.prompts = []
            st.session_state.selected_document = []
            st.session_state.chat_tools = []
            st.session_state.chat_documents = []
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

        # # Retrieve Context and Built Prompt
        # new_prompt = chatbot_function.retrieve_context(prompt, 10)
        # user_prompt = {"role": "user", "content": new_prompt}
        # st.session_state.prompts.append(user_prompt)
        #
        # print(new_prompt)

        with st.chat_message("assistant"):
            # response = chatbot_function.response(st.session_state.prompts)
            with st.spinner("Thinking"):
                response = chat.agent(prompt, st.session_state.chat_tools, st.session_state.selected_document)
                # st.markdown(f"{response}")
                st.markdown(response)

        ai_response = {"role": "assistant", "content": response}
        st.session_state.messages.append(ai_response)
        st.session_state.prompts.append(ai_response)


def main():
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