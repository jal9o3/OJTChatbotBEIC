def get_text(txt_file_path):
    """
    Reads the contents of a text file and returns the text as a string.

    Args:
        txt_file_path (str): Path to the text file.

    Returns:
        str: Text content of the file.
    """
    try:
        with open(txt_file_path, 'r', encoding="utf-8") as file:
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