FROM python:3.12.3

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    python3-dev \
    cmake \
    wget \
    unzip \
    libgtk2.0-dev \
    pkg-config \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    tesseract-ocr \
    tesseract-ocr-eng \
    tesseract-ocr-fil \
    libtesseract-dev \
    poppler-utils \
    libgl1-mesa-glx \
    && rm -rf /var/lib/apt/lists/*

#Working directory in container
WORKDIR /Tesseract

COPY . .

#Install Python dependency
RUN pip install -r requirements.txt

CMD streamlit run tesseract.py --server.port 5678