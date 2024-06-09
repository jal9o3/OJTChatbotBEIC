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

def main():
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

    print("Extraction Complete")

if __name__ == "__main__":
    main()