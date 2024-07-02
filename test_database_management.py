import unittest

import psycopg2

from database_management import connect_to_or_create_pgdb
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

if __name__ == "__main__":
    unittest.main()