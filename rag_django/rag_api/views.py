from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.decorators import api_view

from django.http import JsonResponse

from urllib.parse import unquote

# Create your views here.

def query(request, query):
    query = unquote(query)
    data = {"query": query}
    return JsonResponse(data)