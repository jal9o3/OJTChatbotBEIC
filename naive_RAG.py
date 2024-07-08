from huggingface_hub import InferenceClient
from langchain_community.embeddings import HuggingFaceBgeEmbeddings
from langchain_community.vectorstores import Chroma
import torch
import os


def get_documents():

    sample_doc = [
        {"id": 0,
         "title": "A Case Study of Understanding the Bonaparte Basin using Unstructured Data Analysis with Machine Learning Techniques",
         "authors": "A.N.N. Sazali, N.M. Hernandez, F. Baillard, K.G. Maver",
         "tags": ["Artificial Intelligence", "Machine Learning", "Economy"],
         "file_name": "2021 - A Case Study of Understanding the Bonaparte Basin using Unstructured Data Analysis with Machine Learning Techniques.pdf"},

        {"id": 1,
         "title": "An Automated Information Retrieval Platform For Unstructured Well Data Utilizing Smart Machine Learning Algorithms Within A Hybrid Cloud Container",
         "authors": "N.M. Hernandez, P.J. Lucafias', J.C. Graciosa', C. Mamador, L. Caezar', I. Panganiban, C. Yu', K.G",
         "tags": ["Artificial Intelligence"],
         "file_name": "2021 - An Automated Information Retrieval Platform For Unstructured Well Data Utilizing Smart Machine Learning Algorithms Within A Hybrid Cloud Container.pdf"},

        {"id": 2, "title": " Supporting the UN 2050 Net Zero goals by reading the earth better",
         "authors": "Nina Marie Hernandez, Kim Gunn Maver and Charmyne Mamador",
         "tags": ["Machine Learning"],
         "file_name": "2021 - Supporting the UN 2050 Net Zero goals by reading the earth better.pdf"},

        {"id": 3,
         "title": "Scaling and optimizing performance and cost of machine learning ingestion on unstructured data for subsurface applications",
         "authors": "L.C.L. Panganiban, F. Baillard', N.M. Hernandez!",
         "tags": ["Artificial Intelligence", "Machine Learning"],
         "file_name": "2022 - Scaling and optimizing performance and cost of machine learning ingestion on unstructured data for subsurface applications.pdf"},
    ]

    return sample_doc


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