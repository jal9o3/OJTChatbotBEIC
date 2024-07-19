FROM python:3.12.3 

#Install system Dependencies
RUN apt-get update && apt-get install -y\
    tesseract-ocr\
    tesseract-ocr-eng\
    tesseract-ocr-fil\
    poppler-utils

#Working directory in container
WORKDIR /program

COPY . /program

#Install Python dependency
RUN pip install --no-cache-dir -r requirements.txt

CMD ["python", "tesseract.py"]