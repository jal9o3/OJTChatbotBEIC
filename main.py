import streamlit as st
import fitz  # PyMuPDF
from PIL import Image
from tweaker import st_tweaker

st.set_page_config("Chabot", layout="wide")

if "document_select" not in st.session_state:
    st.session_state.document_select = True

if "filter" not in st.session_state:
    st.session_state.filter = []

if 'selected_document' not in st.session_state:
    st.session_state.selected_document = []


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
         "source": "2021 - A Case Study of Understanding the Bonaparte Basin using Unstructured Data Analysis with Machine Learning Techniques.pdf"},

        {"id": 1,
         "title": "An Automated Information Retrieval Platform For Unstructured Well Data Utilizing Smart Machine Learning Algorithms Within A Hybrid Cloud Container",
         "authors": "Name of Authors",
         "tags": ["Artificial Intelligence"],
         "source": "2021 - An Automated Information Retrieval Platform For Unstructured Well Data Utilizing Smart Machine Learning Algorithms Within A Hybrid Cloud Container.pdf"},

        {"id": 2, "title": " Supporting the UN 2050 Net Zero goals by reading the earth better",
         "authors": "Name of Authors",
         "tags": ["Machine Learning"],
         "source": "2021 - Supporting the UN 2050 Net Zero goals by reading the earth better.pdf"},

        {"id": 3,
         "title": "Scaling and optimizing performance and cost of machine learning ingestion on unstructured data for subsurface applications",
         "authors": "Name of Authors",
         "tags": ["Artificial Intelligence", "Machine Learning"],
         "source": "2022 - Scaling and optimizing performance and cost of machine learning ingestion on unstructured data for subsurface applications.pdf"},

        {"id": 4,
         "title": "Sustainable data mining AI_ML-based parameter extraction, data visualization and connectivity to upcycle big-data for basin analysis ",
         "authors": "Name of Authors",
         "tags": ["Machine Learning"],
         "source": "2022 - Sustainable data mining AI_ML-based parameter extraction, data visualization and connectivity to upcycle big-data for basin analysis .pdf"},

        {"id": 5,
         "title": "Utilizing Machine Learning to Gain Geological Insights through Unstructured Data for  Sustainable Exploration Activities",
         "authors": "Name of Authors",
         "tags": ["Machine Learning"],
         "source": "2022 - Utilizing Machine Learning to Gain Geological Insights through Unstructured Data for  Sustainable Exploration Activities.pdf"},

        {"id": 6,
         "title": "Double funnel approach for screening of potential CO2 storage opportunities in the Norwegian Continental Shelf",
         "authors": "Name of Authors",
         "tags": [ "Economy"],
         "source": "2023 - Double funnel approach for screening of potential CO2 storage opportunities in the Norwegian Continental Shelf.pdf"},

        {"id": 7,
         "title": "Sand Production and Control Benchmarking through Unstructured Data Analysis with Machine Learning in the North Sea",
         "authors": "Name of Authors",
         "tags": ["Machine Learning"],
         "source": "2023 - Sand Production and Control Benchmarking through Unstructured Data Analysis with Machine Learning in the North Sea.pdf"}
    ]

    return sample_doc


# --- Document Loader ---
def load_documents():
    with st.container():
        # --- Load the documents ---
        documents = get_documents()

        # --- Filter Option --- CHANGE TO SELECTBOX
        with st_tweaker.container(id="document_action"):
            col1, col2, col3 = st.columns(3)

            with col3:
                st_tweaker.button("Start Chat", id="start_chat")

            with col1:
                tags = st.multiselect(
                    "",
                    ["Artificial Intelligence", "Machine Learning", "Economy"],
                    [])

        # --- Display the documents ---
        col1, col2, col3 = st.columns(3)

        # Use the Tags to Filter
        filtered_documents = [doc for doc in documents if filter_documents(doc, tags)]

        for i, doc in enumerate(filtered_documents):

            # Don't show documents that are selected
            if any(d['id'] == i for d in st.session_state.selected_document):
                pass
            else:
                col = i % 3
                title = doc['title']
                author = doc['authors']
                tags = doc['tags']

                match col:
                    case 0:
                        with col1:
                            with st.container(height=200, border=True):
                                if st.button(f"{title}", type="primary"):
                                    load_pdf(doc)
                                    # st.session_state.selected_document.append(filtered_documents[i])
                                    # st.rerun()
                                st.markdown(f"<p class = ""additional_info"f">{author}</p>", unsafe_allow_html=True)
                                st.markdown(f"<p class = ""additional_info"f">{tags}</p>", unsafe_allow_html=True)
                    case 1:
                        with col2:
                            with st.container(height=200, border=True):
                                if st.button(f"{title}", type="primary"):
                                    load_pdf(doc)
                                st.markdown(f"<p class = ""additional_info"f">{author}</p>", unsafe_allow_html=True)
                                st.markdown(f"<p class = ""additional_info"f">{tags}</p>", unsafe_allow_html=True)
                    case 2:
                        with col3:
                            with st.container(height=200, border=True):
                                if st.button(f"{title}", type="primary"):
                                    load_pdf(doc)
                                st.markdown(f"<p class = ""additional_info"f">{author}</p>", unsafe_allow_html=True)
                                st.markdown(f"<p class = ""additional_info"f">{tags}</p>", unsafe_allow_html=True)


# --- Filter Documents ---
def filter_documents(doc, options):
    return all(tag in doc['tags'] for tag in options)


# --- Show Selected Documents ---
def show_selected_documents():
    with st.container(border=True):
        st.subheader("Selected Paper")

        for i in range(len(st.session_state.selected_document)):
            with st_tweaker.container(border=True, id="selected_doc"):
                col1, col2 = st.columns([6,1])

                with col1:
                    max_chars = 60
                    title = st.session_state.selected_document[i]['title']
                    title = title[:max_chars] + ('...' if len(title) > max_chars else '')

                    st.markdown(f"{title}")

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

        pdf_file_path = f"SamplePDF/{document['source']}"

        if pdf_file_path:
            doc = fitz.open(pdf_file_path)
            num_pages = len(doc)

            page_number = st.number_input("", 1, num_pages, 1)

            page = doc.load_page(page_number - 1)
            pix = page.get_pixmap(matrix=fitz.Matrix(2, 2))
            img = Image.frombytes("RGB", [pix.width, pix.height], pix.samples)

            with st.container(border=True, height=500):
                st.image(img, use_column_width=True)

            st.markdown(f"Page {page_number} of {num_pages}")

    with col2:
        st.title(document['title'])

        if st.button("Add Paper"):
            st.session_state.selected_document.append(document)
            st.rerun()




def main():
    # --- CSS ---
    with open('style.css') as f:
        st.markdown(f'<style>{f.read()}</style>', unsafe_allow_html=True)

    # if st.button("Click Me"):
    #     select_documents()

    select_documents()


if __name__ == "__main__":
    main()