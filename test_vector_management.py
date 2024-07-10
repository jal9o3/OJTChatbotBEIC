import unittest
import logging
import os

# Silence most of Tensorflow's warnings for this test
# Must be done before Tensorflow is imported as per this Stackoverflow answer:
# https://stackoverflow.com/a/64448286
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3'  # Set to '0', '1', or '2'
import tensorflow_hub as hub

from vector_management import get_USE_embedding, get_MiniLM_embedding

class TestUSEEmbedding(unittest.TestCase):
    def test_embedding(self):
        logging.getLogger('tensorflow').setLevel(logging.FATAL)
        # Test a sample sentence
        sentence = "This is a test sentence."
        embedding = get_USE_embedding(sentence)
        self.assertIsNotNone(embedding)

class TestMiniLMEmbedding(unittest.TestCase):
    def test_embedding(self):
        # Test case: Check if the embedding is not None
        sentence = "This is a test sentence."
        embedding = get_MiniLM_embedding(sentence)
        self.assertIsNotNone(embedding)

if __name__ == "__main__":
    unittest.main()