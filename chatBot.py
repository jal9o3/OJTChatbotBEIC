from transformers import AutoTokenizer, AutoModelForCausalLM, pipeline
import torch

from langchain_community.embeddings import HuggingFaceBgeEmbeddings
from langchain_community.vectorstores import Chroma

import streamlit as st

from transformers import BitsAndBytesConfig
from torch import bfloat16

st.set_page_config(page_title="Testing ChatBot", layout="wide")
torch.set_grad_enabled(False)


@st.cache_resource
def load_model():
    print("Loading Model")

    model_name = "microsoft/Phi-3-mini-4k-instruct"

    # Load model in FP16 precision to save memory
    model = AutoModelForCausalLM.from_pretrained(
        model_name,
        device_map="cuda",
        torch_dtype=torch.float16,  # change to auto
        trust_remote_code=True,
    )

    tokenizer = AutoTokenizer.from_pretrained(model_name)

    pipe = pipeline(
        "text-generation",
        model=model,
        tokenizer=tokenizer,
    )

    return pipe

    # # Our 4-bit configuration to load the LLM with less GPU memory
    # bnb_config = BitsAndBytesConfig(
    #     load_in_4bit=True,  # 4-bit quantization
    #     bnb_4bit_quant_type='nf4',  # Normalized float 4
    #     bnb_4bit_use_double_quant=True,  # Second quantization after the first
    #     bnb_4bit_compute_dtype=bfloat16  # Computation type
    # )
    #
    # tokenizer = AutoTokenizer.from_pretrained(model_name)
    # model = AutoModelForCausalLM.from_pretrained(
    #     model_name,
    #     quantization_config=bnb_config,
    #     device_map='auto',
    #     trust_remote_code=True
    # )
    #
    # # Create a pipeline
    # pipe = pipeline(model=model,
    #                 tokenizer=tokenizer,
    #                 task='text-generation')
    #
    # return pipe


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
    database_path = "Database"

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


def main(pipe):
    # --- CSS ---
    with open('style.css') as f:
        st.markdown(f'<style>{f.read()}</style>', unsafe_allow_html=True)

    # --- Generation Args ---
    generation_args = {
        "max_new_tokens": 100,
        "return_full_text": False,
        "temperature": 0.5,
        "do_sample": True,
    }

    # --- Sidebar ---
    with st.sidebar:
        st.title("Settings")

        st.markdown("**Retrieval Augmented Generation**")
        with st.container():
            col1, col2 = st.columns(2)
            with col1:
                st.write("##")
                rag_active = st.toggle("RAG")
            with col2:
                # chunks = st.number_input("Chunks", min_value=2, max_value=5)
                chunks = st.selectbox("No. of Chunks", [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], disabled=not rag_active)

    # --- Chat ---
    st.title("Chat")

    # Chat History
    if "messages" not in st.session_state:
        st.session_state.messages = []

    # Prompt History (for AI)
    if "prompt_message" not in st.session_state:
        st.session_state.prompt_message = []

    # Show Chat History
    for message in st.session_state.messages:
        with st.chat_message(message['role']):
            st.markdown(message['content'])

    # Start of Conversation
    prompt = st.chat_input("What is up?")

    if prompt:
        # User Prompt
        with st.chat_message("user"):
            st.markdown(prompt)

        # RAG Implementation
        if rag_active:
            st.session_state.retrieved_text = retrieve_context(prompt, chunks)

            # Add to prompt history
            user_prompt = {"role": "user", "content": retrieve_context(prompt, chunks)}
            st.session_state.prompt_message.append(user_prompt)
        else:
            # Add to prompt history
            user_prompt = {"role": "user", "content": prompt}
            st.session_state.prompt_message.append(user_prompt)

        # Add to chat history
        user_input = {"role": "user", "content": prompt}
        st.session_state.messages.append(user_input)

        # Assistant Response
        with st.chat_message("assistant"):
            with st.spinner("Typing..."):
                output = pipe(st.session_state.prompt_message, **generation_args)
                response = output[0]['generated_text']

                st.markdown(response)

        # Add to chat history
        assistant_input = {"role": "assistant", "content": response}
        st.session_state.messages.append(assistant_input)
        st.session_state.prompt_message.append(assistant_input)

        # st.session_state.messages.append({"role": "assistant", "content": f"Echo: {prompt}"})

    # --- Update Sidebar ---
    with st.sidebar:
        if not rag_active:
            st.session_state.retrieved_text = ""
            st.text_area("Returned Chunks",
                         disabled=True,
                         height=550)
        else:
            st.text_area("Returned Chunks",
                         f"{st.session_state.retrieved_text}",
                         disabled=True,
                         height=550)


if __name__ == "__main__":
    main(load_model())
