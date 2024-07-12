import pytesseract
from pdf2image import convert_from_path
import os
import cv2
import numpy as np
import pandas
from io import BytesIO
from PIL import Image
import time

import mysql.connector
from mysql.connector import errorcode

import streamlit as st
import fitz  # PyMuPDF

if text_content_check(file_path):
        tag_options = ["Machine Learning", "Artificial Intelligence", "Statistical Analysis", "Global Warming"]

        with open(file_path, 'r', encoding='utf-8') as f:
            file_content = [f.readline() for i in range(3)]

        word_to_ignore = ['Title:', 'Author:', 'Tags:']

        # Process each line and ignore the specific word
        for i in range(len(file_content)):
            filtered_line = ' '.join([word for word in file_content[i].split() if word not in word_to_ignore])
            file_content[i] = filtered_line

        title = st.text_input("Title: ", value = file_content[0], placeholder = "Input Title of the paper")    
        author = st.text_input("Author: ", value = file_content[1], placeholder = "Input Author of the paper") 
        tags = st.multiselect("Tags: ", options = tag_options, placeholder = "Select tags of the paper")

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
image_files = [os.path.splitext(file)[0] for file in os.listdir(pdf_images_dir) if file.endswith('.png')]
    image_files_sorted = sorted(image_files, key = int)

    # Iterate through each page image and perform OCR
    for page_number, page_image in enumerate(image_files_sorted, start = 1):