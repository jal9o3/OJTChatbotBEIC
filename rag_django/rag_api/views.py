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
        print("File Upload view opened.")
        serializer = self.serializer_class(data=request.data)
        print("Serializer:")
        print(serializer)
        print("Request:")
        print(request)
        print("Request Data:")
        print(request.data)
        print("Checking if valid...")
        if serializer.is_valid():
            # You can access the file like this from serializer:
            # uploaded_file = serializer.validated_data["file"]
            print("Saving...")
            serializer.save()
            print("Saved!")
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