import chromadb

def main():
    client = chromadb.PersistentClient(path="./chroma_persistent_client")

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