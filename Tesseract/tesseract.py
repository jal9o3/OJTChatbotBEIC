import pytesseract
from pdf2image import convert_from_path
import os

def pdf_to_text(pdf_path, file_path):
    # Convert PDF pages to images
    pages = convert_from_path(pdf_path)

    # Iterate through each page image and perform OCR
    for page_number, page_image in enumerate(pages, start=1):
        # Perform OCR on the page image
        text = pytesseract.image_to_string(page_image)

        with open(file_path, 'a') as f: #Append extracted text to the file
            f.write(f"--- Page {page_number} ---\n{text}\n\n")

if __name__ == "__main__":
    pdf_path = input("Input PDF file path: ") # Specify path to the PDF file

    output_file_name = input("Output text file name: ") #Specify output file name

    directory_path = input("Where to save the file: ") #Specify output file directory

    file_path = os.path.join(directory_path, output_file_name) #Creates file path

    try:
        with open(file_path, 'x', encoding='utf-8')as f: #Creates the file
            f.close()
    except FileExistsError:
        with open(file_path, 'w', encoding='utf-8')as f: #Creates the file
            f.close()

    # Extract text from the PDF
    pdf_to_text(pdf_path, file_path)

    print("Saved as " + output_file_name + " at " + file_path)\  

    
