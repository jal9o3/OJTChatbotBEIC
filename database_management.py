import psycopg2
# PGDB --> Postgres Database

from text_management import calculate_sha256

from constants import PGDB_PASS

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
            tags TEXT[] -- An array of tags
        """
    elif table_name == "chunks":
        columns = """
            hash_string TEXT PRIMARY KEY,
            chunk TEXT,
            chunk_order SERIAL,
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


def upload_to_pgdb(document, pgdb_conn):
    """
    Uploads document metadata and chunks to PostgreSQL database.
    """

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
        # Generate hash_string (you can replace this with your actual hash_string function)
        hash_string = calculate_sha256(chunk) + calculate_sha256(str(i))

        cursor.execute("""
            INSERT INTO chunks (hash_string, chunk, chunk_order, paper_id)
            VALUES (%s, %s, %s, %s)
            """, (hash_string, chunk, i, paper_id)
        )


    # Commit changes to the database
    pgdb_conn.commit()
    cursor.close()
    pgdb_conn.close()


