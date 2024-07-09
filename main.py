import psycopg2

from constants import PGDB_PASS

from text_management import get_text, get_chunks
from database_management import upload_to_pgdb, connect_to_or_create_pgdb
from database_management import create_table_if_not_exists

def format_upload_doc(filename, title, authors, tags):
    # Set up a test database connection
    connect_to_or_create_pgdb("knowledge_base")
    conn = psycopg2.connect(
        dbname='knowledge_base',
        user='postgres',
        password=PGDB_PASS,
        host='localhost',
        port=5432
    )
    cur = conn.cursor()
    
    # Create test tables
    create_table_if_not_exists("paper_titles", "knowledge_base")
    create_table_if_not_exists("chunks", "knowledge_base")

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
    upload_to_pgdb(doc_dic, conn)

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