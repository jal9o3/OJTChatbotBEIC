import pytesseract
from pdf2image import convert_from_path
import os
from PIL import Image

import mysql.connector
from mysql.connector import errorcode

import streamlit as st
from zipfile import ZipFile
import io


    #DATABASE FUNCTIONS---------------------


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

#Inserts the extracted text from the pdf to the database
def insert_paper(output_file_path, file_name, cursor, conn):
    # Read extracted text
    with open(output_file_path, 'r', encoding='utf-8') as f:
        text = f.read()

    # Insert paper record into Papers table
    cursor.execute("""
        INSERT INTO Papers (title)
        VALUES (%s)
    """, (file_name,))
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


#EXTRACTION FUNCTIONS------------------


def remove_images(page_image):
    # Convert the image to grayscale
    gray_image = page_image.convert('L')

    # Perform thresholding to convert grayscale image to binary (black and white)
    binary_image = gray_image.point(lambda pixel: 255 if pixel > 200 else 0, '1')

    # Invert the binary image (so that text becomes white on black background)
    inverted_image = Image.eval(binary_image, lambda pixel: 255 - pixel)

    return inverted_image

def pdf_to_text(pdf_path, file_path):
    #configuration for Tesseract
    #psm 1 - Automatic page segmentation with Orientation and Script Detection
    #oem 3 - Default, mode based on the available
    my_config = r"--psm 1 --oem 3"

    print(f"Starting text extraction from: {pdf_path}")
    pages = convert_from_path(pdf_path) # Convert PDF pages to images
    print(f"Converted {len(pages)} pages to images.")

    # Iterate through each page image and perform OCR
    for page_number, page_image in enumerate(pages, start=1):
        print(f"Processing page {page_number} of {pdf_path}")
        width, height = page_image.size

        # Crop header and footnote
        top_crop = int(0.05 * height)
        bottom_crop = int(0.95 * height)
        cropped_image = page_image.crop((0, top_crop, width, bottom_crop))
        print(f"Cropped page {page_number}: top {top_crop}px, bottom {bottom_crop}px")

        # Remove images from the page
        text_image = remove_images(cropped_image)
        print(f"Images removed from page {page_number}")

        # Perform OCR on the page image
        text = pytesseract.image_to_string(text_image, config=my_config)
        print(f"OCR performed on page {page_number}")

        with open(file_path, 'a', encoding='utf-8') as f: # Append extracted text to the file
            f.write(f"\n{text}\n")
        print(f"Appended text of page {page_number} to {file_path}")

    print(f"Completed text extraction from: {pdf_path}")



    #MAIN FUNCTION--------------------------



def main():
    
    print("Provide your MySQL credentials.") # Ask user for MySQL host address, user name, and password
    if "host" not in st.session_state:
        st.session_state.host = input("Enter host (default: 127.0.0.1): ")
        if st.session_state.host == "":# Set host to 127.0.0.1 if blank
            st.session_state.host = "127.0.0.1"
    if "user" not in st.session_state:
        st.session_state.user = input("Enter user (default: root): ")
        if st.session_state.user == "":# Set user to root if blank
            st.session_state.user = "root"
    if "password" not in st.session_state:
        st.session_state.password = input("Enter password: ")

    # Connect to MySQL server
    try:
        conn = mysql.connector.connect(
            host=st.session_state.host,
            user=st.session_state.user,
            password=st.session_state.password
        )
        cursor = conn.cursor()
        print("Connected to MySQL server.")

        # Display existing databases
        show_databases(cursor)

        # Ask user for a database name

        if "db_name" not in st.session_state:
            st.session_state.db_name = input("Enter the database name: ")

        # Check if the database exists
        if database_exists(cursor, st.session_state.db_name):
            print(f"Database '{st.session_state.db_name}' exists.")
        else:
            # Create the database if it doesn't exist
            try:
                cursor.execute(f"CREATE DATABASE {st.session_state.db_name}")
                print(f"Database '{st.session_state.db_name}' created.")
            except mysql.connector.Error as err:
                print(f"Failed creating database: {err}")
                exit(1)

        # Connect to the specified database
        conn.database = st.session_state.db_name
        print(f"Connected to the database '{st.session_state.db_name}'.")

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
        
        print(f"Tables in the database '{st.session_state.db_name}':")
        for table in tables:
            print(table[0])

    except mysql.connector.Error as err:
        if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
            print("Something is wrong with your user name or password")
        elif err.errno == errorcode.ER_BAD_DB_ERROR:
            print("Database does not exist")
        else:
            print(err)
            conn.rollback()


    st.title("Tesseract Extractor")
    st.write("Extract PDFs and add them directly to the database")
    st.write("")
    st.write("Extract a diectory of PDFs:")

    if 'uploaded_file' not in st.session_state:
        st.session_state.uploaded_file = None
    
    if 'file_bytes' not in st.session_state:
        st.session_state.file_bytes = None

    for item in st.session_state.items():
        item

    #if st.button("Upload zip file:"):
    st.session_state.uploaded_file = st.file_uploader("Choose a zip file")
    
    if st.session_state.uploaded_file is not None: 
        st.success("File Uploaded")
        st.session_state.file_bytes = io.BytesIO(st.session_state.uploaded_file.read())

        for item in st.session_state.items():
            item

        # Extract the zip file
        with ZipFile(st.session_state.file_bytes) as zfile:
            # List all files in the zip
            st.write("Files in the zip:")
            for file_info in zfile.infolist():
                st.write(f"{file_info.filename} ({file_info.file_size} bytes)")
        
            if st.button("Extract Files"):
                # Create extraction directory
                zip_filename = os.path.splitext(st.session_state.uploaded_file.name)[0]
                st.write(zip_filename)
                extraction_dir = f"{os.path.join(os.getcwd(),zip_filename)}"
                st.write(extraction_dir)
                
                if not os.path.exists(extraction_dir):# Ensure the extraction directory exists
                    os.makedirs(extraction_dir)
                
                # Extract all files to the specified directory
                zfile.extractall(path=extraction_dir)
                
                # Create new directory for the output files
                new_directory = "output_text"
                output_directory = os.path.join(extraction_dir, new_directory)
                if not os.path.exists(output_directory):# Ensure the extraction directory exists
                    os.makedirs(output_directory)
                
                for file_name in os.listdir(extraction_dir): # iterate for each file in the directory
                    if file_name.endswith(".pdf"): # Check if the file is a pdf
                        st.success(f"Processing file: {file_name}")
                        pdf_path = os.path.join(extraction_dir, file_name) # Specify path to the PDF file

                        output_file_name = os.path.splitext(file_name)[0] + ".txt" # Specify output file name
                        output_file_path = os.path.join(output_directory, output_file_name) # Creates file path

                        try: # Creates a new file
                            with open(output_file_path, 'x', encoding='utf-8') as f:
                                f.close()
                        except FileExistsError: # If file already exists, write over existing file rendering its contents null
                            with open(output_file_path, 'w', encoding='utf-8') as f: 
                                f.close()

                        # Extract text from the PDF
                        pdf_to_text(pdf_path, output_file_path)
                        st.success(f"Saved as {output_file_name} at {output_file_path}")

                        insert_paper(output_file_path, file_name, cursor, conn)
                
                #if os.path.exists(extraction_dir):# Delete extraction Diectory afterwards
                #    for root, dirs, files in os.walk(extraction_dir, topdown=False):
                #        for name in files:
                #            os.remove(os.path.join(root, name))
                #        for name in dirs:
                #            os.rmdir(os.path.join(root, name))
                #    os.rmdir(extraction_dir)

            st.success("Extraction Complete")
    else:
        st.write("Please upload a zip file to proceed.")


if __name__ == "__main__":
    main()