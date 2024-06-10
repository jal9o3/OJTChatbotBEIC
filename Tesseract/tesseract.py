import pytesseract
from pdf2image import convert_from_path
import os
from PIL import Image

import mysql.connector
from mysql.connector import errorcode

'''

    DATABASE FUNCTIONS

'''

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


'''

    EXTRACTION FUNCTIONS

'''

def remove_images(page_image):
    # Convert the image to grayscale
    gray_image = page_image.convert('L')

    # Perform thresholding to convert grayscale image to binary (black and white)
    binary_image = gray_image.point(lambda pixel: 255 if pixel > 200 else 0, '1')

    # Invert the binary image (so that text becomes white on black background)
    inverted_image = Image.eval(binary_image, lambda pixel: 255 - pixel)

    return inverted_image

def pdf_to_text(pdf_path, file_path):
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
        text = pytesseract.image_to_string(text_image)
        print(f"OCR performed on page {page_number}")

        with open(file_path, 'a', encoding='utf-8') as f: # Append extracted text to the file
            f.write(f"\n{text}\n")
        print(f"Appended text of page {page_number} to {file_path}")

    print(f"Completed text extraction from: {pdf_path}")


'''

    MAIN FUNCTION

'''

def main():

    # Ask user for MySQL host address, user name, and password
    print("Provide your MySQL credentials.")
    host = input("Enter host (default: 127.0.0.1): ")
    # Set host to 127.0.0.1 if blank
    if host == "":
        host = "127.0.0.1"
    # Set user to root if blank
    user = input("Enter user (default: root): ")
    if user == "":
        user = "root"
    password = input("Enter password: ")

    # Connect to MySQL server
    try:
        conn = mysql.connector.connect(
            host=host,
            user=user,
            password=password
        )
        cursor = conn.cursor()
        print("Connected to MySQL server.")

        # Display existing databases
        show_databases(cursor)

        # Ask user for a database name
        db_name = input("Enter the database name: ")

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

    except mysql.connector.Error as err:
        if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
            print("Something is wrong with your user name or password")
        elif err.errno == errorcode.ER_BAD_DB_ERROR:
            print("Database does not exist")
        else:
            print(err)
            conn.rollback()


    directory_path = input("Enter folder containing PDF files: ") # Specify pdf file directory
    print(f"Directory specified: {directory_path}")
    
    # Create new directory for the output files
    new_directory = "output_text"
    output_directory = os.path.join(directory_path, new_directory)
    try: # Creates a new file
        os.mkdir(output_directory)
        print(f"Created new directory: {output_directory}")
    except FileExistsError: # notify if the directory already exists
        print(f"The directory '{output_directory}' already exists.")
    
    for file_name in os.listdir(directory_path): # iterate for each file in the directory
        if file_name.endswith(".pdf"): # Check if the file is a pdf
            print(f"Processing file: {file_name}")
            pdf_path = os.path.join(directory_path, file_name) # Specify path to the PDF file

            output_file_name = os.path.splitext(file_name)[0] + ".txt" # Specify output file name
            output_file_path = os.path.join(output_directory, output_file_name) # Creates file path

            try: # Creates a new file
                with open(output_file_path, 'x', encoding='utf-8') as f:
                    f.close()
                print(f"Created new file: {output_file_path}")
            except FileExistsError: # If file already exists, write over existing file rendering its contents null
                with open(output_file_path, 'w', encoding='utf-8') as f:
                    f.close()
                print(f"Overwriting existing file: {output_file_path}")

            # Extract text from the PDF
            pdf_to_text(pdf_path, output_file_path)
            print(f"Saved as {output_file_name} at {output_file_path}")

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

    print("Extraction Complete")


if __name__ == "__main__":
    main()