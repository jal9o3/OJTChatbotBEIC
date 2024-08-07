import psycopg2

import constants

from text_management import get_text, get_chunks
from database_management import upload_to_pgdb, connect_to_or_create_pgdb
from database_management import create_table_if_not_exists

def create_connection(db_name = constants.PGDB_NAME,
                      db_user = constants.PGDB_USER,
                      db_password = constants.PGDB_PASS, 
                      db_host = constants.PGDB_HOST,
                      db_port = constants.PGDB_PORT
                      ):
    connection = None
    
    connection = psycopg2.connect(
        database=db_name,
        user=db_user,
        password=db_password,
        host=db_host,
        port=db_port,
    )

    return connection

def format_upload_doc(filename, title, authors, tags, 
                      db_name = constants.PGDB_NAME,
                      db_user = constants.PGDB_USER,
                      db_password = constants.PGDB_PASS, 
                      db_host = constants.PGDB_HOST,
                      db_port = constants.PGDB_PORT
                      ):
    
    # Set up a test database connection
    connect_to_or_create_pgdb(db_name = db_name,
                                db_user = db_user,
                                db_password = db_password, 
                                db_host = db_host,
                                db_port = db_port)

    conn = create_connection(db_name = db_name,
                                db_user = db_user,
                                db_password = db_password, 
                                db_host = db_host,
                                db_port = db_port)

    cur = conn.cursor()
    
    # Create test tables
    create_table_if_not_exists("paper_titles", db_name = db_name,
                                                db_user = db_user,
                                                db_password = db_password, 
                                                db_host = db_host,
                                                db_port = db_port)
    create_table_if_not_exists("chunks", db_name = db_name,
                                                db_user = db_user,
                                                db_password = db_password, 
                                                db_host = db_host,
                                                db_port = db_port)

    # Commit changes to the database
    conn.commit()

    # Upload War of the Worlds
    # Get the .txt file
    doc_text = get_text(filename)
    # Split chunks by double newline (\n\n, or "paragraph")
    doc_chunks = get_chunks(doc_text)
    # Create a dictionary to attach metadata to the chunks of text
    doc_dic = {
        'metadata': {
            'paper_title': title,
            'author_names': authors,
            # Dummy original PDF filename
            'filename': filename,
            'tags': tags
        },
        'chunks': doc_chunks

    }
    # Upload the contents of the dictionary to the Postgres database
    upload_to_pgdb(doc_dic, conn, db_name = db_name,
                                    db_user = db_user,
                                    db_password = db_password, 
                                    db_host = db_host,
                                    db_port = db_port)

def main():

    format_upload_doc(
        filename=r"C:\Users\lenovo\Desktop\OJTChatbotBEIC"
            r"\War of the Worlds.txt",
        title='War of the Worlds',
        authors=['H.G. Wells'],
        tags=['Science Fiction', '1800s', 'Alien']
    )

    format_upload_doc(
        filename=r"C:\Users\lenovo\Desktop\OJTChatbotBEIC\test_papers"
                    r"\Automated_Info_Retrieval.txt",
        title='Automated Information Retrieval',
        authors=['N.M Hernandez', 'P.J. Lucafias', 'J.C. Graciosa'],
        tags=['Machine Learning', 'Iraya', 'Documents']
    )

    format_upload_doc(
        filename=r"C:\Users\lenovo\Desktop\OJTChatbotBEIC\test_papers"
                    r"\Bonaparte_Paper.txt",
        title='A Case Study of Understanding the Bonaparte Basin',
        authors=[
                'A.N.Sazali', 'N.M. Hernandez', 
                'F. Baillard', 'K.G. Maver'
                ],
        tags=[
                'Case Study', 
                'Machine Learning', 
                'Iraya', 
                'Documents', 
                'Geology'
            ]
    )

if __name__ == "__main__":
    main()