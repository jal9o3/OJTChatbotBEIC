import chromadb

import os, sys

def main():
    print(os.getcwd())
    
    client = chromadb.PersistentClient(path="C:\\Users\\lenovo\\Desktop\\OJTChatbotBEIC\\rag_django\\chroma_persistent_client")

    # Uncomment this in case 'examine chunk' code fails
    # client.delete_collection(name="temp_collection")
    # sys.exit()

    # Display existing ChromaDB collections
    collections = client.list_collections()
    print("Existing ChromaDB collections: ")
    print(collections)

    # Ask user for ChromaDB collection name
    collection_name = input("Enter ChromaDB collection name: ")

    coll = client.get_collection(collection_name)
    documents = coll.get()
    #print(documents["documents"])
    for document in documents["documents"]:
        print(document)
        
if __name__ == "__main__":
    main()