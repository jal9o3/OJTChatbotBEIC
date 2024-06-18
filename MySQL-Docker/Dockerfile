# Use the latest MySQL image as the base
FROM mysql:latest

# Set environment variables for MySQL
ENV MYSQL_ROOT_PASSWORD=your_root_password
ENV MYSQL_DATABASE=your_database_name
ENV MYSQL_USER=your_user
ENV MYSQL_PASSWORD=your_password

# Create a directory for your sql dump
RUN mkdir /docker-entrypoint-initdb.d

# Copy your SQL dump into the container
COPY your_sql_dump.sql /docker-entrypoint-initdb.d/

# Expose port 3306 for MySQL
EXPOSE 3306