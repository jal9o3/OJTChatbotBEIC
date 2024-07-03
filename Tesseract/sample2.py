def read_and_ignore_word(file_path, word_to_ignore):
    with open(file_path, 'r') as file:
        lines = file.readlines()
    
    # Process each line and ignore the specific word
    filtered_lines = []
    for line in lines:
        filtered_line = ' '.join([word for word in line.split() if word != word_to_ignore])
        filtered_lines.append(filtered_line)
    
    return '\n'.join(filtered_lines)

# Example usage:
file_path = 'example.txt'

try: # Creates a new file
    with open(file_path, 'x', encoding='utf-8') as f:
        f.close()
except FileExistsError: # If file already exists, write over existing file rendering its contents null
    pass

word_to_ignore = 'ignore_this_word'

filtered_content = read_and_ignore_word(file_path, word_to_ignore)
print(filtered_content)