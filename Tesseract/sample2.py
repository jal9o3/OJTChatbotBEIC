def metadata(file_path):    
    

    #data = {
        #   "file_path": None,
    #  "file_name": None,
    # "title": None,
    #    "author": None,
    #   "tags": None 
    #}
    #df = pd.DataFrame(data)
    
    #new_file_row = {"file_path": file_path, "file_name": file_name}
    #df = df.append(new_file_row, ignore_index = True)

    #st.write("Input metadata ")
    #df.loc[df.loc["file_name"] == file_name, "title"] = st.text_input("Title: ", value = file_name, placeholder = "Input Title of the paper")    
    #df.loc[df.loc["file_name"] == file_name, "author"] = st.text_input("Author: ", value = file_name, placeholder = "Input Author of the paper") 
    #tags = st.multiselect("Tags: ", value = file_name, placeholder = "Select tags of the paper")     
    #df['tags'] = df['tags'].tolist() + tags
    tag_options = ["Machine Learning", "Artificial Intelligence", "Statistical Analysis", "Global Warming"]

    
    with open(file_path, 'r', encoding='utf-8') as f:
        file_content = [f.readline() for i in range(3)]

        word_to_ignore = ['Title:', 'Author:', 'Tags:']

        # Process each line and ignore the specific word
        for i in range(len(file_content)):
            filtered_line = ' '.join([word for word in file_content[i].split() if word not in word_to_ignore])
            file_content[i] = filtered_line

        
        st.write("Input metadata ")
        title = st.text_input("Title: ", value = file_content[0], placeholder = "Input Title of the paper")    
        author = st.text_input("Author: ", value = file_content[1], placeholder = "Input Author of the paper") 
        tags = st.multiselect("Tags: ", options = tag_options, placeholder = "Select tags of the paper")

        for i in range(3):
            if i == 0:
                new_info = f"Title: {title}"
            elif i == 1:
                new_info = f"Author: {author}"
            if i == 2:
                new_info = "Tags: "
                count = 0
                for tag in tags:
                    if count != 0:
                        new_info = f"{new_info}, {tag}"
                    elif count == 0:
                        new_info = f"{new_info}{tag}"
                    count += 1

            if  0 <= i <= len(file_content):
                file_content[i] = f"{new_info}\n"

    # Write the modified lines back to the file
    with open(file_path, 'a', encoding = 'utf-8') as f:
        f.writelines(file_content)
        f.close()

    """
        # Create metadata file
        for file_name in os.listdir(extraction_dir):
            text_file_name = os.path.splitext(file_name)[0] + "_metadata.txt" # Specify output file name
            text_file_path = os.path.join(metadata_dir, text_file_name) # Creates file path

            try: # Creates a new file
                with open(text_file_path, 'w', encoding='utf-8') as f:
                    f.write(f"Title: {os.path.splitext(file_name)[0]}\n"
                            "Author: \n"
                            "Tags: \n")
                    f.close()
            except FileExistsError: # If file already exists,move on
                with open(text_file_path, 'w', encoding='utf-8') as f:
                    f.write(f"Title: {os.path.splitext(file_name)[0]}\n"
                            "Author: \n"
                            "Tags: \n")
                    f.close()
        """
    
    """
                # Input metadata
                with meta_prompt:
                    meta_file = os.path.splitext(selected_pdf)[0] + "_metadata.txt"
                    meta_path = os.path.join(text_dir, selected_file)
                    metadata(meta_path)
                """