import hashlib

import chromadb

import mysql.connector

CHUNK_LIMIT = 95

def connect_to_chroma_db(chroma_client):
    # Display existing ChromaDB collections
    collections = chroma_client.list_collections()
    print("Existing ChromaDB collections: ")
    print(collections)

    # Ask user for ChromaDB collection name
    # collection_name = input("Enter ChromaDB collection name: ")
    
    collection_name = "technical"
    
    # Create or get the ChromaDB collection
    collection = chroma_client.get_or_create_collection(name=collection_name)
    print(f"Selected the ChromaDB collection '{collection_name}'")

    # chroma_client.persist()
    print("NOTE: ChromaDB Client is automatically persisted!")

    return collection, collection_name


def examine_chunks(query, paper_title, cursor, chroma_client):
    print("Examining chunks...")
    # Get every row in MySQL database that corresponds to the given title
    cursor.execute("SELECT * FROM papers WHERE title = %s", (paper_title,))
    paper = cursor.fetchone()
    if not paper:
        return "No paper found with the title: " + paper_title

    # Get the chunks for the paper
    cursor.execute("SELECT * FROM chunks WHERE paper_id = %s ORDER BY chunk_order", (paper[0],))
    chunks = cursor.fetchall()

    # Check if temp_collection exists and delete if it does (to avoid errors)
    if "temp_collection" in [c.name for c in chroma_client.list_collections()]:
        chroma_client.delete_collection(name="temp_collection")

    # Convert to ChromaDB collection
    collection = chroma_client.create_collection("temp_collection")
    # for chunk in chunks:
    #     collection.add(chunk[3])  # Assuming the chunk text is in the fourth column

    print("Adding paper to ChromaDB collection...")
    # Insert paper record into Technical ChromaDB collection
    # collection.add(
    #     documents=[chunk[3] for chunk in chunks],
    #     metadatas=[{"source": paper_title} for i in range(len(chunks))],
    #     ids=[f"id{i}" for i in range(len(chunks))]
    # )
    # TODO: attempt an approach to save memory
    for i, chunk in enumerate(chunks[:CHUNK_LIMIT]):
        collection.add(
            documents=[chunk[3]],
            metadatas=[{"source": paper_title}],
            ids=[f"id{i}"]
        )
    print(f"Saved {paper_title} to temp_collection ChromaDB collection")

    # Pass the query to the collection
    # results = collection.query(query)

    results = collection.query(
        query_texts = [
            query
        ],
        n_results=2
    )
    print(results["documents"])

    # Delete collection to save memory
    chroma_client.delete_collection(name="temp_collection")

    # Return the results
    return results


def query_collection(chroma_client, collection, cursor, query, n_results):
    # List every document in collection
    print("Listing documents...")
    documents = collection.get()
    for document in documents["documents"]:
        print(document)
    
    results = collection.query(
        query_texts = [
            query
        ],
        n_results=n_results
    )
    print(results["documents"])
    # TODO: return tuple of deeper results for the top three titles
    # deeper_results = examine_chunks(query, results["documents"][0][0], cursor, chroma_client)
    # print(deeper_results["documents"])
    
    # Initialize an empty tuple to store deeper results
    deeper_results_tuple = ()
    
    # Loop through the top three documents
    for title in results["documents"][0][:3]:
        # Get deeper results for each title
        deeper_results = examine_chunks(query, title, cursor, chroma_client)
        print(deeper_results)
        # print(deeper_results["documents"])
        for document in deeper_results["documents"]:
            print(document)
        
        # Add the deeper results to the tuple
        # deeper_results_tuple += (deeper_results["documents"],)
        deeper_results_tuple += (deeper_results,)
        
    print("Done examining chunks.")
    
    # Return the tuple of deeper results for the top three titles
    return deeper_results_tuple

def hash_string(input_string):
    # Create a new sha256 hash object
    hash_object = hashlib.sha256()

    # Update the hash object with the bytes of the string
    hash_object.update(input_string.encode())

    # Get the hexadecimal representation of the hash
    hashed_string = hash_object.hexdigest()

    return hashed_string

def upload_to_chroma_db(collection, collection_name, pdf_path, file_name):
    print("Adding paper to ChromaDB collection...")
    # Insert paper record into Technical ChromaDB collection
    collection.add(
        documents=file_name,
        metadatas=[{"source": pdf_path}],
        ids=[f"id#{hash_string(file_name)}"]
    )
    print(f"Saved {file_name} to {collection_name} ChromaDB collection")