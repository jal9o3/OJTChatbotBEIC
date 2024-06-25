from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.decorators import api_view

from django.http import JsonResponse

from urllib.parse import unquote

import chromadb
import mysql.connector

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