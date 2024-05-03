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

    def __str__(self) -> str:
        return self.name
    
class Postagem(models.Model):
    arquivo = models.FileField(blank=True, null=True, default="")
    content = models.CharField(max_length=500, blank=True)
    likes = models.IntegerField(blank=True, default=0)
    dislikes = models.IntegerField(blank=True, default=0)

    class Meta:
        ordering = ['content']
    
    def __str__(self) -> str:
        return self.content

class CommentsPostagem(models.Model):
    user=models.ForeignKey(User, on_delete=models.CASCADE, blank=True)
    postagem=models.ForeignKey(Postagem, on_delete=models.CASCADE, blank=True)
    text=models.CharField(max_length=500)

    class Meta:
        ordering = ['postagem']