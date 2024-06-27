import pytesseract
from pdf2image import convert_from_path
import os
import cv2 as cv
import numpy as np
import pandas
from io import BytesIO
from PIL import Image

import mysql.connector
from mysql.connector import errorcode

import streamlit as st


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


#       Main Database Function


def connect_SQL(host, user, password):
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

        db_name = "iraya_database"
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


#       Main Extraction Functions-----------------



def images_to_text(pdf_images, text_file_path):
    #configuration for Tesseract
    #psm 1 - Automatic page segmentation with Orientation and Script Detection
    #oem 3 - Default, mode based on the available
    my_config = r"--psm 1 --oem 3"

    # Iterate through each page image and perform OCR
    for page_number, page_image in enumerate(os.listdir(pdf_images), start = 1): # iterate for each file in the directory
        image_file = os.path.join(pdf_images, page_image)
        if page_image.endswith(".png"): # Check if the file is a pdf
            #for page_number, page_image in enumerate(pages, start=1):
            pdf_name = os.path.splitext(pdf_images)[0]
            print(f"Processing page {page_number} of {pdf_name}")

            # Convert PIL image to OpenCV image
            
            image = cv.imread(image_file)
            # Crop header and footnote
            #cropped_image = crop_image(image)

            # Remove images from the page
            #text_image = remove_images(cropped_image)
            #print(f"Images removed from page {page_number}")

            #thick_font_img = thick_font(cropped_image)

            
            image_path = os.path.join(pdf_images, f"{page_number}.png") # path of the image
            cv.imwrite(image_path, image)

            # Perform OCR on the page image
            text = pytesseract.image_to_string(image,lang = 'enga+fil', config=my_config)
            print(f"OCR performed on page {page_number}")

            with open(text_file_path, 'a', encoding='utf-8') as f: # Append extracted text to the file
                f.write(f"\n{text}\n")
            print(f"Appended text of page {page_number} to {text_file_path}")

    print(f"Completed text extraction from: {pdf_images}")



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

@st.cache_data
def extract_image(extraction_dir, image_dir, uploaded_file):
    if uploaded_file is not None: 
        # Save the pdfs
        for uploaded_file in uploaded_file:
            pdf_path = os.path.join(extraction_dir, uploaded_file.name)

            # Save the file
            with open(pdf_path, "wb") as f:
                f.write(uploaded_file.getbuffer())

        # Convert pdfs to images
        for file_name in os.listdir(extraction_dir): # iterate for each file in the directory
            if file_name.endswith(".pdf"): # Check if the file is a pdf
                
                pdf_path = os.path.join(extraction_dir, file_name) # Specify path to the PDF file

                # Create directory for output image file specific to the pdf
                pdf_image_dir = os.path.join(image_dir, os.path.splitext(file_name)[0]) # directory containning the images of the pdf
                if not os.path.exists(pdf_image_dir):# Ensure the extraction directory exists
                    os.makedirs(pdf_image_dir)

                #print(f"Starting image convertion from: {pdf_path}")
                pages = convert_from_path(pdf_path) # Convert PDF pages to images
                #print(f"Converted {len(pages)} pages to images.")

                # Iterate through each page image and save
                for page_number, page_image in enumerate(pages, start=1):
                    try:
                        image_path = os.path.join(pdf_image_dir, f"{page_number}.png") # path of the image
                        page_image.save(image_path)
                    except Exception as e:
                        return st.error(f"Error saving file: {e}")
    else:
        st.write("Please upload a pdf file to proceed.")

#@st.experimental_dialog("Provide your MySQL credentials.", width="small")
#def get_credentials():
    # Ask user for MySQL host address, user name, and password
                    
#    host = st.text_input("Enter host (default: 127.0.0.1): ")
#    if host == "":# Set host to 127.0.0.1 if blank
#        host = "127.0.0.1"
    
#    user = st.text_input("Enter user (default: root): ")
#    if user == "":# Set user to root if blank
#        user = "root"
    
#    password = st.text_input("Enter password: ", type = "password")

    #if "host" not in st.session_state:
    #    st.session_state.host = input("Enter host (default: 127.0.0.1): ")
    #    if st.session_state.host == "":# Set host to 127.0.0.1 if blank
    #        st.session_state.host = "127.0.0.1"
    #if "user" not in st.session_state:
    #    st.session_state.user = input("Enter user (default: root): ")
    #    if st.session_state.user == "":# Set user to root if blank
    #        st.session_state.user = "root"
    #if "password" not in st.session_state:
    #    st.session_state.password = input("Enter password: ")

#    return

def extract():
    st.session_state.extract = True

def upload():
    st.session_state.upload = True

# MAIN----------------

def main():

    st.set_page_config(page_title="Tesseract OCR Extractor", layout="wide")
    
    if 'extract' not in st.session_state:
        st.session_state.extract = False
    
    if 'upload' not in st.session_state:
        st.session_state.upload = False
    
    if 'extract_done' not in st.session_state:
        st.session_state.extract_done = False
    
    if 'upload_done' not in st.session_state:
        st.session_state.upload_done = False

    if 'uploaded_file' not in st.session_state:
        st.session_state.uploaded_file = None

    #Checking session states
    print("Beginning of Session:")
    for item in st.session_state.items():        
        print(f"{item}")

    # Create diectory for the uploaded files
    extraction_dir = make_dir(os.getcwd(), "uploaded_pdfs")

    # Create new directory for the output files
    text_dir = make_dir(os.getcwd(), "output_text")

    # Create directory for output image file
    image_dir = make_dir(os.getcwd(), "output_image")

    # Create directory for output image file
    preprocessed_dir = make_dir(os.getcwd(), "preprocessed_image")

    st.markdown("<h1 style='text-align: center;'>Tesseract Extractor</h1>", unsafe_allow_html=True)
    st.markdown("<p style='text-align: center;'>Extract PDFs and add them directly to the database.</p>", unsafe_allow_html=True)
    st.write("")

    upload_con = st.container()
    image_view, text_view = st.columns(2)


    with upload_con:
        st.write("Extract PDFs:")

        st.session_state.uploaded_file = st.file_uploader("Choose a file", type = "pdf", accept_multiple_files = True)
        st.success(f"{len(st.session_state.uploaded_file)} file(s) uploaded")

        if not st.session_state.uploaded_file:
            remove_contents(extraction_dir)
            remove_contents(text_dir)
            remove_contents(image_dir)
            remove_contents(preprocessed_dir)
            extract_image.clear()
            st.session_state.extract_done = False
            st.session_state.upload_done = False
            st.session_state.extract = False
            st.session_state.upload = False


        #Checking Session States
        print("Before Image Extraction:")
        for item in st.session_state.items():
            print(f"{item}")

        extract_image(extraction_dir, image_dir, st.session_state.uploaded_file)

        
    with image_view:

        st.write("View pdfs:")

        #Checking Session States
        print("Before Extraction:")
        for item in st.session_state.items():
            print(f"{item}")

        
        b_col, m_col = st.columns([0.2, 0.8])
        
        with b_col:
            if st.button("Extract Files", on_click = extract) or st.session_state.extract == True:
                with m_col:
                    m_con = st.container(height = 75)
                if st.session_state.extract_done == False:
                    for file_name in os.listdir(image_dir): # iterate for each file in the directory
                        document_pages = os.path.join(image_dir, file_name) # path being examined (most likely the path with pdf images)
                        if os.path.isdir(document_pages): # if document_pages is a dir
                            with m_con:
                                st.success(f"Processing file: {file_name}")

                            text_file_name = os.path.splitext(file_name)[0] + ".txt" # Specify output file name
                            text_file_path = os.path.join(text_dir, text_file_name) # Creates file path

                            try: # Creates a new file
                                with open(text_file_path, 'x', encoding='utf-8') as f:
                                    f.close()
                            except FileExistsError: # If file already exists, write over existing file rendering its contents null
                                with open(text_file_path, 'w', encoding='utf-8') as f: 
                                    f.close()

                            # Extract text from the PDF
                            images_to_text(document_pages, text_file_path)
                            
                            with m_con:
                                st.success(f"Saved as {text_file_name} at {text_file_path}")
                    st.session_state.extract_done = True

            if st.session_state.extract_done == True:
                with m_con:
                        st.success("Extraction Complete")

                print("After Extraction:")
                for item in st.session_state.items():
                    print(f"{item}")

        # List all subdirectories in the parent directory
        if os.path.exists(image_dir):
            pdf_images = [dir for dir in os.listdir(image_dir) if os.path.isdir(os.path.join(image_dir, dir))]
        else:
            print(f"The directory {image_dir} does not exist or is inaccessible.")
            pdf_images = []

        selected_pdf = st.selectbox("Select a PDF:", pdf_images)

        if selected_pdf:
            pdf_images_dir = os.path.join(image_dir, selected_pdf)
            image_files = [os.path.splitext(file)[0] for file in os.listdir(pdf_images_dir) if file.endswith('.png')]

            if image_files:
                image_files_sorted = sorted(image_files, key = int)
                selected_image = st.selectbox("Select page", image_files_sorted)
                
                # Display the selected image
                if selected_image:
                    selected_image = f"{selected_image}.png"

                    image_path = os.path.join(pdf_images_dir, selected_image)
                    st.image(image_path, caption=selected_image, use_column_width=True)
            else:
                st.warning(f"No image files found in the directory: {pdf_images}")
        
        

    with text_view:
        st.write("View Text:")

        b_col, m_col = st.columns([0.2, 0.8])
        

        with b_col:
            if st.button("Upload Files", on_click = upload) or st.session_state.upload == True:
                with m_col:
                    m_con = st.container(height = 75)
                if st.session_state.upload_done == False:
                    
                    #host, user, password = get_credentials()

                    host = input("Enter host (default: 127.0.0.1): ")
                    if host == "":# Set host to 127.0.0.1 if blank
                        host = "127.0.0.1"
                    
                    user = input("Enter user (default: root): ")
                    if user == "":# Set user to root if blank
                        user = "root"
                    
                    password = input("Enter password: ")

                    cursor, conn = connect_SQL(host, user, password)

                    for file_name in os.listdir(text_dir): # iterate for each file in the directory
                        if file_name.endswith(".txt"):

                            file_path = os.path.join(text_dir, file_name)

                            insert_paper(file_path, file_name, cursor, conn)
                            
                            with m_con:
                                st.success(f"{file_name} uploaded")
                
                    st.session_state.upload_done = True
                
                #if st.session_state.upload_done == True:
                #    remove_contents(text_dir)
                #    remove_contents(extraction_dir)
                #    remove_contents(image_dir)

        if st.session_state.extract_done == True:
            # List all text files in the directory
            text_files = [file for file in os.listdir(text_dir) if file.endswith('.txt')]

            # Select a file from the dropdown
            selected_file = st.selectbox("Select a text file", text_files)

            if selected_file:
                # Read the selected file
                file_path = os.path.join(text_dir, selected_file)
                with open(file_path, "r", encoding="utf-8") as file:
                    file_content = file.read()
                
                # Display the file content in a text area
                st.text_area("File Content", file_content, height=500)

if __name__ == "__main__":
    main()