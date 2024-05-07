from django.db import models
from django.contrib.auth.models import User

# Create your models here.

class User(models.Model):
    name = models.CharField(max_length=100)
    password = models.CharField(max_length=100)
    email = models.EmailField(blank=True)
    username = models.CharField(max_length=100, primary_key=True, unique=True)

    class Meta:
        ordering = ['email']

    def __str__(self) -> str:
        return self.name
    
class Postagem(models.Model):
    arquivo = models.FileField(blank= True,null=True, default="")
    content = models.CharField(max_length=500)
    likes = models.IntegerField(default=0)
    dislikes = models.IntegerField(default=0)

    class Meta:
        ordering = ['content']
    
    def __str__(self) -> str:
        return self.content

class CommentsPostagem(models.Model):
    #user=models.ForeignKey(User, on_delete=models.CASCADE)
    username = models.CharField(max_length=100)
    postagem=models.ForeignKey(Postagem, on_delete=models.CASCADE)
    text=models.CharField(max_length=500)

    class Meta:
        ordering = ['postagem']
    
    def __str__(self) -> str:
        return self.text