from django.db import models

# Create your models here.

class User(models.Model):
    name = models.CharField(max_length=100)
    passWord = models.CharField(max_length=100)
    email = models.EmailField()
    username = models.CharField(max_length=100)

class Postagem(models.Model):
    isTextQuestion = models.BooleanField()
    content = models.CharField(max_length=500)
    likes = models.IntegerField()
    dislikes = models.IntegerField()

class CommentsPostagem(models.Model):
    user=models.ForeignKey(User, on_delete=models.CASCADE)
    postagem=models.ForeignKey(Postagem, on_delete=models.CASCADE)
    text=models.CharField(blank=True, max_length=500)

