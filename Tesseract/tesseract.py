import streamlit as st

import pytesseract

from pdf2image import convert_from_path
from PyPDF2 import PdfReader

import cv2 as cv

import preprocessing
import demo_main
from tags import tag_options

import os
import time

from psycopg2 import OperationalError

# DATABASE FUNCTIONS---------------------

@st.experimental_dialog("Input Host Address")
def input_credentials():
    placeholder_text = "Enter Value"

    db_name = st.text_input("Enter Database Name: ", value = st.session_state.db_name, placeholder = placeholder_text)
    
    db_user = st.text_input("Enter User: ", value = st.session_state.db_user, placeholder = placeholder_text)
    
    db_host = st.text_input("Enter Host Address: ", value = st.session_state.db_host, placeholder = placeholder_text)
    
    db_port = st.text_input("Enter Port: ", value = st.session_state.db_port, placeholder = placeholder_text)
    
    db_password = st.text_input("Enter password: ", placeholder = placeholder_text, type = "password")

    st.session_state.submit_credentials = False

    if st.button("Submit"):
        credential_check = None
        try:
            credential_check = demo_main.create_connection(db_name = db_name,
                                                           db_user = db_user,
                                                           db_password = db_password, 
                                                           db_host = db_host,
                                                           db_port = db_port
                                                           )    
            st.success("Connection to PostgreSQL DB successful")
        except OperationalError as e:
            st.session_state.credentials_submitted = False
            st.error("There is something wrong with your credentials")
            print(f"Credentials Error: {e}")
        
        if credential_check:
            st.session_state.db_name = db_name
            st.session_state.db_user = db_user
            st.session_state.db_password = db_password 
            st.session_state.db_host = db_host
            st.session_state.db_port = db_port
        
            st.session_state.credentials_submitted = True

            st.rerun()
        
#       Main Database Function

# EXTRACTION FUNCTIONS------------------

def extract_image(upload_dir, image_dir, file_name):
    # Convert pdfs to images
    if file_name.endswith(".pdf"): # Check if the file is a pdf

        file_path = os.path.join(upload_dir, file_name) # Specify path to the PDF file
        with open(file_path, 'rb') as f:
            pdf = PdfReader(f)
            num_pages = len(pdf.pages)

        # Create directory for output image file specific to the pdf
        file_image_dir = os.path.join(image_dir, os.path.splitext(file_name)[0]) # directory containning the images of the pdf
        if not os.path.exists(file_image_dir):# Ensure the extraction directory exists
            os.makedirs(file_image_dir)

        # Iterate through each page image and save
        for page_number in range(1, num_pages + 1):
            try:
                page_image = convert_from_path(file_path, dpi = 300, first_page=page_number, last_page=page_number, fmt = 'png') # Convert PDF pages to images

                image_path = os.path.join(file_image_dir, f"{page_number}.png") # path of the image
                page_image[0].save(image_path, 'PNG', dpi = (300, 300))

            except Exception as e:
                print(f"Error Converting Page {page_number} of file {file_name}: {e}")
                continue
        
        st.session_state.image_converted = True

def preprocess(image):

    if st.session_state.deskew == True:
        # Remove images from the page
        image = preprocessing.deskew(image)
    
    if st.session_state.crop_image == True:
        # Remove images from the page
        image = preprocessing.crop_image(image)

    if st.session_state.remove_borders == True:
        # Remove the borders of the image
        image = preprocessing.remove_borders(image)

    if st.session_state.add_borders == True:
        # Add borders to the image
        image = preprocessing.add_borders(image)

    if st.session_state.remove_noise == True:
        # Remove noise from the page
        image = preprocessing.remove_noise(image)

    if st.session_state.thick_font == True:
        # Thicken the font of the text in the image
        image = preprocessing.thick_font(image)

    if st.session_state.thin_font == True:
        # thin out the font of the text in the image
        image = preprocessing.thin_font(image)

    if st.session_state.remove_images == True:
        # Remove images from the page
        image = preprocessing.remove_images(image)

    return image

#       Main Extraction Functions

def images_to_text(pdf_images_dir, text_path):
    #configuration for Tesseract
    #psm 1 - Automatic page segmentation with Orientation and Script Detection
    #oem 3 - Default, mode based on the available
    my_config = r"--psm 1 --oem 3"

    image_files = [os.path.splitext(file)[0] for file in os.listdir(pdf_images_dir) if file.endswith('.png')]
    image_files_sorted = sorted(image_files, key = int)

    # Iterate through each page image and perform OCR
    for page_number, page_image in enumerate(image_files_sorted, start = 1): # iterate for each file in the image directory starting with 1
        try:
            image_path = os.path.join(pdf_images_dir, f"{page_image}.png") # path of the image
            pdf_name = os.path.basename(pdf_images_dir)
            print(f"Processing page {page_number} of {pdf_name}")
            
            image = cv.imread(image_path) # Read the image
            
            # Perform OCR on the page image
            text = pytesseract.image_to_string(image,lang = 'enga+fil+equ', config=my_config)
            
            # Perform Text Preprocessing
            text = preprocessing.body_text(text)

            with open(text_path, 'a', encoding='utf-8') as f: # Append extracted text to the file
                f.write(f"\n\n-----Page {page_number}-----\n\n{text}")
        except Exception as e:
            print(f"Error Extracting Text from Page {page_number} of {pdf_name}: {e}")
            continue

# Metadata Functions--------------------

def create_metadata_file(upload_dir, metadata_dir):
    
    # Create metadata file
    for file_name in os.listdir(upload_dir):
        text_file_name = os.path.splitext(file_name)[0] + ".txt" # Specify output file name
        text_file_path = os.path.join(metadata_dir, text_file_name) # Creates file path

        make_text_file(text_file_path)
        with open(text_file_path, 'w', encoding='utf-8') as f:
            f.write(f"Title: {os.path.splitext(text_file_name)[0]}\n"
                    "Author: Unknown\n"
                    "Tags: Others\n")
            f.close()

#       Main Metadata Function

def words_to_ignore():
    words = ['Title:', 'Author:', 'Tags:']
    return words

def metadata(file_path):

    if text_content_check(file_path):

        with open(file_path, 'r', encoding='utf-8') as f:
            file_content = [f.readline() for i in range(3)]

        ignore_words = words_to_ignore()
        
        # Process each line and ignore the specific word
        for i in range(len(file_content)):
            filtered_line = ' '.join([word for word in file_content[i].split() if word not in ignore_words])
            file_content[i] = filtered_line
        
        selected_tags = [item.strip() for item in file_content[2].split(",") if item.strip()]

        input_title = st.text_input("Title: (Non-printable characters and characters not suited for file names will be removed)", value = file_content[0], placeholder = "Input Title of the paper")    
        author = st.text_input("Author: (Separate names with a comma (,))", value = file_content[1], placeholder = "Input Author of the paper separated by a comma (,)") 
        tags = st.multiselect("Tags: ", options = tag_options, default = selected_tags, placeholder = "Select tags of the paper")

        title = preprocessing.remove_unaccepted_chars(input_title)

        if not title:
            title = "Unknown"
        if not author:
            author = "Unknown"
        if not tags:
            tags = "Unknown"

        if st.button("Confirm data"):
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
            with open(file_path, 'w', encoding = 'utf-8') as f:
                f.writelines(file_content)
                f.close()

            st.success("Metadata Updated")

# UPLOAD FUNCTIONS------------------------

# Combines the metadata of the file to the file itself
def create_output(metadata_dir, extracted_text_dir, output_dir):
    for doc_number, file_name in enumerate(os.listdir(extracted_text_dir), start = 1):
        extracted_text_path = os.path.join(extracted_text_dir, file_name)
        
        if text_content_check(extracted_text_path):
            metadata_path = os.path.join(metadata_dir, file_name)
            output_file_path = os.path.join(output_dir,f"document_{doc_number}.txt")
            
            make_text_file(output_file_path)

            with open(metadata_path, 'r') as metadata_file:
                metadata = metadata_file.read()

            with open(extracted_text_path, 'r') as extracted_text_file:
                extracted_text = extracted_text_file.read()

            with open(output_file_path, 'a') as output_file:
                output_file.write(metadata)
                output_file.write(extracted_text)

# Main--------------------

#       Session State Functions
def image_processing_options():
    options = [
                {"label": "Deskew", "key": "deskew"},
                {"label": "Crop Image", "key": "crop_image"},
                {"label": "Remove Borders", "key": "remove_borders"},
                {"label": "Add Borders", "key": "add_borders"},
                {"label": "Remove Noise", "key": "remove_noise"},
                {"label": "Thicken Font", "key": "thick_font"},
                {"label": "Thin Out Font", "key": "thin_font"},
                {"label": "Remove Images", "key": "remove_images"}
            ]
    return options

def set_session_states(action = "set"):
    options = image_processing_options()

    # Database session_states
    button_keys = ["extract", 
                   "upload_database", 
                   "upload_pdf", 
                   "process_change", 
                   "confirm_upload",
                   "submit_credentials",
                   "upload_again"
                   ]
    operation_keys = ["extract_done", 
                      "upload_done", 
                      "process_done", 
                      "image_converted", 
                      "credentials_submitted"
                      ]
    database_keys = ["db_name",
                     "db_user",
                     "db_password",
                     "db_host",
                     "db_port"
                    ]
    variable_keys = ["selected_pdf", 
                     "selected_page"
                     ]
    list_keys = ["uploaded_file"]
    image_processing_keys = [option["key"] for option in options]

    all_keys = button_keys + operation_keys + list_keys + image_processing_keys + variable_keys + database_keys

    if action == "set":
        for key in variable_keys + list_keys + database_keys:
            if key not in st.session_state:
                st.session_state[key] = ""

        for key in button_keys + operation_keys + image_processing_keys:
            if key not in st.session_state:
                st.session_state[key] = False
    
    elif action == "reset":
        for key in all_keys:
            if key in variable_keys + list_keys + database_keys:
                st.session_state[key] = ""
            elif key in button_keys + operation_keys + image_processing_keys:
                st.session_state[key] = False

    elif action == "new_upload":
        for key in all_keys:
            if key in variable_keys + list_keys:
                st.session_state[key] = ""
            elif key in button_keys + operation_keys + image_processing_keys:
                st.session_state[key] = False
    
    elif action == "reset_database":
        for key in database_keys:
            st.session_state[key] = ""

def upload_pdf():
    st.session_state.upload_pdf = True

def extract():
    st.session_state.extract = True

def upload_database():
    st.session_state.upload_database = True

def process_change():
    st.session_state.process_change = True

def submit_credentials():
    st.session_state.submit_credentials = True

def upload_again():
    st.session_state.upload_again = True

#       Other Functions of Main

def show_message(message, duration=0.5):
    message_html = f"""
    <div style="
        position: fixed;
        bottom: 20px;
        left: 50%;
        transform: translateX(-50%);
        background-color: #16394F;
        color: white;
        padding: 10px;
        border-radius: 5px;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        z-index: 1000;
    ">
        {message}
    </div>
    """

    placeholder = st.empty()
    with placeholder:
        st.markdown(message_html, unsafe_allow_html=True)
    time.sleep(duration)
    placeholder.empty()





    #MAIN FUNCTION--------------------------

def remove_contents(dir):
    if os.path.exists(dir):# Delete files in extraction Diectory afterwards
        for root, dirs, files in os.walk(dir, topdown=False):
            for name in files:
                os.remove(os.path.join(root, name))
            for name in dirs:
                os.rmdir(os.path.join(root, name))

def make_dir(parent_dir, name):
    new_dir = os.path.join(parent_dir, name)
    if not os.path.exists(new_dir):# Ensure the directory exists
        os.makedirs(new_dir)

    return new_dir

def make_text_file(file_path):
    try: # Creates a new file
        with open(file_path, 'x', encoding='utf-8') as f:
            f.close()
    except FileExistsError: # If file already exists, write over the old file
        with open(file_path, 'w', encoding='utf-8') as f: 
            f.close()

def text_content_check(file_path):
    file = os.path.basename(file_path)

    # Check if the file exists
    if not os.path.exists(file_path):
        st.error(f"The file {file} does not exist.")
        return False
    
    # Check if the file size is zero
    if os.path.getsize(file_path) > 0:
        return True
    else:
        st.error(f"The file {file} is empty.")
        return False

def directory_check(directory_path):
    directory = os.path.basename(directory_path)

    # Check if the path exists
    if not os.path.exists(directory_path):
        st.error(f"The directory {directory} does not exist.")
        return False
    
    # Check if the path is a directory
    if not os.path.isdir(directory_path):
        st.error(f"The path {directory} is not a directory.")
        return False

    # Check if the directory is empty
    if os.listdir(directory_path):
        return True
    else:
        st.error(f"The directory {directory} is empty.")
        return False

def file_process_check(list_1, list_2):
    set_1 = set(list_1)
    set_2 = set(list_2)

    difference = set_1 - set_2

    return difference

#       MAIN Function----------------

def main():

    set_session_states("set")

    # gets the directory were the script is located
    script_directory = os.path.dirname(os.path.abspath(__file__))

    # Create diectory for the uploaded files
    upload_dir = make_dir(script_directory, "uploaded_pdfs")

    # Create directory for converted image files
    image_dir = make_dir(script_directory, "converted_image")

    # Create directory for preprocessed image file
    preprocessed_dir = make_dir(script_directory, "preprocessed_image")

    # Create a directory for the extracted text files
    extracted_text_dir = make_dir(script_directory, "extracted_text")

    # Create a directory for metadata files
    metadata_dir = make_dir(script_directory, "metadata_text")

    # Create a directory for output files
    output_dir = make_dir(script_directory, "output_text")

    # Layout
    st.set_page_config(page_title="Tesseract OCR Extractor", layout="wide") 
    st.markdown("<h1 style='text-align: center;'>Tesseract Extractor</h1>", unsafe_allow_html=True)
    st.markdown("<p style='text-align: center;'>Extract PDFs and add them directly to the database.</p>", unsafe_allow_html=True)
    st.write("")

    upload_con = st.container() # for upload processes
    extract_col, upload_col = st.columns(2) # extract_col = for extraction processes; upload_col = for database uploading processes
    document_selection, edit_metadata = st.columns(2)
    image_view, text_view = st.columns(2) # for viewing what will be processed

    with upload_con:
        st.markdown('<h4 style="text-align: left;">Upload PDFs:</h4>', unsafe_allow_html=True)
        # Uploading of pdf files; the widget can accept multiple pdfs
        st.session_state.uploaded_file = st.file_uploader("Choose a file", type = "pdf", accept_multiple_files = True)
        st.success(f"{len(st.session_state.uploaded_file)} file(s) uploaded")

        if not st.session_state.uploaded_file: # reset directories adn session states when there are no uploaded files.
            remove_contents(upload_dir)
            remove_contents(extracted_text_dir)
            remove_contents(image_dir)
            remove_contents(preprocessed_dir)
            remove_contents(metadata_dir)
            remove_contents(output_dir)
            set_session_states("new_upload")
                
        upload_confirm, database_creds = st.columns(2)

        if not st.session_state.uploaded_file: 
            st.warning("Please upload a pdf file to proceed.")
        else:
            with database_creds:
                st.button("Connect to Database", on_click = submit_credentials)

            with upload_confirm:
                st.button("Confirm Upload", on_click = upload_pdf,disabled = st.session_state.confirm_upload)

        if st.session_state.submit_credentials:
            input_credentials()
            
        if st.session_state.upload_pdf:
            with upload_con:
                message_con = st.container(height = 100)
            
            if st.session_state.confirm_upload == False:
                # Save the pdfs
                for file in st.session_state.uploaded_file:
                    try:
                        file_name = os.path.splitext(file.name)[0]
                        file_name = preprocessing.remove_unaccepted_chars(file_name)

                        file_path = os.path.join(upload_dir, f"{file_name}.pdf")

                        # Save the file
                        with open(file_path, "wb") as f:
                            f.write(file.getbuffer())
                        with message_con:
                            st.success(f"Uploaded {file.name}")
                    except Exception as e:
                        with message_con:
                            st.error(f"Error Uploading The File :{file.name}")
                            print(f"Error Uploading The File {file.name}: {e}")
                        continue
                
                # Extract images from the pdfs
                
                for file_name in os.listdir(upload_dir): # iterate for each file in the directory
                    try:
                        extract_image(upload_dir, image_dir, file_name)
                        
                        with message_con:
                            st.success(f"Succeeded converting the pdf {file_name} to image")
                            print(f"Succeeded converting the pdf {file_name} to image")
                    except Exception as e:
                        with message_con:
                            st.error(f"Error converting the pdf {file_name} to image")
                            print(f"Error converting the pdf {file_name} to image: {e}")
                        continue

                st.session_state.confirm_upload = True

        if st.session_state.confirm_upload:
            if not directory_check(upload_dir):
                with message_con:
                    st.error("The files were not uploaded")
            else:
                uploaded_files = []
                for file in st.session_state.uploaded_file:
                    file_name = os.path.splitext(file.name)[0]
                    file_name = preprocessing.remove_unaccepted_chars(file_name)
                    file_name = f"{file_name}.pdf"

                    uploaded_files.append(file_name)
                
                list_1 = uploaded_files
                list_2 = [file for file in os.listdir(upload_dir)]

                with message_con:
                    difference = file_process_check(list_1, list_2)

                    if not difference:
                        st.success("All files where uploaded")
                    elif difference:
                        for item in difference:
                            st.error(f"The file {item} could not be uploaded")
  
    with st.sidebar:
        if st.session_state.image_converted == True:
        
            st.title("Perform Image Prepocessing")
            options = image_processing_options()

            for option in options:
                st.session_state[option["key"]] = st.sidebar.checkbox(option["label"], on_change = process_change)
            
            message_con = st.container(height = 200)
            
            if st.button("Preprocess Images", disabled = not st.session_state.process_change):

                if st.session_state.process_done == False:

                    for file_name in os.listdir(image_dir): # iterate for each file in the directory
                        document_pages = os.path.join(image_dir, file_name) # path being examined
                        
                        if directory_check(document_pages): # check if the path exist, is a directory, and has contents
                            with message_con:
                                st.success(f"Preprocessing file: {file_name}")
                                print(f"Preprocessing file: {file_name}")
                            
                            # directory containing the preprocessed images of the pdf
                                processed_image_dir = os.path.join(preprocessed_dir, file_name) 
                                if not os.path.exists(processed_image_dir):# Ensure the directory exists
                                    os.makedirs(processed_image_dir)

                            try:
                                # iterate for each file in the image directory starting with 1
                                for page_number, page_image in enumerate(os.listdir(document_pages), start = 1): 
                                    if page_image.endswith(".png"): # Check if the file is a png
                                        
                                            image_path = os.path.join(document_pages, page_image) # path of the image
                                            
                                            image = cv.imread(image_path) # Read the image
                                            
                                            processed_image = preprocess(image) # Perform preprocessing on the images

                                            processed_path = os.path.join(processed_image_dir, page_image) # path of the preprocessed image
                                            cv.imwrite(processed_path, processed_image)
                                
                                with message_con:
                                    st.success(f"Preprocessed the file: {os.path.basename(document_pages)}")
                                    print(f"Preprocessed the file: {os.path.basename(document_pages)}")

                            except Exception as e:
                                with message_con:
                                    st.error(f"Error Preprocessing  {file_name}")
                                    print(f"Error Preprocessing {file_name}: {e}")
                                continue
                            
                        st.session_state.process_done = True

                    st.session_state.process_change = False
            
            if st.button("Undo Changes"):
                st.session_state.process_done = False
                remove_contents(preprocessed_dir)
                
                for option in options:
                    st.session_state[option["key"]] = False

                show_message("Undo Changes")

            if st.session_state.process_done:
                if not directory_check(preprocessed_dir):
                    with message_con:
                        st.error("The files were not preprocessed")
                        print("The files were not preprocessed")
                else:
                    list_1 = [file for file in os.listdir(preprocessed_dir)]
                    list_2 = [file for file in os.listdir(image_dir)]

                    with message_con:
                        difference = file_process_check(list_1, list_2)
                        
                        if not difference:
                            st.success("All files where preprocessed")
                        elif difference:
                            for item in difference:
                                st.error(f"The file {item} could not be preprocessed")
        
                    
    with extract_col:
        st.markdown('<h4 style="text-align: left;">Extract Text from the PDF:</h4>', unsafe_allow_html=True)

        # Performs the text extraction when clicked
        st.button("Extract Files", on_click = extract, disabled = not st.session_state.confirm_upload)
        
        if st.session_state.extract:
            message_con = st.container(height = 100)
        
        if st.session_state.extract:
            with message_con: # Message for when there are no uploaded files
                if not st.session_state.uploaded_file:
                    st.error("Please Upload A File")
            
            if st.session_state.process_done == True:
                dir_to_extract = preprocessed_dir
            else:
                dir_to_extract = image_dir
        
            # When extracting, itirate through the pdf image directories and output a text file in the text directory
            if st.session_state.extract_done == False:
                for file_name in os.listdir(dir_to_extract): # iterate for each file in the directory
                    document_pages = os.path.join(dir_to_extract, file_name) # path being examined
                    
                    if directory_check(document_pages): # if document_pages is a dir, create text file and extract
                        with message_con:
                            st.success(f"Processing file: {file_name}")

                        text_file_name = os.path.splitext(file_name)[0] + ".txt" # Specify output file name
                        text_file_path = os.path.join(extracted_text_dir, text_file_name) # Creates output file path

                        make_text_file(text_file_path) # Create a new text file

                        # Extract text from the PDF
                        try:
                            images_to_text(document_pages, text_file_path)
                            with message_con:
                                st.success(f"Successfully extracted: {file_name}")
                        except Exception as e:
                            st.error(f"Error extracting: {file_name}")
                            continue

                        st.session_state.extract_done = True
          
            if st.session_state.extract_done:
                if not directory_check(extracted_text_dir):
                    with message_con:
                        st.error("The files were not extracted")
                        print("The files were not extracted")
                else:
                    list_1 = [file for file in os.listdir(preprocessed_dir)]
                    list_2 = [file for file in os.listdir(dir_to_extract)]

                    with message_con:
                        difference = file_process_check(list_1, list_2)
                        
                        if not difference:
                            st.success("All files where extracted")
                        elif difference:
                            for item in difference:
                                st.error(f"The file {item} could not be extracted")

    with document_selection:
        # Preview PDFs    
        if st.session_state.confirm_upload:
            st.markdown('<h4 style="text-align: center;">Select PDF File</h4>', unsafe_allow_html=True)
            
            if st.session_state.process_done == True:
                selection_dir = preprocessed_dir
            else:
                selection_dir = image_dir
            
            # List all subdirectories in the parent directory
            pdf_images = []
            if directory_check(selection_dir):
                pdf_images = [dir for dir in os.listdir(selection_dir) if os.path.isdir(os.path.join(selection_dir, dir))]
            else:
                print(f"The directory {os.path.basename(selection_dir)} does not exist, is inaccessible, or the file was not converted to an image")
                
            st.session_state.selected_pdf = st.selectbox("Select a PDF:", pdf_images)

            image_files = []
            if st.session_state.selected_pdf:
                pdf_images_dir = os.path.join(selection_dir, st.session_state.selected_pdf)
                image_files = [os.path.splitext(file)[0] for file in os.listdir(pdf_images_dir) if file.endswith('.png')]

            if not image_files:
                st.warning(f"No image files found in the directory: {st.session_state.selected_pdf}")
            else:
                image_files_sorted = sorted(image_files, key = int)
                min_page = int(image_files_sorted[0])
                max_page = int(image_files_sorted[-1])
                
                st.session_state.selected_page = st.number_input("Select page", min_value=min_page, max_value=max_page, step=1)
    
    with image_view:
        # Display the selected image
        if st.session_state.selected_page:
            st.markdown('<h4 style="text-align: center;">View Page Images</h4>', unsafe_allow_html=True)
            
            page_number = st.session_state.selected_page
            st.session_state.selected_page = f"{st.session_state.selected_page}.png"

            image_path = os.path.join(pdf_images_dir, st.session_state.selected_page)
            
            if not os.path.exists(image_path):
                st.error("Image file does not exist")
            else:
                st.write("Page View")
                st.image(image_path, caption=f"Page {page_number}", use_column_width=True)
            
    with upload_col:
        st.markdown('<h4 style="text-align: left;">Upload to Database:</h4>', unsafe_allow_html=True)
        
        button_1, button_2 = st.columns(2)
        
        with button_1:
            st.button("Upload Files", on_click = upload_database, disabled = not st.session_state.extract_done or st.session_state.upload_done)
        
        if st.session_state.upload_database:
            with button_2:
                st.button("Upload Again", on_click = upload_again, disabled = not st.session_state.upload_database or st.session_state.upload_done)

        if st.session_state.extract_done:
            message_con = st.container(height = 100)
        
        if st.session_state.extract_done and not st.session_state.upload_done:
            with message_con:
                st.warning("Remember to check the Metadata of your file before uploading")

        if st.session_state.upload_database:    
            if st.session_state.upload_done == False:
                # make ouput files which combine the metadata with the extracted text
                create_output(metadata_dir, extracted_text_dir, output_dir)

                if not st.session_state.credentials_submitted:
                    with message_con:
                        st.error("Files Cannot be Uploaded: You are not Connected to the Database")
                else:
                    for file_name in os.listdir(output_dir): # iterate for each file in the directory
                        if file_name.endswith(".txt"):
                            
                            file_path = os.path.join(output_dir, file_name)

                            with open(file_path, 'r', encoding='utf-8') as f:
                                file_content = [f.readline() for i in range(3)]
                            
                            ignore_words = words_to_ignore()
            
                            # Process each line and ignore the specific word
                            for i in range(len(file_content)):
                                filtered_line = ' '.join([word for word in file_content[i].split() if word not in ignore_words])
                                file_content[i] = filtered_line

                            with message_con:
                                st.success(f"Uploading the Document: {file_content[0]}")
                            
                            title = file_content[0]
                            authors = [item.strip() for item in file_content[1].split(',') if item.strip()]
                            tags = [item.strip() for item in file_content[2].split(',') if item.strip()]

                            demo_main.format_upload_doc(file_path, title, authors, tags,
                                                        db_name = st.session_state.db_name,
                                                        db_user = st.session_state.db_user,
                                                        db_password = st.session_state.db_password, 
                                                        db_host = st.session_state.db_host,
                                                        db_port = st.session_state.db_port
                                                        )
                            
                            with message_con:
                                st.success(f"{file_content[0]} Uploaded")

                            st.session_state.upload_done = True
        
        if st.session_state.upload_again:
            remove_contents(upload_dir)
            remove_contents(extracted_text_dir)
            remove_contents(image_dir)
            remove_contents(preprocessed_dir)
            remove_contents(metadata_dir)
            remove_contents(output_dir)
            set_session_states("new_upload")
            st.rerun()

        if st.session_state.upload_done:
            with message_con:
                st.success("All Files Uploaded")

    with edit_metadata:
        if st.session_state.extract_done == True:
            st.markdown('<h4 style="text-align: center;">Edit Metadata</h4>', unsafe_allow_html=True)
            if os.listdir(extracted_text_dir) and not os.listdir(metadata_dir):
                create_metadata_file(extracted_text_dir, metadata_dir)

            meta_con = st.container()
            # Input metadata
            with meta_con:
                if os.listdir(metadata_dir):
                    meta_file = os.path.splitext(st.session_state.selected_pdf)[0] + ".txt"
                    meta_path = os.path.join(metadata_dir, meta_file)
                    metadata(meta_path)

    with text_view:
         # Preview text files
        if st.session_state.extract_done == True:
            st.markdown('<h4 style="text-align: center;">View Text Output</h4>', unsafe_allow_html=True)

            if st.session_state.selected_pdf:
                selected_file = os.path.splitext(st.session_state.selected_pdf)[0] + ".txt"
                selected_file_path = os.path.join(extracted_text_dir, selected_file)
            
            if text_content_check(selected_file_path):
                # Read the selected file
                with open(selected_file_path, "r", encoding="utf-8") as file:
                    file_content = file.read()
            
                # Display the file content in a text area
                st.text_area("File Content", file_content, height = 700)
        

if __name__ == "__main__":
    main()