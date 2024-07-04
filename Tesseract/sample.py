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

def convert_pdf_to_images(pdf_path, output_folder):
    # Open the PDF file
    pdf_document = fitz.open(pdf_path)

    # Initialize CUDA GPU support for OpenCV
    cv2.cuda.setDevice(0)

    for page_num in range(len(pdf_document)):
        page = pdf_document.load_page(page_num)
        pix = page.get_pixmap()
        img = np.frombuffer(pix.samples, dtype=np.uint8).reshape(pix.h, pix.w, pix.n)
        
        # Handle grayscale images (n=1)
        if pix.n == 1:
            img = cv2.cvtColor(img, cv2.COLOR_GRAY2BGR)

        # Upload image to GPU
        gpu_image = cv2.cuda_GpuMat()
        gpu_image.upload(img)

        # Example GPU operation: convert to grayscale
        gpu_gray = cv2.cuda.cvtColor(gpu_image, cv2.COLOR_BGR2GRAY)

        # Download processed image back to host
        processed_image = gpu_gray.download()

        # Save the processed image
        output_path = f'{output_folder}/page_{page_num + 1}.png'
        cv2.imwrite(output_path, processed_image)
        print(f'Saved {output_path}')

sample_pdf = "E:\School\MidYear2024\Test\Ashmore_Reef_1_WCR_Basic_Interp_I00025257.pdf"
output_images = "E:\School\MidYear2024\Test\Output"
# Usage example
convert_pdf_to_images(sample_pdf, output_images)
