import mysql.connector

import environ

env = environ.Env()
environ.Env.read_env()

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
    
    # host, user, password = get_mysql_credentials()
    host = "127.0.0.1"
    user = "root"
    
    password = env('DATABASE_PASSWORD')
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