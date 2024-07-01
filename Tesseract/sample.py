import pytesseract
from pdf2image import convert_from_path
import os
import cv2 as cv
import numpy as np
import pandas
from io import BytesIO
from PIL import Image
import time

import mysql.connector
from mysql.connector import errorcode

import streamlit as st
import fitz  # PyMuPDF

def show_message(message, duration=2):
    message_html = f"""
    <div style="
        position: fixed;
        bottom: 20px;
        left: 50%;
        transform: translateX(-50%);
        background-color: #16394F;
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


@st.experimental_dialog("Provide your MySQL credentials.", width="small")
def get_credentials():
    # Ask user for MySQL host address, user name, and password
                    
    #st.session_state.host = st.text_input("Enter host (default: 127.0.0.1): ")
    #if host == "":# Set host to 127.0.0.1 if blank
    #    host = "127.0.0.1"
    
    #st.session_state.user = st.text_input("Enter user (default: root): ")
    #if user == "":# Set user to root if blank
    #    user = "root"
    
    #st.session_state.password = st.text_input("Enter password: ", type = "password")

    if "db_name" not in st.session_state:
        st.session_state.db_name = ""

    if "host" not in st.session_state:
        st.session_state.host = ""

    if "user" not in st.session_state:
        st.session_state.user = ""
        
    if "password" not in st.session_state:
        st.session_state.password = ""


    db_name = st.text_input("Connect to Database:", placeholder = "iraya_database")
    host = st.text_input("Enter host: ", placeholder = "default: 127.0.0.1")
    user = st.text_input("Enter user: ", placeholder = "root")
    password = st.text_input("Enter password: ")

    if st.button("Submit"):
        if host == "":# Set host to 127.0.0.1 if blank
            host = "127.0.0.1"
        
        if user == "":# Set user to root if blank
            user = "root"

        if db_name == "":# Set host to 127.0.0.1 if blank
            db_name = "iraya_database"
        
        _,_,p_check = connect_SQL(host, user, password)

        if p_check:
            st.session_state.host = ""

            st.session_state.user = ""

            st.session_state.db_name = ""
            
            st.session_state.db_name = ""
            
            st.success("Creds saved")
            st.rerun()
        else:
            st.error("something went wrong")
            st.rerun()

def main():
    if st.button("Creds"):get_credentials():
    st.write(f"{host, user, password, db_name}")


"""
#PDF Viewer
def main():
    st.title("PDF Viewer with GPU Acceleration")

    pdf_file = st.file_uploader("Upload a PDF file", type=["pdf"])

    if pdf_file is not None:
        with open("temp.pdf", "wb") as f:
            f.write(pdf_file.getbuffer())

        doc = fitz.open("temp.pdf")
        num_pages = len(doc)
        st.sidebar.title("Page Navigation")
        page_number = st.sidebar.number_input("Page Number", 1, num_pages, 1)

        page = doc.load_page(page_number - 1)
        pix = page.get_pixmap(matrix=fitz.Matrix(2, 2))
        img = Image.frombytes("RGB", [pix.width, pix.height], pix.samples)

        st.image(img, use_column_width=True)
"""

if __name__ == "__main__":
    main()

