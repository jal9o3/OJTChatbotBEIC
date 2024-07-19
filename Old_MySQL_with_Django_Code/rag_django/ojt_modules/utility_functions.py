import re

def sanitize_file_name(file_name):
    """Replaces spaces with underscores and removes problematic characters from a file name.

    Args:
        file_name (str): The file name to sanitize.

    Returns:
        str: The sanitized file name.
    """
    # Remove non-alphanumeric characters except for underscores
    sanitized_name = re.sub(r'[^a-zA-Z0-9_]', '_', file_name)
    # Replace spaces with underscores
    sanitized_name = re.sub(r'\s+', '_', sanitized_name)
    return sanitized_name