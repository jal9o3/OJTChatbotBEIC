import streamlit as st
from transformers import AutoModelForCausalLM, AutoTokenizer, pipeline
import torch

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


def main(pipe):

    # Import CSS
    with open('style.css') as f:
        st.markdown(f'<style>{f.read()}</style>', unsafe_allow_html=True)

    context = "Iraya Energies is a forward-thinking company founded in 2016 with a mission to transform the handling and utilization of vast amounts of unstructured data in the energy sector. Headquartered in Kuala Lumpur, with additional offices in Stavanger and Houston, Iraya Energies leverages a blend of geoscience, engineering expertise, and cutting-edge data science techniques to drive innovation in the exploration and development of oil, gas, and renewable energy resources."
    instruction = "You work for a Company called Iraya Energies, you have to be professional on how you answer, provide only the answer that is asked nothing else. This is the information about the company"

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
        st.session_state.messages = [
            {"role": "user", "content": f"{instruction} {context}"},
            {"role": "assistant", "content": "Hello, I am your companion for this conversation. Welcome to Iraya Energies"},
         ]

    # Display chat messages from history on app rerun
    for message in st.session_state.messages [2:]:
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
        else:
            # Display message in chat message container (USER)
            with st.chat_message("user"):
                st.markdown(prompt)

            # Add to chat history
            user_input = {"role": "user", "content": prompt}
            st.session_state.messages.append(user_input)

            # Display message in chat message container (ASSISTANT)
            with st.chat_message("assistant"):
                # Set the placeholder to Empty
                with st.spinner(text="Typing..."):
                    output = pipe(st.session_state.messages, **generation_args)
                    response = output[0]['generated_text']

                    # Display the response
                    st.markdown(response)

                # Add to chat history
            assistant_input = {"role": "assistant", "content": response}
            st.session_state.messages.append(assistant_input)


if __name__ == "__main__":
    pipe = load_model()
    main(pipe)
