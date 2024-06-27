from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.decorators import api_view

from django.http import JsonResponse

from urllib.parse import unquote

import chromadb
import mysql.connector

from rest_framework import status
from rest_framework.parsers import FormParser, MultiPartParser
from rest_framework.response import Response
from rest_framework.views import APIView

from .serializers import FileUploadSerializer

from ojt_modules import chroma_functions
from ojt_modules import mysql_functions

# Create your views here.

def query(request, query, n_results):
    query = unquote(query)
    
    chroma_client = chromadb.PersistentClient(path="./chroma_persistent_client")
    collection, collection_name = chroma_functions.connect_to_chroma_db(chroma_client)
    conn, cursor = mysql_functions.setup_mysql_db()
    
    results = chroma_functions.query_collection(chroma_client, collection, cursor, query, n_results)
    
    # data = {"query": query}
    return JsonResponse(results, safe=False)

class FileUploadAPIView(APIView):
    parser_classes = (MultiPartParser, FormParser)
    serializer_class = FileUploadSerializer

    def post(self, request, *args, **kwargs):
        chroma_client = chromadb.PersistentClient(path="./chroma_persistent_client")
        conn, cursor = mysql_functions.setup_mysql_db()
        collection, collection_name = chroma_functions.connect_to_chroma_db(chroma_client)
        
        serializer = self.serializer_class(data=request.data)
        if serializer.is_valid():
            serializer.save()
            # TODO: filter out everything except txt files
            # serializer.validated_data["file"] gives the file name
            file_name = serializer.validated_data["file"].name
            split_file_name = file_name.split('.')
            # TODO: upload txt file to MySQL databases
            with open(f"media/{file_name}", 'r', encoding='utf-8') as f:
                text = f.read()

            print("Uploading .txt to MySQL...")
            mysql_functions.upload_to_mysql_db(conn, cursor, split_file_name[0], text)

            # the file_name (title) is what's added to the chromadb collection,
            # pdf path is reconstructed
            print("Saving title to ChromaDB...")
            chroma_functions.upload_to_chroma_db(collection, collection_name, 
                                                 f'{split_file_name[0]}.pdf', 
                                                 split_file_name[0])
            return Response(
                serializer.data,
                status=status.HTTP_201_CREATED
            )
        
        print("Invalid!")
        return Response(
            serializer.errors,
            status=status.HTTP_400_BAD_REQUEST
        )

    # def post(self, request, format=None):
    #     print(request.FILES.keys())
    #     my_file = request.FILES['file_field_name']
    #     filename = '/tmp/myfile'
    #     with open(filename, 'wb+') as temp_file:
    #         for chunk in my_file.chunks():
    #             temp_file.write(chunk)

    #     my_saved_file = open(filename) #there you go