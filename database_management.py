import psycopg2
# PGDB --> Postgres Database

from constants import PGDB_PASS

# Connect to the database server
conn = psycopg2.connect(
    dbname="postgres",  # Connect to the default 'postgres' database
    user="postgres",
    password=PGDB_PASS,
    host="localhost",
    port=5432,
)
# conn.autocommit = True  # Set autocommit mode

# Create a cursor
cur = conn.cursor()


def connect_to_or_create_pgdb(pgdb_name, conn, cur):
    # Check if the desired database exists
    cur.execute("SELECT datname FROM pg_database;")
    databases = cur.fetchall()
    if pgdb_name not in [db[0] for db in databases]:
        # Create the database if it doesn't exist
        cur.execute(f"CREATE DATABASE {pgdb_name}")


def upload_to_pgdb(document, pgdb):
    """
    Uploads document metadata and chunks to PostgreSQL database.

    Args:
        document (dict): A dictionary with keys 'metadata' and 'chunks'.
            - 'metadata' (list): Contains 'title' (str), 'author' (str), and 'tags' (list of str).
            - 'chunks' (list): Contains individual chunks (str).
        postgres_db: An instance of your PostgreSQL database connection.

    Returns:
        None
    """
    # Extract metadata
    title = document['metadata']['title']
    author = document['metadata']['author']
    tags = document['metadata']['tags']

    # Create database if it doesn't exist

    # Create paper_titles table if it doesn't exist
    # Insert title into paper_titles table and generate primary key

    # Example query: INSERT INTO paper_titles (title, author) VALUES (%s, %s) RETURNING id
    # Execute the query and get the generated primary key

    # Create chunks table if it doesn't exist
    # Insert chunks into chunks table

    # Example query: INSERT INTO chunks (chunk_text, paper_id, chunk_order) VALUES (%s, %s, %s)
    # Execute the query for each chunk, using the generated primary key from paper_titles as foreign key

    # Commit changes to the database
    postgres_db.commit()

# Usage example:
# postgres_db = create_postgres_connection()  # Create your PostgreSQL connection
# document = {
#     'metadata': {'title': 'Sample Title', 'author': 'John Doe', 'tags': ['NLP', 'Research']},
#     'chunks': ['Chunk 1', 'Chunk 2', 'Chunk 3']
# }
# upload_to_postgres(document, postgres_db)
