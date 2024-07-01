import streamlit as st
import fitz  # PyMuPDF
from PIL import Image

if "document_select" not in st.session_state:
    st.session_state.document_select = True

if "filter" not in st.session_state:
    st.session_state.filter = []


# --- Document Selector ---
@st.experimental_dialog("Select a Paper", width="large")
def select_documents():

    select_col, preview_col = st.columns(2)

    with select_col:
        load_documents()

    with preview_col:
        load_pdf()


def filter_documents(doc, options):
    return all(tag in doc['tags'] for tag in options)


# --- Retrieve Documents ---
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


# --- Document Loader ---
def load_documents():
    # --- Load the documents ---
    documents = get_documents()

    # --- Filter Option --- CHANGE TO SELECTBOX
    tags = st.multiselect(
        "Filter",
        ["Artificial Intelligence", "Machine Learning", "Economy"],
        [])

    # --- Display the documents ---
    col1,col2,col3 = st.columns(3)

    filtered_documents = [doc for doc in documents if filter_documents(doc, tags)]

    for i, doc in enumerate(filtered_documents):
        col = i % 3
        title = doc['title']
        author = doc['authors']
        tags = doc['tags']

        match col:
            case 0:
                with col1:
                    with st.container(height=200, border=True):
                        if st.button(f"{title}", type="primary"):
                            st.rerun()
                        st.markdown(author, unsafe_allow_html=True)
                        st.markdown(tags, unsafe_allow_html=True)
            case 1:
                with col2:
                    with st.container(height=200, border=True):
                        if st.button(f"{title}", type="primary"):
                            st.rerun()
                        st.markdown(author, unsafe_allow_html=True)
                        st.markdown(tags, unsafe_allow_html=True)
            case 2:
                with col3:
                    with st.container(height=200, border=True):
                        if st.button(f"{title}", type="primary"):
                            st.rerun()
                        st.markdown(author, unsafe_allow_html=True)
                        st.markdown(tags, unsafe_allow_html=True)


# --- Load PDF View ---
def load_pdf():
    pdf_file_path = "C:\\Users\\janwi\\OneDrive\\Desktop\\OJT_ChatBot\\SamplePDF\\2021 - A Case Study of Understanding the Bonaparte Basin using Unstructured Data Analysis with Machine Learning Techniques.pdf"

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

def main():
    # --- CSS ---
    with open('style.css') as f:
        st.markdown(f'<style>{f.read()}</style>', unsafe_allow_html=True)

    if st.button("Click Me"):
        select_documents()


if __name__ == "__main__":
    main()