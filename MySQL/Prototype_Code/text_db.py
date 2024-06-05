import mysql.connector
import os

print(os.getcwd())

def main():
    text_db = mysql.connector.connect(
        host="127.0.0.1",
        user="root",
        password="notmypassword"
    )

    # print(text_db)

    mycursor = text_db.cursor()
    # mycursor.execute("CREATE DATABASE text_database")
    # 
    # mycursor.execute("CREATE TABLE texts (id INT AUTO_INCREMENT PRIMARY KEY, context VARCHAR(255))")
    # mycursor.execute("SHOW TABLES")
    # Execute the delete query
    # mycursor.execute("TRUNCATE TABLE texts")

    # # Commit the changes
    # text_db.commit()

    # # Read the entire file content
    # with open('./Tesseract/Extracted.txt', 'r') as file:
    #     file_content = file.read()
    
    # # Split the content into smaller strings (up to 255 characters)
    # max_length = 255
    # split_content = [file_content[i:i + max_length] for i in range(0, len(file_content), max_length)]

    # # Insert each smaller string into the database
    # query = "INSERT INTO texts (context) VALUES (%s)"
    # for content in split_content:
    #     mycursor.execute(query, (content,))

    # # Commit changes and close the connection
    # text_db.commit()

    # for x in mycursor:
    #     print(x)

    # # Execute a SELECT query
    # query = "SELECT * FROM texts"
    # mycursor.execute(query)

    # # Fetch all rows
    # rows = mycursor.fetchall()

    # # Print the results
    # for row in rows:
    #     print(row)  # You can format this output as needed

    # # Get a list of all tables in the database
    # mycursor.execute("SHOW TABLES")
    # tables = mycursor.fetchall()

    # # Drop each table
    # for table in tables:
    #     mycursor.execute(f"DROP TABLE {table[0]}")

    # # Commit the changes
    # text_db.commit()

    # print(f"All tables in the database have been dropped successfully.")

    # mycursor.execute("SHOW TABLES")
    # for x in mycursor:
    #     print(x)

    mycursor.execute("DROP DATABASE text_database")
    mycursor.execute("SHOW DATABASES")
    for x in mycursor:
        print(x)

if __name__ == "__main__":
    main()