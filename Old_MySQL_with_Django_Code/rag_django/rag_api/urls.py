from django.urls import path
from . import views
from django.conf import settings

from .views import FileUploadAPIView

urlpatterns = [
    path('query/<str:query>/<int:n_results>/', views.query, name='query'),
    path('upload-file/', FileUploadAPIView.as_view(), name='upload_file')
]