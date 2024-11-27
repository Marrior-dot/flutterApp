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

class Postagem(models.Model):
    arquivo = models.ImageField(blank= True,null=True, default="", upload_to='images')
    title = models.CharField(max_length=100, null= False, default="LoremIpsum")
    content = models.CharField(max_length=500, blank=True)
    likes = models.IntegerField(default=0)
    dislikes = models.IntegerField(default=0)
    escolha_unica = models.BooleanField(default=False)

    class Meta:
        ordering = ['content']
    
    def __str__(self) -> str:
        return f"{self.title}"

class PersistenciaUserPostagem(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    postagem = models.ForeignKey(Postagem, on_delete=models.CASCADE)
    tipoBotao = models.BooleanField(null=True)
    habilitado = models.BooleanField(null=True, default=True)

class Respostas(models.Model):
    respostaTexto = models.CharField(max_length=500 ,blank=True, null=True, default="")
    respondido = models.IntegerField(default=0)
    postagem = models.ForeignKey(Postagem, on_delete=models.CASCADE)

    class Meta:
        ordering = ['respostaTexto']
    
    def __str__(self):
        return f"{self.respostaTexto} || Respostas: {self.respondido}"

class PersistenciaUserResposta(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    postagem = models.ForeignKey(Postagem, on_delete=models.CASCADE, null=True)

class Commentarios(models.Model):
    username = models.CharField(max_length=100)
    postagem=models.ForeignKey(Postagem, on_delete=models.CASCADE)
    text=models.CharField(max_length=500)

    class Meta:
        ordering = ['postagem']
    
    def __str__(self) -> str:
        return self.text