import unittest
from text_management import get_text, get_chunks, calculate_sha256
from text_management import generate_random_string

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
        self.assertEqual(
            result, "File not found. Please provide a valid file path.")

class TestGetChunks(unittest.TestCase):
    def test_empty_text(self):
        self.assertEqual(get_chunks(""), [""])

    def test_single_chunk(self):
        self.assertEqual(get_chunks("Hello, world!"), ["Hello, world!"])

    def test_multiple_chunks(self):
        input_text = "Chunk 1. Chunk 2. Chunk 3"
        expected_chunks = ["Chunk 1", " Chunk 2", " Chunk 3"]
        self.assertEqual(get_chunks(input_text), expected_chunks)

class TestCalculateSHA256(unittest.TestCase):
    def test_empty_string(self):
        self.assertEqual(calculate_sha256(""), 
            "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855")
    
    def test_non_empty_string(self):
        self.assertEqual(calculate_sha256("Hello, world!"), 
            "315f5bdb76d078c43b8ac0064e4a0164612b1fce77c869345bfc94c75894edd3")

class TestRandomStringGenerator(unittest.TestCase):
    def test_random_string_length(self):
        # Test if the generated string has the correct length
        random_string = generate_random_string(10)
        self.assertEqual(len(random_string), 10)

    def test_random_string_content(self):
        # Test if the generated string contains only letters
        random_string = generate_random_string(15)
        self.assertTrue(random_string.isalpha())

if __name__ == "__main__":
    unittest.main()
