import pytesseract
from pdf2image import convert_from_path
import os

def pdf_to_text(pdf_path, file_path):
    # Convert PDF pages to images
    pages = convert_from_path(pdf_path)

    # Initialize an empty string to store extracted text
    #extracted_text = ""

    # Iterate through each page image and perform OCR
    for page_number, page_image in enumerate(pages, start=1):
        # Perform OCR on the page image
        text = pytesseract.image_to_string(page_image)

        with open(file_path, 'a') as f: #Append extracted text to the file
            f.write(f"--- Page {page_number} ---\n{text}\n\n")

        # Append extracted text with page number
        #extracted_text += f"--- Page {page_number} ---\n{text}\n\n"

    #return extracted_text

#def save_text_to_file(text, file_path):
#    with open(file_path, 'w', encoding='utf-8') as f:
#        f.write(text)
#    print(f"Extracted text saved to '{file_path}'")

if __name__ == "__main__":
    #pdf_path = input("Input PDF file path: ") # Specify path to the PDF file
    pdf_path = 'E:\School\MidYear2024\Pre-OJT\Sample-PDF_Kant.pdf'

    #output_file_name = input("Output text file name: ") #Specify output file name
    output_file_name = "Extracted.txt"

    #directory_path = input("Where to save the file: ") #Specify output file directory
    directory_path = 'E:\School\MidYear2024\Python'

    file_path = os.path.join(directory_path, output_file_name) #Creates file path

    try:
        with open(file_path, 'x', encoding='utf-8')as f: #Creates the file
            f.close()
    except FileExistsError:
        with open(file_path, 'w', encoding='utf-8')as f: #Creates the file
            f.close()

    # Extract text from the PDF
    #extracted_text = pdf_to_text(pdf_path, file_path)
    pdf_to_text(pdf_path, file_path)

    # Print the extracted text
    #print("Extracted Text:")
    #print(extracted_text)

    print("Saved as " + output_file_name + " at " + file_path)

    # Save the extracted text to a text file
    #save_text_to_file(extracted_text, file_path)

    #Algorithm
    #Input PDF path
    #Input save path
    #Extract the text from the PDF

    #Save the extracted text to a file    

    
