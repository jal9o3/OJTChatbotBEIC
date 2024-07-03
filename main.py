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

    conn.commit()
        

    wotw_text = get_text(
        r"C:\Users\lenovo\Desktop\OJTChatbotBEIC\War of the Worlds.txt"
        )
    wotw_chunks = get_chunks(wotw_text)
    wotw_doc = {
        'metadata': {
            'paper_title': 'War of the Worlds',
            'author_names': ['H.G. Wells'],
            'tags': ['Science Fiction', '1800s']
        },
        'chunks': wotw_chunks

    }
    upload_to_pgdb(wotw_doc, conn)

if __name__ == "__main__":
    main()