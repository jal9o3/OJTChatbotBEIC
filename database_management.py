import logging

import numpy as np

import psycopg2
# PGDB --> Postgres Database

from text_management import calculate_sha256, generate_random_string
from vector_management import get_USE_embedding, get_MiniLM_embedding

from constants import PGDB_PASS

# Set the dimensions of the vectors in the Postgres db vector column
# Should correspond with the output of the embedding model
VECTOR_DIMENSIONS = 384

def connect_to_or_create_pgdb(pgdb_name):
    # Connect to the database server
    conn = psycopg2.connect(
    dbname="postgres",
    user="postgres",
    password=PGDB_PASS,
    host="localhost",
    port=5432,
    )
    conn.autocommit = True

    cur = conn.cursor()
    # Check if the desired database exists
    cur.execute("SELECT datname FROM pg_database;")
    databases = cur.fetchall()
    if pgdb_name not in [db[0] for db in databases]:
        # Create the database if it doesn't exist
        cur.execute(f"CREATE DATABASE {pgdb_name}")
    
    # Connect to newly created database and enable pgvector extension
    # Start by closing existing connection
    cur.close()
    conn.close()
    # Connect to the newly created database
    conn = psycopg2.connect(
    dbname=pgdb_name,
    user="postgres",
    password=PGDB_PASS,
    host="localhost",
    port=5432,
    )
    conn.autocommit = True

    cur = conn.cursor()
    # Enable the pgvector extension in the database
    # (needs to be only done once per database, hence why it is done here)
    cur.execute("CREATE EXTENSION IF NOT EXISTS vector;")
    # Close connection for safety
    cur.close()
    conn.close()

def create_table_if_not_exists(table_name, db_name):
    # Connect to the database server
    conn = psycopg2.connect(
    dbname=db_name,
    user="postgres",
    password=PGDB_PASS,
    host="localhost",
    port=5432,
    )

    cursor = conn.cursor()

    accepted_table_names = [
        "paper_titles", 
        "chunks", 
        "test_table",
        "temp_table"
    ]

    columns = ""

    if table_name == "paper_titles":
        columns = """
            id VARCHAR(255) PRIMARY KEY,
            paper_title TEXT,
            author_names TEXT[], -- An array of author names
            filename TEXT,
            tags TEXT[] -- An array of tags
        """
    elif table_name == "chunks":
        columns = f"""
            hash_string TEXT PRIMARY KEY,
            chunk TEXT,
            chunk_order SERIAL,
            embedding vector({VECTOR_DIMENSIONS}), --column for vector
            paper_id VARCHAR(255) REFERENCES paper_titles(id)
        """

    query = f"""
        CREATE TABLE IF NOT EXISTS {table_name} (
            {columns}
        );
    """

    cursor.execute(query)
    conn.commit()
    cursor.close()
    conn.close()

def drop_database(db_name):
    # Connect to the database server
    conn = psycopg2.connect(
        dbname="postgres",  # Connect to the default 'postgres' database
        user="postgres",
        password=PGDB_PASS,
        host="localhost",
        port=5432,
    )
    conn.autocommit = True
    cur = conn.cursor()
    # Terminates sessions that are accessing the database to prevent conflicts
    query = f"""
        SELECT pg_terminate_backend (pg_stat_activity.pid)
        FROM pg_stat_activity
        WHERE pg_stat_activity.datname = '{db_name}';
    """
    cur.execute(query)

    with conn.cursor() as cur:
        cur.execute(f"DROP DATABASE {db_name};")
    cur.close()
    conn.close()


def upload_to_pgdb(document, pgdb_conn, logging_level=logging.FATAL):
    """
    Uploads document metadata and chunks to PostgreSQL database.
    """

    # Initialize Python logger
    logger = logging.getLogger(__name__)
    # Disable INFO logs from sentence_transformers and tensorflow libraries
    logging.getLogger('sentence_transformers').setLevel(logging.WARNING)
    logging.getLogger('tensorflow_hub').setLevel(logging.WARNING)
    # Configure format and level of log messages
    logging.basicConfig(
        format='\n%(levelname)s: %(message)s', level=logging_level)

    cursor = pgdb_conn.cursor()

    # Create database if it doesn't exist
    connect_to_or_create_pgdb("knowledge_base")

    # Create paper_titles table if it doesn't exist
    create_table_if_not_exists("paper_titles", "knowledge_base")
    # Insert title into paper_titles table and generate primary key
    data = document["metadata"]
    # Convert dictionary to SQL insert
    columns = data.keys()
    paper_id = calculate_sha256(data["paper_title"])
    values = [data[column] for column in columns]
    values.append(paper_id)
    insert_statement = f"""
        INSERT INTO paper_titles ({', '.join(columns)}, id) 
        VALUES ({', '.join(['%s'] * len(values))})
    """
    cursor.execute(insert_statement, values)

    chunks = document['chunks']
    # Create chunks table if it doesn't exist
    create_table_if_not_exists("chunks", "knowledge_base")
    # Insert chunks into chunks table
    # Insert each chunk into the table
    for i, chunk in enumerate(chunks):
        # Generate hash_string that avoids collisions of identical chunks
        hash_string = \
            calculate_sha256(
            calculate_sha256(chunk) + \
            calculate_sha256(str(i)) + \
            calculate_sha256(generate_random_string(7))
            )
        
        # Generate USE embedding of chunk
        # Convert embedding to numpy format and then to list 
        # for storage in pgvector
        # embedding = get_USE_embedding(chunk).numpy().tolist()

        # Generate all-MiniLM-L2-v6 embedding of chunk
        # Convert to list format for storage in pgvector
        embedding = get_MiniLM_embedding(chunk).tolist()

        cursor.execute("""
            INSERT INTO chunks (hash_string, chunk, chunk_order, 
                       embedding, paper_id)
            VALUES (%s, %s, %s, %s, %s)
            """, (hash_string, chunk, i, embedding, paper_id)
        )
        pgdb_conn.commit()
        logger.info(f"Committed Chunk {i+1} of {len(chunks)} from "
                    f"Paper #{paper_id}.")


    # Commit changes to the database
    pgdb_conn.commit()
    cursor.close()
    pgdb_conn.close()


