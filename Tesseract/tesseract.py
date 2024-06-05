import pytesseract
from pdf2image import convert_from_path
import os
from PIL import Image

def remove_images(page_image):
    # Convert the image to grayscale
    gray_image = page_image.convert('L')

    # Perform thresholding to convert grayscale image to binary (black and white)
    binary_image = gray_image.point(lambda pixel: 255 if pixel > 200 else 0, '1')

    # Invert the binary image (so that text becomes white on black background)
    inverted_image = Image.eval(binary_image, lambda pixel: 255 - pixel)

    return inverted_image

def pdf_to_text(pdf_path, file_path):

    pages = convert_from_path(pdf_path) #Convert PDF pages to images

    #Iterate through each page image and perform OCR
    for page_number, page_image in enumerate(pages, start=1):
        width, height = page_image.size
        
        #crop header and footnote
        top_crop = int(0.05 * height)
        bottom_crop = int(0.95 * height)
        cropped_image = page_image.crop((0, top_crop, width, bottom_crop))
        
        # Remove images from the page
        text_image = remove_images(cropped_image)

        #Perform OCR on the page image
        text = pytesseract.image_to_string(text_image)

        with open(file_path, 'a') as f: #Append extracted text to the file
            f.write(f"\n{text}\n")

if __name__ == "__main__":

    pdf_path = input("Input PDF file path (with file extension): ") #Specify path to the PDF file

    output_file_name = input("Output text file name (with file extension): ") #Specify output file name

    directory_path = input("Where to save the file: ") #Specify output file directory

    file_path = os.path.join(directory_path, output_file_name) #Creates file path

    try: #Creates a new file
        with open(file_path, 'x', encoding='utf-8')as f:
            f.close()
    except FileExistsError: #If file already exist, write over existing file rendering its contents null
        with open(file_path, 'w', encoding='utf-8')as f:
            f.close()

    # Extract text from the PDF
    pdf_to_text(pdf_path, file_path)

    print("Saved as " + output_file_name + " at " + file_path)  