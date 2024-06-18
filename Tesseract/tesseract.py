import pytesseract
from pdf2image import convert_from_path
import os
import cv2 as cv
import numpy as np

import mysql.connector
from mysql.connector import errorcode

import streamlit as st
import io


# DATABASE FUNCTIONS---------------------


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

#       Preprocessing Functions---------------------

# Remove Images
def remove_images(image):
    #lower and upper limit of binarizing
    lower = 210
    upper = 230
    # Convert the image to grayscale
    gray_image = cv.cvtColor(image, cv.COLOR_BGR2GRAY)

    # Perform thresholding to convert grayscale image to binary (black and white)
    thresh, binarized = cv.threshold(gray_image, lower, upper, cv.THRESH_BINARY)

    # Invert the binary image (so that text becomes white on black background)
    inverted_image = cv.bitwise_not(binarized)

    return inverted_image

# Remove Noise
def remove_noise(image):
    iteration = 1
    
    kernel = np.ones((1, 1), np.uint8)
    image = cv.dilate(image, kernel, iteration)
    
    kernel = np.ones((1, 1), np.uint8)
    image = cv.erode(image, kernel, iteration)
    
    image = cv.morphologyEx(image, cv.MORPH_CLOSE, kernel)
    image = cv.medianBlur(image, 3)
    
    return image

# Dilate and Erode
def thick_font(image):

    image = cv.bitwise_not(image)
    kernel = np.ones((2,2),np.uint8)
    image = cv.dilate(image, kernel, iterations=1)
    image = cv.bitwise_not(image)
    
    return image

def thin_font(image):
    import numpy as np
    image = cv.bitwise_not(image)
    kernel = np.ones((2,2),np.uint8)
    image = cv.erode(image, kernel, iterations=1)
    image = cv.bitwise_not(image)
    return image

#Crop Images
def crop_image(image):
    height, width = image.shape[:2]
    
    top_crop = 0.05
    bottom_crop = 0.05
    left_crop = 0
    right_crop = 0

    top = int(height * top_crop)
    bottom = height - int(height * bottom_crop)
    left = int(width * left_crop)
    right = width - int(width * right_crop)

    cropped_image = image[top:bottom, left:right]
    
    return cropped_image

#Remove Borders automatically
def remove_borders(image):
    contours, heiarchy = cv.findContours(image, cv.RETR_EXTERNAL, cv.CHAIN_APPROX_SIMPLE)
    cntsSorted = sorted(contours, key=lambda x:cv.contourArea(x))
    cnt = cntsSorted[-1]
    x, y, w, h = cv.boundingRect(cnt)
    crop = image[y:y+h, x:x+w]
    
    return (crop)

# Add Borders
def add_borders(image):
    color = [255, 255, 255]
    top, bottom, left, right = [150]*4

    image_with_border = cv.copyMakeBorder(image, top, bottom, left, right, cv.BORDER_CONSTANT, value=color)

    return image_with_border

# Rotation and Deskewing
def getSkewAngle(cvImage) -> float:
    # Prep image, copy, convert to gray scale, blur, and threshold
    newImage = cvImage.copy()
    gray = cv.cvtColor(newImage, cv.COLOR_BGR2GRAY)
    blur = cv.GaussianBlur(gray, (9, 9), 0)
    thresh = cv.threshold(blur, 0, 255, cv.THRESH_BINARY_INV + cv.THRESH_OTSU)[1]

    # Apply dilate to merge text into meaningful lines/paragraphs.
    # Use larger kernel on X axis to merge characters into single line, cancelling out any spaces.
    # But use smaller kernel on Y axis to separate between different blocks of text
    kernel = cv.getStructuringElement(cv.MORPH_RECT, (30, 5))
    dilate = cv.dilate(thresh, kernel, iterations=2)

    # Find all contours
    contours, hierarchy = cv.findContours(dilate, cv.RETR_LIST, cv.CHAIN_APPROX_SIMPLE)
    contours = sorted(contours, key = cv.contourArea, reverse = True)
    for c in contours:
        rect = cv.boundingRect(c)
        x,y,w,h = rect
        cv.rectangle(newImage,(x,y),(x+w,y+h),(0,255,0),2)

    # Find largest contour and surround in min area box
    largestContour = contours[0]
    print (len(contours))
    minAreaRect = cv.minAreaRect(largestContour)
    cv.imwrite("temp/boxes.jpg", newImage)
    # Determine the angle. Convert it to the value that was originally used to obtain skewed image
    angle = minAreaRect[-1]
    if angle < -45:
        angle = 90 + angle
    return -1.0 * angle

# Rotate the image around its center
def rotateImage(cvImage, angle: float):
    newImage = cvImage.copy()
    (h, w) = newImage.shape[:2]
    center = (w // 2, h // 2)
    M = cv.getRotationMatrix2D(center, angle, 1.0)
    newImage = cv.warpAffine(newImage, M, (w, h), flags=cv.INTER_CUBIC, borderMode=cv.BORDER_REPLICATE)
    return newImage

# Deskew image
def deskew(cvImage):
    angle = getSkewAngle(cvImage)
    return rotateImage(cvImage, -1.0 * angle)


#       Main Extraction Function-----------------


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

        # Convert PIL image to OpenCV image
        page_image = cv.cvtColor(np.array(page_image), cv.COLOR_RGB2BGR)
        # Crop header and footnote
        cropped_image = crop_image(page_image)

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


# MAIN----------------


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





    if 'uploaded_file' not in st.session_state:
        st.session_state.uploaded_file = None

    for item in st.session_state.items():
        print("Beginning of Session:")
        print(f"{item}")

    # Create diectory for the uploaded files
    uploaded_files = "uploaded_pdf"
    extraction_dir = f"{os.path.join(os.getcwd(), uploaded_files)}"
    if not os.path.exists(extraction_dir):# Ensure the extraction directory exists
        os.makedirs(extraction_dir)

    # Create new directory for the output files
    new_directory = "output_text"
    output_directory = os.path.join(extraction_dir, new_directory)
    if not os.path.exists(output_directory):# Ensure the extraction directory exists
        os.makedirs(output_directory)

    st.markdown("<h1 style='text-align: center;'>Tesseract Extractor</h1>", unsafe_allow_html=True)
    st.markdown("<p style='text-align: center;'>Extract PDFs and add them directly to the database.</p>", unsafe_allow_html=True)
    st.write("")

    col1, col2 = st.columns(2)

    with col1:
        st.write("Extract PDFs:")

        st.session_state.uploaded_file = st.file_uploader("Choose a file", type = "pdf", accept_multiple_files = True)
        st.success(f"{len(st.session_state.uploaded_file)} file(s) uploaded")

        if st.session_state.uploaded_file is not None: 
            
            for uploaded_file in st.session_state.uploaded_file:
                pdf_path = os.path.join(extraction_dir, uploaded_file.name)
    
                # Save the file
                with open(pdf_path, "wb") as f:
                    f.write(uploaded_file.getbuffer())

            for item in st.session_state.items():
                print("Before Extraction:")
                print(f"{item}")
                
            if st.button("Extract Files"):
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
                
                #if os.path.exists(extraction_dir):# Delete files in extraction Diectory afterwards
                #    for root, dirs, files in os.walk(extraction_dir, topdown=False):
                #        for name in files:
                #            os.remove(os.path.join(root, name))
                #        for name in dirs:
                #            os.rmdir(os.path.join(root, name))

                st.success("Extraction Complete")
                st.session_state.uploaded_file = None
        else:
            st.write("Please upload a pdf file to proceed.")


if __name__ == "__main__":
    main()