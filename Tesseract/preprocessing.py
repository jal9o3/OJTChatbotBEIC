from pdf2image import convert_from_path

import cv2 as cv
import numpy as np

import string
import re
import nltk

#       Preprocessing Functions---------------------

# Remove Images
def remove_images(image):
    # Threshold value for binarizing
    threshold_value = 210
    
    # Convert the image to grayscale
    gray_image = cv.cvtColor(image, cv.COLOR_BGR2GRAY)

    # Perform thresholding to convert grayscale image to binary (black and white)
    _, binarized = cv.threshold(gray_image, threshold_value, 255, cv.THRESH_BINARY_INV)

    return binarized

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

    image = cv.bitwise_not(image)
    kernel = np.ones((2,2),np.uint8)
    image = cv.erode(image, kernel, iterations=1)
    image = cv.bitwise_not(image)
    return image

#Remove Borders automatically
def remove_borders(image):
    contours, heiarchy = cv.findContours(image, cv.RETR_EXTERNAL, cv.CHAIN_APPROX_SIMPLE)
    cntsSorted = sorted(contours, key=lambda x:cv.contourArea(x))
    cnt = cntsSorted[-1]
    x, y, w, h = cv.boundingRect(cnt)
    crop = image[y:y+h, x:x+w]
    
    return (crop)

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

# Add Borders
def add_borders(image):
    color = [255, 255, 255]
    top, bottom, left, right = [150]*4

    image_with_border = cv.copyMakeBorder(image, top, bottom, left, right, cv.BORDER_CONSTANT, value=color)

    return image_with_border

#           Functions for Deskewing---------
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


#       Text Preprocessing

def remove_non_printable_chars(text):
    return ''.join(character for character in text if character in string.printable)

def remove_unaccepted_chars(text): 
    
    # Remove unwanted symbols (keep letters, digits, punctuations, and spaces)

    text = remove_non_printable_chars(text)
    
    text = re.sub(r'[^a-zA-Z0-9\s \' ! @ # $ % & ( ) - _ = + { } ; .]', '', text)
    
    # Tokenize
    tokens = nltk.word_tokenize(text)
    
    # Join tokens back into a single string
    preprocessed_text = ' '.join(tokens)
    
    return preprocessed_text

def line_text(text): 
    
    # Remove unwanted symbols (keep letters, digits, punctuations, and spaces)
    text = re.sub(r'[^a-zA-Z0-9\s ! @ # $ % & * ( ) - _ = + { } ; : ? .]', '', text)
    
    # Tokenize
    tokens = nltk.word_tokenize(text)
    
    # Join tokens back into a single string
    preprocessed_text = ' '.join(tokens)
    
    return preprocessed_text

def body_text(text):
    # Split the text into lines
    lines = text.splitlines()

    # Preprocess each line while preserving formatting
    preprocessed_lines = [line_text(line) for line in lines]

    # Join preprocessed lines back into a single string with newline characters
    preprocessed_text = '\n'.join(preprocessed_lines)

    return preprocessed_text