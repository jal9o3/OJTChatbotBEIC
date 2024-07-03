import pytesseract
from pdf2image import convert_from_path
import os
import cv2 as cv
import numpy as np
import pandas as pd
from io import BytesIO
from PIL import Image
import time

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


#       Main Database Function

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



# EXTRACTION FUNCTIONS------------------

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

#       Main Preprocessing Function-------------

def preprocess(image):

    # Crop header and footnote
    image = crop_image(image)

    # Remove images from the page
    image = remove_images(image)
    
    image = thick_font(image)

    

    return image

#       Main Extraction Functions-----------------

def images_to_text(pdf_images, processed_images, text_path):
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
            
            image = cv.imread(image_file)
            
            

            image_path = os.path.join(pdf_images, f"{page_number}.png") # path of the image
            cv.imwrite(image_path, image)

            processed_image = preprocess(image)
            #print(f"Preprocessed Page {page_number}")

            processed_path = os.path.join(processed_images, f"{page_number}.png") # path of the image
            cv.imwrite(processed_path, processed_image)

            # Perform OCR on the page image
            text = pytesseract.image_to_string(processed_image,lang = 'enga+fil+equ', config=my_config)
            print(f"OCR performed on page {page_number}")

            with open(text_path, 'a', encoding='utf-8') as f: # Append extracted text to the file
                f.write(f"\n{text}\n")
            print(f"Appended text of page {page_number} to {text_path}")

    print(f"Completed text extraction from: {pdf_images}")

# Main--------------------

#       Other Functions of Main-------------------

def set_session_states(action = "set"):
    # Database session_states
    if action == "set":
        if "db_name" not in st.session_state:
            st.session_state.db_name = ""

        if "host" not in st.session_state:
            st.session_state.host = ""

        if "user" not in st.session_state:
            st.session_state.user = ""
            
        if "password" not in st.session_state:
            st.session_state.password = ""
        
        # Button session_states

        if 'extract' not in st.session_state:
            st.session_state.extract = False
        
        if 'upload' not in st.session_state:
            st.session_state.upload = False
        
        # Operation session_states

        if 'extract_done' not in st.session_state:
            st.session_state.extract_done = False
        
        if 'upload_done' not in st.session_state:
            st.session_state.upload_done = False

        # File Upload session_states

        if 'uploaded_file' not in st.session_state:
            st.session_state.uploaded_file = None
    elif action == "reset":
    # Reset session states
        st.session_state.extract_done = False
        st.session_state.upload_done = False
        st.session_state.extract = False
        st.session_state.upload = False
        st.session_state.db_name = ""
        st.session_state.host = ""
        st.session_state.user = ""
        st.session_state.password = ""
        st.session_state.uploaded_file = None

def show_message(message, duration=2):
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

@st.cache_data
def extract_image(extraction_dir, image_dir, file):
    if file is not None: 
        # Save the pdfs
        for file in file:
            file_path = os.path.join(extraction_dir, file.name)

            # Save the file
            with open(file_path, "wb") as f:
                f.write(file.getbuffer())

        # Convert pdfs to images
        for file_name in os.listdir(extraction_dir): # iterate for each file in the directory
            if file_name.endswith(".pdf"): # Check if the file is a pdf
                
                file_path = os.path.join(extraction_dir, file_name) # Specify path to the PDF file

                # Create directory for output image file specific to the pdf
                file_image_dir = os.path.join(image_dir, os.path.splitext(file_name)[0]) # directory containning the images of the pdf
                if not os.path.exists(file_image_dir):# Ensure the extraction directory exists
                    os.makedirs(file_image_dir)

                #print(f"Starting image convertion from: {pdf_path}")
                pages = convert_from_path(file_path) # Convert PDF pages to images
                #print(f"Converted {len(pages)} pages to images.")

                # Iterate through each page image and save
                for page_number, page_image in enumerate(pages, start=1):
                    try:
                        image_path = os.path.join(file_image_dir, f"{page_number}.png") # path of the image
                        page_image.save(image_path)
                    except Exception as e:
                        return st.error(f"Error saving file: {e}")
    else:
        st.write("Please upload a pdf file to proceed.")

@st.experimental_dialog("Provide your MySQL credentials.", width="large")
def get_credentials():
    # Ask user for MySQL host address, user name, and password
                    
    #st.session_state.host = st.text_input("Enter host (default: 127.0.0.1): ")
    #if host == "":# Set host to 127.0.0.1 if blank
    #    host = "127.0.0.1"
    
    #st.session_state.user = st.text_input("Enter user (default: root): ")
    #if user == "":# Set user to root if blank
    #    user = "root"
    
    #st.session_state.password = st.text_input("Enter password: ", type = "password")



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

def extract():
    st.session_state.extract = True

def upload():
    st.session_state.upload = True



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

#       MAIN Function----------------

def main():

    set_session_states("set")

    #Checking session states
    print("Beginning of Session:")
    for item in st.session_state.items():
        print(f"{item}")

    script_directory = os.path.dirname(os.path.abspath(__file__))

    # Create diectory for the uploaded files
    extraction_dir = make_dir(script_directory, "uploaded_pdfs")

    # Create metadata directory
    metadata_dir = make_dir(script_directory, "metadata")

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

    upload_con = st.container()
    preprocess_col, upload_col = st.columns(2)
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
            set_session_states("reset")


        #Checking Session States
        print("Before Image Extraction:")
        for item in st.session_state.items():
            print(f"{item}")
        
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
                
        # extract images
        extract_image(extraction_dir, image_dir, st.session_state.uploaded_file)

        
        
    with preprocess_col:

        st.write("View pdfs:")

        #Checking Session States
        print("Before Extraction:")
        for item in st.session_state.items():
            print(f"{item}")

        
        button_col, message_col = st.columns([0.2, 0.8])
        
        with button_col:
            if st.button("Extract Files", on_click = extract) or st.session_state.extract == True:
                with message_col:
                    message_con = st.container(height = 75)
                
                with message_con:
                    if not st.session_state.uploaded_file:
                        st.error("Please Upload A File")

                if st.session_state.extract_done == False and st.session_state.uploaded_file:
                    for file_name in os.listdir(image_dir): # iterate for each file in the directory
                        document_pages = os.path.join(image_dir, file_name) # path being examined (the path with pdf images)
                        
                        processed_image_dir = os.path.join(preprocessed_dir, os.path.splitext(file_name)[0]) # directory containing the preprocessed images of the pdf
                        if not os.path.exists(processed_image_dir):# Ensure the directory exists
                            os.makedirs(processed_image_dir)
                        
                        if os.path.isdir(document_pages): # if document_pages is a dir
                            with message_con:
                                st.success(f"Processing file: {file_name}")

                            text_file_name = os.path.splitext(file_name)[0] + ".txt" # Specify output file name
                            text_file_path = os.path.join(text_dir, text_file_name) # Creates file path

                            try: # Creates a new file
                                with open(text_file_path, 'x', encoding='utf-8') as f:
                                    f.close()
                            except FileExistsError: # If file already exists, write over
                                with open(text_file_path, 'w', encoding='utf-8') as f: 
                                    f.close()

                            # Extract text from the PDF
                            images_to_text(document_pages, processed_image_dir, text_file_path)
                            
                            with message_con:
                                st.success(f"Saved as {text_file_name} at {text_file_path}")
                    st.session_state.extract_done = True

            if st.session_state.extract_done == True:
                with message_con:
                        st.success("Extraction Complete")

                print("After Extraction:")
                for item in st.session_state.items():
                    print(f"{item}")

    
        # Preview PDFs    
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
                    with image_view:
                        st.write("Page View")
                        st.image(image_path, caption=selected_image, use_column_width=True)
            else:
                st.warning(f"No image files found in the directory: {pdf_images}")
        
        

    with upload_col:
        st.write("View Text:")

        button_col, message_col = st.columns([0.2, 0.8])
        meta_prompt = st.container()
        
        with button_col:
            if st.button("Upload Files", on_click = upload) or st.session_state.upload == True:
                with message_col:
                    message_con = st.container(height = 75)
                if st.session_state.upload_done == False:
                    
                    get_credentials()

                    conn, cursor, _ = connect_SQL(st.session_state.host, st.session_state.user, st.session_state.password)
                    
                    connect_db(conn, cursor, st.session_state.db_name)

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
                
                #if st.session_state.upload_done == True:
                #    remove_contents(text_dir)
                #    remove_contents(extraction_dir)
                #    remove_contents(image_dir)

    
         # Preview text files

            # List all text files in the directory
            
            if selected_pdf:
                # Input metadata
                with meta_prompt:
                    meta_file = os.path.splitext(selected_pdf)[0] + "_metadata.txt"
                    meta_path = os.path.join(text_dir, selected_file)
                    metadata(meta_path)

                file_selected = os.path.splitext(selected_pdf)[0] + ".txt"
                for file in os.listdir(text_dir):
                    if file == file_selected:
                        selected_file = file
            
                file_path = os.path.join(text_dir, selected_file)

                
            
            if st.session_state.extract_done == True:

                # Read the selected file
                with open(file_path, "r", encoding="utf-8") as file:
                    file_content = file.read()
                
                with text_view:
                    # Display the file content in a text area
                    st.text_area("File Content", file_content, height = 700)
        
        

if __name__ == "__main__":
    main()