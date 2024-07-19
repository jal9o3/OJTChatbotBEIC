import logging
import os

# Silence most of Tensorflow's warnings for this test
# Must be done before Tensorflow is imported as per this Stackoverflow answer:
# https://stackoverflow.com/a/64448286
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3'  # Set to '0', '1', or '2'
# TensorFlow Hub reads the model directly from remote storage
# os.environ["TFHUB_MODEL_LOAD_FORMAT"] = "UNCOMPRESSED"
import tensorflow_hub as hub

from sentence_transformers import SentenceTransformer

def get_USE_embedding(sentence):
    logging.getLogger('tensorflow').setLevel(logging.FATAL)
    embed = hub.load("https://tfhub.dev/google/universal-sentence-encoder/4")
    return embed([sentence])[0]

def get_MiniLM_embedding(sentence):
    # Load a pretrained Sentence Transformer model (e.g., 'all-MiniLM-L6-v2')
    model = SentenceTransformer("all-MiniLM-L6-v2")
    embedding = model.encode([sentence])
    return embedding[0]
