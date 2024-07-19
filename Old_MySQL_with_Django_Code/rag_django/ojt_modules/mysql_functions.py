import socket

import mysql.connector
from mysql.connector import errorcode

import environ

env = environ.Env()
environ.Env.read_env()

# Size (characters) of text chunks and their overlaps
CHUNK_SIZE = 1500
OVERLAP_SIZE = 500

def connect_to_mysql(host, user, password):
    conn = mysql.connector.connect(
            host=host,
            user=user,
            password=password
        )
    cursor = conn.cursor()
    print("Connected to MySQL server.")

    return conn, cursor


def setup_mysql_db():
    
    dockerized = env.bool('DOCKERIZED')
    print(f'Dockerized: {dockerized}')
    
    # host, user, password = get_mysql_credentials()
    
    if not dockerized:
        host = env('LOCAL_DBHOST')
        user = "root"
        password = env('LOCAL_DBPASS')
    else:
        ip_address = socket.gethostbyname("db")
        print(f"Host IP: {ip_address}")
        host = ip_address
        user = env('DOCKER_DBPASS')
        password = env('DOCKER_DBPASS')
        
    # Connect to MySQL server
    try:
        conn, cursor = connect_to_mysql(host, user, password)
        
        # Display existing databases
        # show_databases(cursor)

        # Ask user for a database name
        # db_name = input("Enter the database name: ")
        db_name = "technical"
        
        # Check if the database exists
        # if database_exists(cursor, db_name):
        #     print(f"Database '{db_name}' exists.")
        # else:
        #     # Create the database if it doesn't exist
        #     try:
        #         cursor.execute(f"CREATE DATABASE {db_name}")
        #         print(f"Database '{db_name}' created.")
        #     except mysql.connector.Error as err:
        #         print(f"Failed creating database: {err}")
        #         exit(1)

        # Connect to the specified database
        conn.database = db_name
        print(f"Connected to the database '{db_name}'.")

        # create_mysql_db_tables(cursor, db_name)

    except mysql.connector.Error as err:
        if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
            print("Something is wrong with your user name or password")
        elif err.errno == errorcode.ER_BAD_DB_ERROR:
            print("Database does not exist")
        else:
            print(err)
            conn.rollback()
    
    return conn, cursor

def upload_to_mysql_db(conn, cursor, file_name, text):
    # Insert paper record into Papers table
    cursor.execute("""
        INSERT INTO Papers (title)
        VALUES (%s)
    """, (file_name,))
    paper_id = cursor.lastrowid
    conn.commit()

    chunk_size = CHUNK_SIZE
    overlap_size = OVERLAP_SIZE
    # TODO: the first and last characters of each chunk should overlap with
    # the previous and next chunks, respectively
    # chunks = [text[i:i + chunk_size] for i in range(0, len(text), chunk_size)]
    chunks = [text[i:i + chunk_size] for i in range(0, len(text) - overlap_size, chunk_size - overlap_size)]

    chunk_order = 1
    for chunk in chunks:
        cursor.execute("""
            INSERT INTO Chunks (paper_id, chunk_order, chunk_text)
            VALUES (%s, %s, %s)
        """, (paper_id, chunk_order, chunk))
        chunk_order += 1

    conn.commit()