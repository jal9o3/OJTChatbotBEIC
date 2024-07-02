import unittest
from data_management import get_text, get_chunks

class TestGetText(unittest.TestCase):
    def test_existing_file(self):
        # Create a temporary text file with some content
        with open("temp.txt", "w", encoding="utf-8") as temp_file:
            temp_file.write("Hello, world!")

        # Test the function with the temporary file
        result = get_text("temp.txt")
        self.assertEqual(result, "Hello, world!")

    def test_nonexistent_file(self):
        # Test the function with a nonexistent file
        result = get_text("nonexistent.txt")
        self.assertEqual(result, "File not found. Please provide a valid file path.")

class TestGetChunks(unittest.TestCase):
    def test_empty_text(self):
        self.assertEqual(get_chunks(""), [""])

    def test_single_chunk(self):
        self.assertEqual(get_chunks("Hello, world!"), ["Hello, world!"])

    def test_multiple_chunks(self):
        input_text = "Chunk 1\n\nChunk 2\n\nChunk 3"
        expected_chunks = ["Chunk 1", "Chunk 2", "Chunk 3"]
        self.assertEqual(get_chunks(input_text), expected_chunks)

if __name__ == "__main__":
    unittest.main()
