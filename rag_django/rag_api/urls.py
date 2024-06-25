from django.urls import path
from . import views
from django.conf import settings

urlpatterns = [
    path('query/<str:query>/<int:n_results>/', views.query, name='query'),
    #path('post/', views.postData),
]