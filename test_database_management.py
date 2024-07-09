import unittest

import psycopg2

from database_management import connect_to_or_create_pgdb, drop_database
from database_management import create_table_if_not_exists, upload_to_pgdb

from text_management import calculate_sha256

from constants import PGDB_PASS


class TestConnectToOrCreatePgdb(unittest.TestCase):
    def test_connect_to_or_create_pgdb(self):
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
        # Test the function
        connect_to_or_create_pgdb("test_db")
        cur.execute("SELECT datname FROM pg_database;")
        databases = cur.fetchall()
        # Assert that test_db is in databases
        self.assertIn("test_db", [db[0] for db in databases])
        cur.close()
        conn.close()
        drop_database("test_db")

class TestCreateTableIfNotExists(unittest.TestCase):
    def test_create_table_if_not_exists(self):
        conn = psycopg2.connect(
            dbname="postgres",
            user="postgres",
            password=PGDB_PASS,
            host="localhost",
            port=5432,
        )
        cur = conn.cursor()
        # Create test database
        connect_to_or_create_pgdb("test_db")

        # Close connection before reconnecting to new test_db
        cur.close()
        conn.close()

        conn = psycopg2.connect(
            dbname="test_db",
            user="postgres",
            password=PGDB_PASS,
            host="localhost",
            port=5432,
        )
        cur = conn.cursor()

        # Test the function
        create_table_if_not_exists("test_table", "test_db")
        
        # Execute the query to get table names
        cur.execute(f"""
            SELECT table_name
            FROM information_schema.tables
            WHERE table_schema = 'public'
        """)

        # Fetch all table names
        table_names = cur.fetchall()

        exists = "test_table" in [table_name[0] for table_name in table_names]

        # Assert that exists is True
        self.assertTrue(exists)
        # Close connection to avoid session conflicts in drop_database
        cur.close()
        conn.close()
        # Delete test database
        drop_database("test_db")

    def test_create_paper_titles_table_if_not_exists(self):
        conn = psycopg2.connect(
            dbname="postgres",
            user="postgres",
            password=PGDB_PASS,
            host="localhost",
            port=5432,
        )
        cur = conn.cursor()
        # Create test database
        connect_to_or_create_pgdb("test_db")

        # Close connection before reconnecting to new test_db
        cur.close()
        conn.close()

        conn = psycopg2.connect(
            dbname="test_db",
            user="postgres",
            password=PGDB_PASS,
            host="localhost",
            port=5432,
        )
        cur = conn.cursor()

        # Test the function
        create_table_if_not_exists("paper_titles", "test_db")
        
        # Execute the query to get table names
        cur.execute(f"""
            SELECT table_name
            FROM information_schema.tables
            WHERE table_schema = 'public'
        """)

        # Fetch all table names
        table_names = cur.fetchall()

        exists = "paper_titles" in [table_name[0] for table_name in table_names]

        # Assert that exists is True
        self.assertTrue(exists)

        cur.execute("SELECT * FROM paper_titles")
        column_names = [desc[0] for desc in cur.description]
        self.assertIn("id", column_names)
        self.assertIn("paper_title", column_names)
        self.assertIn("author_names", column_names)
        self.assertIn("filename", column_names)
        self.assertIn("tags", column_names)
        self.assertNotIn("nonexistent_column", column_names)

        # Close connection to avoid session conflicts in drop_database
        cur.close()
        conn.close()
        # Delete test database
        drop_database("test_db")

    def test_create_chunks_table_if_not_exists(self):
        conn = psycopg2.connect(
            dbname="postgres",
            user="postgres",
            password=PGDB_PASS,
            host="localhost",
            port=5432,
        )
        cur = conn.cursor()
        # Create test database
        connect_to_or_create_pgdb("test_db")

        # Close connection before reconnecting to new test_db
        cur.close()
        conn.close()

        conn = psycopg2.connect(
            dbname="test_db",
            user="postgres",
            password=PGDB_PASS,
            host="localhost",
            port=5432,
        )
        cur = conn.cursor()

        # Chunks reference paper_titles through foreign key 
        create_table_if_not_exists("paper_titles", "test_db")
        # Test the function
        create_table_if_not_exists("chunks", "test_db")
        
        # Execute the query to get table names
        cur.execute(f"""
            SELECT table_name
            FROM information_schema.tables
            WHERE table_schema = 'public'
        """)

        # Fetch all table names
        table_names = cur.fetchall()

        exists = "chunks" in [table_name[0] for table_name in table_names]

        # Assert that exists is True
        self.assertTrue(exists)

        cur.execute("SELECT * FROM chunks")
        column_names = [desc[0] for desc in cur.description]
        self.assertIn("hash_string", column_names)
        self.assertIn("chunk", column_names)
        self.assertIn("chunk_order", column_names)
        self.assertIn("embedding", column_names)
        self.assertIn("paper_id", column_names)
        self.assertNotIn("nonexistent_column", column_names)

        # Close connection to avoid session conflicts in drop_database
        cur.close()
        conn.close()
        # Delete test database
        drop_database("test_db")

class TestDropDatabase(unittest.TestCase):
    def test_drop_database(self):
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
        connect_to_or_create_pgdb("temp_db")
        cur.execute("SELECT datname FROM pg_database;")
        databases = cur.fetchall()
        self.assertIn("temp_db", [db[0] for db in databases])
        # Test the function
        drop_database("temp_db")
        cur.execute("SELECT datname FROM pg_database;")
        databases = cur.fetchall()
        # Assert that test_db is in databases
        self.assertNotIn("temp_db", [db[0] for db in databases])
        cur.close()
        conn.close()


class TestUploadToPgdb(unittest.TestCase):
    def test_upload_to_pgdb(self):
        # Set up a test database connection
        connect_to_or_create_pgdb("test_db")
        conn = psycopg2.connect(
            dbname='test_db',
            user='postgres',
            password=PGDB_PASS,
            host='localhost',
            port=5432
        )
        cur = conn.cursor()

        # Create test tables
        create_table_if_not_exists("paper_titles", "test_db")
        create_table_if_not_exists("chunks", "test_db")
        
        conn.commit()
        
        # Example document data
        document = {
            'metadata': {
                'paper_title': 'Sample Document',
                'author_names': ['J. Doe', 'K. Dall'],
                'filename': 'Sample Document.pdf',
                'tags': ['science', 'technology']
            },
            'chunks': ['Chunk 1', 'Chunk 2', 'Chunk 3']
        }

        # Call your function
        upload_to_pgdb(document, conn)

        # Restart the connection
        # (upload_to_pgdb closes connection for safety)
        conn = psycopg2.connect(
            dbname='test_db',
            user='postgres',
            password=PGDB_PASS,
            host='localhost',
            port=5432
        )
        cur = conn.cursor()

        document_id = calculate_sha256(document["metadata"]["paper_title"])
        # Verify that the data was inserted correctly
        cur.execute(f"""
                         SELECT * FROM chunks 
                         WHERE paper_id = '{document_id}'
        """)
        result = cur.fetchall()
        self.assertIsNotNone(result)
        # self.assertEqual(
        #     result[0][0], 
        #     calculate_sha256('Chunk 1') + calculate_sha256(str(0))
        #     )
        # self.assertEqual(
        #     result[1][0], 
        #     calculate_sha256('Chunk 2') + calculate_sha256(str(1))
        #     )
        # self.assertEqual(
        #     result[2][0], 
        #     calculate_sha256('Chunk 3') + calculate_sha256(str(2))
        #     )

        # The IDs can no longer be tested after the hash of a random string
        # has been factored in during ID generation to prevent chunk ID 
        # collisions. However, the behavior of the generate_random_string 
        # function is testable (see test_text_management.py)

        # Test that chunk text has been stored properly
        self.assertEqual(result[0][1], 'Chunk 1')
        self.assertEqual(result[1][1], 'Chunk 2')
        self.assertEqual(result[2][1], 'Chunk 3')

        # Test that chunk order has been stored properly
        self.assertEqual(result[0][2], 0)
        self.assertEqual(result[1][2], 1)
        self.assertEqual(result[2][2], 2)

        # Test that embedding column is not empty
        self.assertIsNotNone(result[0][3])
        self.assertIsNotNone(result[1][3])
        self.assertIsNotNone(result[2][3])

        # Test that chunk's paper ID has been hashed and stored properly
        self.assertEqual(result[0][4], calculate_sha256(
            document["metadata"]["paper_title"])
            )
        self.assertEqual(result[1][4], calculate_sha256(
            document["metadata"]["paper_title"])
            )
        self.assertEqual(result[2][4], calculate_sha256(
            document["metadata"]["paper_title"])
            )
        
        cur.execute(f"""
                         SELECT * FROM paper_titles 
                         WHERE id = '{document_id}'
        """)
        result = cur.fetchone()
        self.assertEqual(result[1], 'Sample Document')
        self.assertEqual(result[2], ['J. Doe', 'K. Dall'])
        self.assertEqual(result[3], 'Sample Document.pdf')
        self.assertEqual(result[4], ['science', 'technology'])

        drop_database("test_db")
        # Clean up: close the cursor and connection
        cur.close()
        conn.close()

if __name__ == "__main__":
    unittest.main()