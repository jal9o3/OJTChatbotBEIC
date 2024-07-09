import streamlit as st

import pytesseract

from pdf2image import convert_from_path
from PyPDF2 import PdfReader

import cv2 as cv
import numpy as np
import pandas as pd
from PIL import Image

import preprocessing

from io import BytesIO
import os

import time

import mysql.connector
from mysql.connector import errorcode

time_list = []

# DATABASE FUNCTIONS---------------------

#       Other Database Functions

# Function to display existing databases
def show_databases(cursor):
    cursor.execute("SHOW DATABASES")
    databases = cursor.fetchall()
    print("Existing databases:")
    for (database,) in databases:
        print(f" - {database}")

# Function to check if a database exists
def database_exists(cursor, db_name):
    cursor.execute("SHOW DATABASES LIKE %s", (db_name,))
    return cursor.fetchone() is not None

#       Main Database Function

@st.experimental_dialog("Provide your MySQL credentials.", width="large")
def get_credentials():
    # Ask user for MySQL host address, user name, and password

    db_name = st.text_input("Connect to Database:", placeholder = "iraya_database")
    host = st.text_input("Enter host: ", placeholder = "default: 127.0.0.1")
    user = st.text_input("Enter user: ", placeholder = "root")
    password = st.text_input("Enter password: ", type = "password")

    if st.button("Submit"):
        if host == "":# Set host to 127.0.0.1 if blank
            host = "127.0.0.1"
        
        if user == "":# Set user to root if blank
            user = "root"

        if db_name == "":# Set host to 127.0.0.1 if blank
            db_name = "iraya_database"
        
        _,_,p_check = connect_SQL(host, user, password)
        
        if p_check:
            st.session_state.db_name = db_name
            st.session_state.host = host
            st.session_state.user = user
            st.session_state.password = password
            
        else:
            st.error("Wrong Password")
        
        st.rerun()

def connect_SQL(host, user, password):
    try:
        conn = mysql.connector.connect(
            host=host,
            user=user,
            password=password
        )
        cursor = conn.cursor()
        show_message("Connected to MySQL server.")

        p_check = True

        return conn, cursor, p_check
    
    except mysql.connector.Error as err:
        if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
            show_message("Something is wrong with your user name or password")
        else:
            show_message(err)
            conn.rollback()
        
        return conn, cursor, p_check

def connect_db(conn, cursor, db_name):
    # Connect to MySQL server
    try:
        
        # Display existing databases
        show_databases(cursor)

        # Ask user for a database name

        #db_name = "iraya_database"
        #db_name = input("Enter the database name: ")

        # Check if the database exists
        if database_exists(cursor, db_name):
            print(f"Database '{db_name}' exists.")
        else:
            # Create the database if it doesn't exist
            try:
                cursor.execute(f"CREATE DATABASE {db_name}")
                print(f"Database '{db_name}' created.")
            except mysql.connector.Error as err:
                print(f"Failed creating database: {err}")
                exit(1)

        # Connect to the specified database
        conn.database = db_name
        print(f"Connected to the database '{db_name}'.")

        # Create Papers table
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS Papers (
                paper_id INT AUTO_INCREMENT PRIMARY KEY,
                title VARCHAR(255) NOT NULL
            )
        """)

        # Create Chunks table
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS Chunks (
                chunk_id INT AUTO_INCREMENT PRIMARY KEY,
                paper_id INT,
                chunk_order INT NOT NULL,
                chunk_text VARCHAR(255) NOT NULL,
                FOREIGN KEY (paper_id) REFERENCES Papers(paper_id)
            )
        """)

        # List tables
        cursor.execute("SHOW TABLES")
        tables = cursor.fetchall()
        
        print(f"Tables in the database '{db_name}':")
        for table in tables:
            print(table[0])

        return cursor, conn

    except mysql.connector.Error as err:
        if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
            print("Something is wrong with your user name or password")
        elif err.errno == errorcode.ER_BAD_DB_ERROR:
            print("Database does not exist")
        else:
            print(err)
            conn.rollback()

#Inserts the extracted text from the pdf to the database
def insert_paper(file_path, file, cursor, conn):
    # Read extracted text
    with open(file_path, 'r', encoding='utf-8') as f:
        text = f.read()

    # Insert paper record into Papers table
    cursor.execute("""
        INSERT INTO Papers (title)
        VALUES (%s)
    """, (file,))
    paper_id = cursor.lastrowid
    conn.commit()

    chunk_size = 255
    chunks = [text[i:i + chunk_size] for i in range(0, len(text), chunk_size)]

    chunk_order = 1
    for chunk in chunks:
        cursor.execute("""
            INSERT INTO Chunks (paper_id, chunk_order, chunk_text)
            VALUES (%s, %s, %s)
        """, (paper_id, chunk_order, chunk))
        chunk_order += 1

    conn.commit()
# EXTRACTION FUNCTIONS------------------

@st.cache_data
def extract_image(upload_dir, image_dir):
    # Convert pdfs to images
    for file_name in os.listdir(upload_dir): # iterate for each file in the directory
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
                page_image = convert_from_path(file_path, first_page=page_number, last_page=page_number) # Convert PDF pages to images
                try:
                    image_path = os.path.join(file_image_dir, f"{page_number}.png") # path of the image
                    page_image[0].save(image_path)
                except Exception as e:
                    st.error(f"Error saving file: {e}")
    st.session_state.image_converted = True

def preprocess(image):

    if st.session_state.remove_images == True:
        # Remove images from the page
        image = preprocessing.remove_images(image)

    if st.session_state.remove_noise == True:
        # Remove noise from the page
        image = preprocessing.remove_noise(image)

    if st.session_state.thick_font == True:
        # Thicken the font of the text in the image
        image = preprocessing.thick_font(image)

    if st.session_state.thin_font == True:
        # thin out the font of the text in the image
        image = preprocessing.thin_font(image)

    if st.session_state.remove_borders == True:
        # Remove the borders of the image
        image = preprocessing.remove_borders(image)

    if st.session_state.add_borders == True:
        # Add borders to the image
        image = preprocessing.add_borders(image)

    if st.session_state.crop_image == True:
        # Remove images from the page
        image = preprocessing.crop_image(image)

    if st.session_state.deskew == True:
        # Remove images from the page
        image = preprocessing.deskew(image)

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
        image_path = os.path.join(pdf_images_dir, f"{page_image}.png") # path of the image
        pdf_name = pdf_images_dir
        print(f"Processing page {page_number} of {pdf_name}")
        
        image = cv.imread(image_path) # Read the image
        
        # Perform OCR on the page image
        text = pytesseract.image_to_string(image,lang = 'enga+fil+equ', config=my_config)
        print(f"OCR performed on page {page_number}")
        
        # Perform Text Preprocessing
        text = preprocessing.body_text(text)
        print(f"text preprocessing performed on page {page_number}")

        with open(text_path, 'a', encoding='utf-8') as f: # Append extracted text to the file
            f.write(f"\n\n-----Page {page_number}-----\n\n{text}")
        print(f"Appended text of page {page_number} to {text_path}")

    print(f"Completed text extraction from: {pdf_images_dir}")

# Main--------------------

#       Other Functions of Main-------------------

def image_processing_options():
    options = [
                {"label": "Remove Images", "key": "remove_images"},
                {"label": "Remove Noise", "key": "remove_noise"},
                {"label": "Thicken Font", "key": "thick_font"},
                {"label": "Thin Out Font", "key": "thin_font"},
                {"label": "Remove Borders", "key": "remove_borders"},
                {"label": "Add Borders", "key": "add_borders"},
                {"label": "Crop Image", "key": "crop_image"},
                {"label": "Deskew", "key": "deskew"}
            ]
    return options

def set_session_states(action = "set"):
    options = image_processing_options()

    # Database session_states
    db_keys = ["db_name", "host", "user", "password"]
    button_keys = ["extract", "upload", "process_change"]
    operation_keys = ["extract_done", "upload_done", "process_done", "image_converted"]
    list_keys = ["uploaded_file"]
    image_processing_keys = [option["key"] for option in options]

    all_keys = db_keys + button_keys + operation_keys + list_keys + image_processing_keys

    if action == "set":
        for key in db_keys:
            if key not in st.session_state:
                st.session_state[key] = ""

        for key in button_keys + operation_keys + image_processing_keys:
            if key not in st.session_state:
                st.session_state[key] = False

        for key in list_keys:
            if key not in st.session_state:
                st.session_state[key] = None

    elif action == "reset":
        for key in all_keys:
            if key in db_keys:
                st.session_state[key] = ""
            elif key in button_keys + operation_keys + image_processing_keys:
                st.session_state[key] = False
            elif key in list_keys:
                st.session_state[key] = None
    
def extract():
    st.session_state.extract = True

def upload():
    st.session_state.upload = True

def process_change():
    st.session_state.process_change = True

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

def function_time(label, value):
    global time_list
    time_list.append((label, value))

    return time_list


#       MAIN Function----------------

def main():

    set_session_states("set")

    #Checking session states
    print("Beginning of Session:")
    for item in st.session_state.items():
        print(f"{item}")

    # gets the directory were the script is located
    script_directory = os.path.dirname(os.path.abspath(__file__))

    # Create diectory for the uploaded files
    upload_dir = make_dir(script_directory, "uploaded_pdfs")

    # Create new directory for the output files
    text_dir = make_dir(script_directory, "output_text")

    # Create directory for output image file
    image_dir = make_dir(script_directory, "output_image")

    # Create directory for output image file
    preprocessed_dir = make_dir(script_directory, "preprocessed_image")

    # Layout
    st.set_page_config(page_title="Tesseract OCR Extractor", layout="wide") 
    st.markdown("<h1 style='text-align: center;'>Tesseract Extractor</h1>", unsafe_allow_html=True)
    st.markdown("<p style='text-align: center;'>Extract PDFs and add them directly to the database.</p>", unsafe_allow_html=True)
    st.write("")

    upload_con = st.container() # for upload processes
    extract_col, upload_col = st.columns(2) # extract_col = for extraction processes; upload_col = for database uploading processes
    image_view, text_view = st.columns(2) # for viewing what will be processed



    with upload_con:
        st.write("Extract PDFs:")
        # Uploading of pdf files; the widget can accept multiple pdfs
        st.session_state.uploaded_file = st.file_uploader("Choose a file", type = "pdf", accept_multiple_files = True)
        st.success(f"{len(st.session_state.uploaded_file)} file(s) uploaded")

        if not st.session_state.uploaded_file: # reset directories adn session states when there are no uploaded files.
            remove_contents(upload_dir)
            remove_contents(text_dir)
            remove_contents(image_dir)
            remove_contents(preprocessed_dir)
            extract_image.clear() # clears the images from the cache
            set_session_states("reset")

        # Checking Session States
        print("Before Image Extraction:")
        for item in st.session_state.items():
            print(f"{item}")
                
        if st.session_state.uploaded_file is not None: 
            if st.button("Confirm Upload"):
                # Save the pdfs
                for file in st.session_state.uploaded_file:
                    file_path = os.path.join(upload_dir, file.name)

                    # Save the file
                    with open(file_path, "wb") as f:
                        f.write(file.getbuffer())

                start_time_image = time.time()
                # Extract images from the pdfs
                extract_image(upload_dir, image_dir)
                end_time_image = time.time()
                image_time = end_time_image - start_time_image
                function_time("Image Time", image_time)
                
        else:
            st.write("Please upload a pdf file to proceed.")
        
        
    
    if st.session_state.image_converted == True:
        with st.sidebar:
            st.title("Perform Image Prepocessing")
            options = image_processing_options()

            for option in options:
                st.session_state[option["key"]] = st.sidebar.checkbox(option["label"], on_change = process_change)
            
            if st.button("Preprocess Images", disabled = not st.session_state.process_change):
                show_message("Preprocessing")
                for file_name in os.listdir(image_dir): # iterate for each file in the directory
                    document_pages = os.path.join(image_dir, file_name) # path being examined

                    if os.path.isdir(document_pages): # if document_pages is a dir, proceed to preprocessing
                        # directory containing the preprocessed images of the pdf
                        processed_image_dir = os.path.join(preprocessed_dir, file_name) 
                        if not os.path.exists(processed_image_dir):# Ensure the directory exists
                            os.makedirs(processed_image_dir)
                        
                        show_message(f"Processing file: {file_name}")
                        
                        start_time_process = time.time()
                        # iterate for each file in the image directory starting with 1
                        for page_number, page_image in enumerate(os.listdir(document_pages), start = 1): 
                            if page_image.endswith(".png"): # Check if the file is a png
                                image_path = os.path.join(document_pages, page_image) # path of the image
                                
                                pdf_name = os.path.splitext(document_pages)[0]
                                print(f"Preprocessing page {page_number} of {pdf_name}")
                                
                                image = cv.imread(image_path) # Read the image
                                
                                processed_image = preprocess(image) # Perform preprocessing on the images
                                print(f"Preprocessed Image of Page {page_number}")

                                processed_path = os.path.join(processed_image_dir, page_image) # path of the preprocessed image
                                cv.imwrite(processed_path, processed_image)
                        
                        st.session_state.process_done = True
                        
                        end_time_process = time.time()
                        process_time = end_time_process - start_time_process
                        function_time("Process Time", process_time)

                

                st.session_state.process_change = False
            
            if st.button("Undo Changes"):
                st.session_state.process_done = False
                remove_contents(preprocessed_dir)
                
                for option in options:
                    st.session_state[option["key"]] = False
                show_message("Undo Changes")
                    
    with extract_col:

        st.write("View pdfs:")

        # Checking Session States
        print("Before Extraction:")
        for item in st.session_state.items():
            print(f"{item}")

        
        button_col, message_col = st.columns([0.2, 0.8])
        
        with button_col:
            # Performs the text extraction when clicked
            if st.button("Extract Files", on_click = extract) or st.session_state.extract:
                with message_col:
                    message_con = st.container(height = 75)
                
                with message_con: # Message for when there are no uploaded files
                    if not st.session_state.uploaded_file:
                        st.error("Please Upload A File")
                
                # When extracting, itirate through the pdf image directories and output a text file in the text directory
                if st.session_state.extract_done == False and st.session_state.image_converted:
                    if st.session_state.process_done == True:
                        extraction_dir = preprocessed_dir
                    else:
                        extraction_dir = image_dir
                    
                    start_time_extract = time.time()
                    for file_name in os.listdir(extraction_dir): # iterate for each file in the directory
                        document_pages = os.path.join(extraction_dir, file_name) # path being examined
                        
                        if os.path.isdir(document_pages): # if document_pages is a dir, create text file and extract
                            with message_con:
                                st.success(f"Processing file: {file_name}")

                            text_file_name = os.path.splitext(file_name)[0] + ".txt" # Specify output file name
                            text_file_path = os.path.join(text_dir, text_file_name) # Creates output file path

                            try: # Creates a new file
                                with open(text_file_path, 'x', encoding='utf-8') as f:
                                    f.close()
                            except FileExistsError: # If file already exists, write over the old file
                                with open(text_file_path, 'w', encoding='utf-8') as f: 
                                    f.close()

                            # Extract text from the PDF
                            images_to_text(document_pages, text_file_path)
                            
                            with message_con:
                                st.success(f"Saved as {text_file_name} at {text_file_path}")
                    
                    st.session_state.extract_done = True
                    end_time_extract = time.time()
                    extract_time = end_time_extract - start_time_extract
                    function_time("Extract Time", extract_time)
                
                

            if st.session_state.extract_done == True:
                with message_con:
                        st.success("Extraction Complete")

                print("After Extraction:")
                for item in st.session_state.items():
                    print(f"{item}")

        start_time_preview_image = time.time()
        # Preview PDFs    
        if st.session_state.process_done == True:
            selection_dir = preprocessed_dir
        else:
            selection_dir = image_dir
        
        # List all subdirectories in the parent directory
        if os.path.exists(selection_dir):
            pdf_images = [dir for dir in os.listdir(selection_dir) 
                          if os.path.isdir(os.path.join(selection_dir, dir))]
        else:
            print(f"The directory {selection_dir} does not exist or is inaccessible.")
            pdf_images = []

        selected_pdf = st.selectbox("Select a PDF:", pdf_images)

        if selected_pdf:
            pdf_images_dir = os.path.join(selection_dir, selected_pdf)
            image_files = [os.path.splitext(file)[0] for file in os.listdir(pdf_images_dir) 
                           if file.endswith('.png')]

            if image_files:
                image_files_sorted = sorted(image_files, key = int)
                selected_image = st.selectbox("Select page", image_files_sorted)
                
                # Display the selected image
                if selected_image:
                    selected_image = f"{selected_image}.png"

                    image_path = os.path.join(pdf_images_dir, selected_image)
                    with image_view:
                        st.write("Page View")
                        st.image(image_path, caption=selected_image, use_column_width=True)
            else:
                st.warning(f"No image files found in the directory: {pdf_images}")
        end_time_preview_image = time.time()
        preview_image_time = end_time_preview_image - start_time_preview_image
        function_time("Preview Image Time", preview_image_time)
        
    with upload_col:
        st.write("View Text:")

        button_col, message_col = st.columns([0.2, 0.8])
        #meta_prompt = st.container()
        
        with button_col:
            if st.button("Upload Files", on_click = upload, disabled = not st.session_state.extract_done) or st.session_state.upload == True:
                with message_col:
                    message_con = st.container(height = 75)
                if st.session_state.upload_done == False:
                    
                    get_credentials()

                    conn, cursor, _ = connect_SQL(st.session_state.host, st.session_state.user, st.session_state.password)
                    
                    connect_db(conn, cursor, st.session_state.db_name)

                    start_time_upload = time.time()
                    for file_name in os.listdir(text_dir): # iterate for each file in the directory
                        if file_name.endswith(".txt"):
                            with message_con:
                                st.success(f"Uploading {file_name}")

                            file_path = os.path.join(text_dir, file_name)

                            insert_paper(file_path, file_name, cursor, conn)
                            
                            with message_con:
                                st.success(f"{file_name} Uploaded")
                    with message_con:
                                st.success("All Files Uploaded")
                
                    st.session_state.upload_done = True
                    end_time_upload = time.time()
                    upload_time = end_time_upload - start_time_upload
                    function_time("Upload Time", upload_time)
                
                

                #if st.session_state.upload_done == True:
                #    remove_contents(text_dir)
                #    remove_contents(upload_dir)
                #    remove_contents(image_dir)

        start_time_preview_text = time.time()
         # Preview text files

            # List all text files in the directory
        if st.session_state.extract_done == True:
            if selected_pdf:
            
                file_selected = os.path.splitext(selected_pdf)[0] + ".txt"
                for file in os.listdir(text_dir):
                    if file == file_selected:
                        selected_file = file
            
                file_path = os.path.join(text_dir, selected_file)

            if os.path.exists(file_path):
                # Read the selected file
                with open(file_path, "r", encoding="utf-8") as file:
                    file_content = file.read()
                
                with text_view:
                    # Display the file content in a text area
                    st.text_area("File Content", file_content, height = 700)
        end_time_preview_text = time.time()

        preview_text_time = end_time_preview_text - start_time_preview_text
        function_time("Preview Text Time", preview_text_time)
        

if __name__ == "__main__":
    start_time_main = time.time()
    main()
    end_time_main = time.time()

    main_time = end_time_main - start_time_main
    time_list = function_time("Main Time", main_time)
    
    for label, value in time_list:
        print(f"{label}: {value}")
    

    print(f"")