# use official python runtime as a parent image
FROM python:3.10
# for rust and cargo
# FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y curl build-essential
# RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# set environment variables
ENV PATH="/root/.cargo/bin:${PATH}"

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# set working directory in container to /app
WORKDIR /app

# add current directory (local machine) to container
ADD . /app/

# install packages specified in requirements.txt
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# expose the port server is running on
EXPOSE 8000

# start server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]