from django.db import models

# Create your models here.
class Data(models.Model):
    name = models.CharField(max_length=200)
    description = models.CharField(max_length=500)

class UploadedFile(models.Model):
    file = models.FileField()
    uploaded_on = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.uploaded_on.date()