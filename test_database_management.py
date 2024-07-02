import unittest

import psycopg2

from database_management import connect_to_or_create_pgdb
from database_management import create_table_if_not_exists

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
        connect_to_or_create_pgdb("test_db", cur)
        cur.execute("SELECT datname FROM pg_database;")
        databases = cur.fetchall()
        # Assert that test_db is in databases
        self.assertIn("test_db", [db[0] for db in databases])

class TestCreateTableIfNotExists(unittest.TestCase):
    def test_create_table_if_not_exists(self):
        conn = psycopg2.connect(
            dbname="test_db",  # Connect to the default 'postgres' database
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


if __name__ == "__main__":
    unittest.main()