-- See all databases
SELECT datname FROM pg_database WHERE datistemplate = false;


-- See all tables
SELECT * FROM pg_catalog.pg_tables;


-- See all public tables
SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';


-- See contents of paper_titles table
SELECT * from paper_titles

	
-- See contents of chunks table
SELECT * from chunks

	
-- Select chunks from a specific paper using ID
SELECT * FROM chunks WHERE paper_id='8c941b1518412bff0d533886d431b90fa0fb36f51275d2f0d145ab17cb94e740'

	
-- Select chunks from a specific paper using title, ascending by chunk order
SELECT c.*
FROM chunks AS c
WHERE c.paper_id = (
    SELECT pt.id
    FROM paper_titles AS pt
    WHERE pt.paper_title = 'A Case Study of Understanding the Bonaparte Basin'
)
ORDER BY c.chunk_order ASC;

-- adapt previous query

SELECT pt.*
FROM paper_titles AS pt
WHERE pt.id = '8c941b1518412bff0d533886d431b90fa0fb36f51275d2f0d145ab17cb94e740';



-- END OF DEMO QUERIES
-- MAINTENANCE QUERIES BEGIN HERE

	
-- Drop chunks table
DROP TABLE chunks;

-- Drop paper_titles table
DROP TABLE paper_titles;

-- See active connections to knowledge_base
SELECT * FROM pg_stat_activity WHERE datname = 'knowledge_base';

-- Terminate connection PID
SELECT pg_terminate_backend (815);

-- Drop knowledge_base database
DROP DATABASE IF EXISTS knowledge_base;
