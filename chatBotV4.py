# Chatbot Model
import numpy as np
from transformers import AutoTokenizer, AutoModelForCausalLM,pipeline
import re

from sentence_transformers import SentenceTransformer
import torch

# Retrieval Augmented Generation
from langchain_community.embeddings import HuggingFaceBgeEmbeddings
from langchain_community.vectorstores import Chroma
import streamlit as st

torch.random.manual_seed(0)

# Ensure no gradients are calculated
torch.set_grad_enabled(False)


@st.cache_resource
def load_model():
    print("Loading Model...")

    # Load model in FP16 precision to save memory
    model = AutoModelForCausalLM.from_pretrained(
        "microsoft/Phi-3-mini-4k-instruct",
        device_map="cuda",
        torch_dtype=torch.float16,  # change to auto
        trust_remote_code=True,
    )
    tokenizer = AutoTokenizer.from_pretrained("microsoft/Phi-3-mini-4k-instruct")

    pipe = pipeline(
        "text-generation",
        model=model,
        tokenizer=tokenizer,
    )

    return pipe


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


def retrieve_context(query_text: str):

    database_path = "Database"

    # Prepare the DB
    embedding = get_embedding()
    db = Chroma(
        persist_directory=database_path,
        embedding_function=embedding
    )

    # Search the DB.
    results = db.similarity_search_with_score(query_text, k=5)

    # Filter results with score <= 1
    filtered_results = [(chunk, score) for chunk, score in results if score <= 1]

    content = ""
    for i in filtered_results:
        content += f"{i[0].page_content} \n =================== \n"

    PROMPT_TEMPLATE = f"""
    You are a helpful Assistant,
    you have to be professional on how you answer, provide only the answer that is asked nothing else.

    Answer the question based on the content (if empty, just converse normally):

    Content: {content}

    Answer this question based on the content above: {query_text}
    """

    return PROMPT_TEMPLATE

def main(pipe):

    # Import CSS
    with open('style.css') as f:
        st.markdown(f'<style>{f.read()}</style>', unsafe_allow_html=True)

    generation_args = {
        "max_new_tokens": 100,
        "return_full_text": False,
        "temperature": 0.5,
        "do_sample": True,
    }

    # Set Title
    st.title("Trial Chat Bot")

    # Initialize Chat History
    if "messages" not in st.session_state:
        st.session_state.messages = []

    # Initialize Prompt History
    if "prompt_message" not in st.session_state:
        st.session_state.prompt_message = []

    # Display chat messages from history on app rerun
    for message in st.session_state.messages:
        with st.chat_message(message["role"]):
            st.markdown(message["content"])

    # User Input
    prompt = st.chat_input("What is up?")

    if prompt:
        if prompt == "/history":
            with st.chat_message("user"):
                st.markdown(prompt)

            for con in st.session_state.messages:
                st.markdown(f"{con["role"]} : {con["content"]}")

        elif prompt == "/prompt_history":
            with st.chat_message("user"):
                st.markdown(prompt)

            for con in st.session_state.prompt_message:
                st.markdown(f"{con["role"]} : {con["content"]}")

        else:
            torch.cuda.empty_cache()

            # Display message in chat message container (USER)
            with st.chat_message("user"):
                st.markdown(prompt)

            # Add to chat history
            user_input = {"role": "user", "content": prompt}
            st.session_state.messages.append(user_input)

            # Add to prompt history
            user_prompt = {"role": "user", "content": retrieve_context(prompt)}
            st.session_state.prompt_message.append(user_prompt)

            # Display message in chat message container (ASSISTANT)
            with st.chat_message("assistant"):
                with st.spinner(text="Typing..."):
                    output = pipe(st.session_state.prompt_message, **generation_args)
                    response = output[0]['generated_text']

                    # Display the response
                    st.markdown(response)

                # Add to chat history
            assistant_input = {"role": "assistant", "content": response}
            st.session_state.messages.append(assistant_input)
            st.session_state.prompt_message.append(assistant_input)


if __name__ == "__main__":
    pipe = load_model()
    main(pipe)