from django.db import models

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

class Respostas(models.Model):
    respostaTexto = models.CharField(max_length=500 ,blank=True, null=True, default="")
    respondido = models.IntegerField(default=0)

    class Meta:
        ordering = ['respostaTexto']
    
    def __str__(self):
        return self.respostaTexto


class Postagem(models.Model):
    arquivo = models.ImageField(blank= True,null=True, default="", upload_to='images')
    content = models.CharField(max_length=500)
    likes = models.IntegerField(default=0)
    dislikes = models.IntegerField(default=0)
    respostas = models.ManyToManyField(Respostas, blank=True, default="")
    escolha_unica = models.BooleanField(default=False)

    class Meta:
        ordering = ['content']
    
    def __str__(self) -> str:
        return self.content
    

class CommentsPostagem(models.Model):
    username = models.CharField(max_length=100)
    postagem=models.ForeignKey(Postagem, on_delete=models.CASCADE)
    text=models.CharField(max_length=500)

    class Meta:
        ordering = ['postagem']
    
    def __str__(self) -> str:
        return self.text