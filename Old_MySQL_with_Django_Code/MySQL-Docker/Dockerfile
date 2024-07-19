# Use the latest MySQL image as the base
FROM mysql:latest

# Set environment variables for MySQL
ENV MYSQL_DATABASE=technical
ENV MYSQL_ROOT_PASSWORD=root

# Create a directory for your sql dump
# RUN mkdir /docker-entrypoint-initdb.d

# Copy your SQL dump into the container
COPY technical_db.sql /docker-entrypoint-initdb.d/

# Expose port 3306 for MySQL
EXPOSE 3306