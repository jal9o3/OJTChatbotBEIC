import psycopg2

from constants import PGDB_PASS

from text_management import get_text, get_chunks
from database_management import upload_to_pgdb, connect_to_or_create_pgdb
from database_management import create_table_if_not_exists

def main():
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
    wotw_text = get_text(
        r"C:\Users\lenovo\Desktop\OJTChatbotBEIC\War of the Worlds.txt"
        )
    # Split chunks by double newline (\n\n, or "paragraph")
    wotw_chunks = get_chunks(wotw_text)
    # Create a dictionary to attach metadata to the chunks of text
    wotw_doc = {
        'metadata': {
            'paper_title': 'War of the Worlds',
            'author_names': ['H.G. Wells'],
            # Dummy original PDF filename
            'filename': 'War of the Worlds.pdf',
            'tags': ['Science Fiction', '1800s']
        },
        'chunks': wotw_chunks

    }
    # Upload the contents of the dictionary to the Postgres database
    upload_to_pgdb(wotw_doc, conn)

    # Reconnect to the database (upload function closes connection for safety)
    conn = psycopg2.connect(
        dbname='knowledge_base',
        user='postgres',
        password=PGDB_PASS,
        host='localhost',
        port=5432
    )
    cur = conn.cursor()

    # Repeat the .txt upload procedure for a scientific paper
    auto_ret_text = get_text(
        r"C:\Users\lenovo\Desktop\OJTChatbotBEIC\test_papers"
        r"\Automated_Info_Retrieval.txt"
        )
    auto_ret_chunks = get_chunks(auto_ret_text)
    auto_ret_doc = {
        'metadata': {
            'paper_title': 'Automated Information Retrieval',
            'author_names': ['N.M Hernandez', 'P.J. Lucafias', 'J.C. Graciosa'],
            'filename': 'Automated_Info_Retrieval.pdf',
            'tags': ['Machine Learning', 'Iraya', 'Documents']
        },
        'chunks': auto_ret_chunks

    }
    upload_to_pgdb(auto_ret_doc, conn)

    # Reconnect to the database again 
    # (upload function closes connection for safety)
    conn = psycopg2.connect(
        dbname='knowledge_base',
        user='postgres',
        password=PGDB_PASS,
        host='localhost',
        port=5432
    )
    cur = conn.cursor()

    # Repeat upload procedure for another paper
    bonaparte_text = get_text(
        r"C:\Users\lenovo\Desktop\OJTChatbotBEIC\test_papers"
        r"\Bonaparte_Paper.txt"
        )
    bonaparte_chunks = get_chunks(bonaparte_text)
    bonaparte_doc = {
        'metadata': {
            'paper_title': 'A Case Study of Understanding the Bonaparte Basin',
            'author_names': [
                'A.N.Sazali', 'N.M. Hernandez', 'F. Baillard', 'K.G. Maver'],
            'filename': 'Bonaparte_Paper.pdf',
            'tags': [
                'Case Study', 
                'Machine Learning', 
                'Iraya', 
                'Documents', 
                'Geology']
        },
        'chunks': bonaparte_chunks

    }
    upload_to_pgdb(bonaparte_doc, conn)



if __name__ == "__main__":
    main()