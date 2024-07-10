import psycopg2

from constants import PGDB_PASS

from vector_management import get_MiniLM_embedding

def main():
    conn = psycopg2.connect(
            dbname='knowledge_base',
            user='postgres',
            password=PGDB_PASS,
            host='localhost',
            port=5432
        )
    cur = conn.cursor()

    query_embedding = get_MiniLM_embedding("What's the Bonaparte Paper?")
    
    # Use L1 distance to query vectors 
    cur.execute(f"""
                SELECT * FROM chunks 
                ORDER BY embedding <+> '{query_embedding.tolist()}' 
                LIMIT 5;
                """)

    query_results = cur.fetchall()

    for i, query_result in enumerate(query_results):
        print(f"Result {i} -> {query_result[1]}")

    cur.close()
    conn.close()

if __name__ == "__main__":
    main()