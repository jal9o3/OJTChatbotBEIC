import hashlib, random, string

def generate_random_string(size):
    """
    
    Generates a random string of a certain size.

    Args:        
        size (int): The size of the random string.

        
    Returns:
        str: The random string.    
    """
    return ''.join(random.choice(string.ascii_letters) for _ in range(size))

def calculate_sha256(input_string):
    """
    Calculates the SHA-256 hash of the input string.
    
    Args:
        input_string (str): The string to hash.
    
    Returns:
        str: The hexadecimal representation of the SHA-256 hash.
    """
    sha256_hash = hashlib.sha256(input_string.encode()).hexdigest()
    return sha256_hash

def get_text(txt_file_path):
    """
    Reads the contents of a text file and returns the text as a string.

    Args:
        txt_file_path (str): Path to the text file.

    Returns:
        str: Text content of the file.
    """
    try:
        with open(
            txt_file_path, 'r', encoding="utf-8", errors='ignore') as file:
            return file.read()
    except FileNotFoundError:
        return "File not found. Please provide a valid file path."
    
def get_chunks(text):
    """
    Splits the input text by '\n\n' and returns a list of chunks.

    Args:
        text (str): The input text to be split.

    Returns:
        list: A list of chunks.
    """
    return text.split('\n\n')