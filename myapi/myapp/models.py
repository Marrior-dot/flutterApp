from django.db import models
from django.contrib.auth.models import User

# Create your models here.

class User(models.Model):
    name = models.CharField(max_length=100, blank=True)
    password = models.CharField(max_length=100, blank=True)
    email = models.EmailField(blank=True)
    username = models.CharField(max_length=100, blank=True, primary_key=True)

    class Meta:
        ordering = ['email']
class Postagem(models.Model):
    #isTextQuestion = models.BooleanField()
    arquivo = models.FileField(blank=True, default="")
    content = models.CharField(max_length=500, blank=True)
    likes = models.IntegerField(blank=True)
    dislikes = models.IntegerField(blank=True)

    class Meta:
        ordering = ['content']

class CommentsPostagem(models.Model):
    user=models.ForeignKey(User, on_delete=models.CASCADE, blank=True)
    postagem=models.ForeignKey(Postagem, on_delete=models.CASCADE, blank=True)
    text=models.CharField(max_length=500)

    class Meta:
        ordering = ['text']

