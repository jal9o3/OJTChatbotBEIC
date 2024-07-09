import tensorflow_hub as hub

def get_USE_embedding(sentence):
    embed = hub.load("https://tfhub.dev/google/universal-sentence-encoder/4")
    return embed([sentence])[0]