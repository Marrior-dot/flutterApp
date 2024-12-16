from django.db import models

#Para todos os modelos que não possuem class Meta
#A ordenação na página de administrador é feita a partir do campo 'id', ou da chave primária

class User(models.Model):
    """
    Representa um usuário do sistema.
    """
    name = models.CharField(max_length=100)  # Nome do usuário
    password = models.CharField(max_length=100)  # Senha do usuário
    email = models.EmailField(blank=True)  # Email do usuário (opcional)
    username = models.CharField(max_length=100, primary_key=True, unique=True)  # Nome de usuário (único e chave primária)

    #Meta:
    #ordering: Define a ordenação padrão dos usuários como sendo por 'email'.
    class Meta:
        ordering = ['email']

    def __str__(self) -> str:
        return self.name


class Postagem(models.Model):
    """
    Representa uma postagem no sistema.
    """
    arquivo = models.ImageField(blank=True, null=True, default="", upload_to='images')  # Arquivo de imagem da postagem (opcional)
    title = models.CharField(max_length=100, null=False, default="LoremIpsum")  # Título da postagem
    content = models.CharField(max_length=500, blank=True)  # Conteúdo da postagem (opcional)
    likes = models.IntegerField(default=0)  # Número de curtidas
    dislikes = models.IntegerField(default=0)  # Número de descurtidas
    escolha_unica = models.BooleanField(default=False)  # Indica se a postagem permite apenas uma escolha (curtir ou descurtir)
    
    #Meta:
    #ordering: Define a ordenação padrão das postagens como sendo por 'content'.
    class Meta:
        ordering = ['content']

    def __str__(self) -> str:
        return f"{self.title}"


class PersistenciaUserPostagem(models.Model):
    """
    Representa a persistência da interação de um usuário com uma postagem.
    Guarda informações sobre as escolhas do usuário (curtir/descurtir).
    """
    user = models.ForeignKey(User, on_delete=models.CASCADE)  # Usuário associado
    postagem = models.ForeignKey(Postagem, on_delete=models.CASCADE)  # Postagem associada
    tipoBotao = models.BooleanField(null=True)  # Tipo de botão clicado (curtir/descurtir) - True para curtir, False para descurtir.
    habilitado = models.BooleanField(null=True, default=True)  # Indica se o botão está habilitado para o usuário


class Respostas(models.Model):
    """
    Representa uma resposta a uma postagem.
    """
    respostaTexto = models.CharField(max_length=500, blank=True, null=True, default="")  # Texto da resposta
    respondido = models.IntegerField(default=0)  # Contador de quantas vezes a resposta foi escolhida
    postagem = models.ForeignKey(Postagem, on_delete=models.CASCADE)  # Postagem associada
    
    #Meta:
    #ordering: Define a ordenação padrão das respostas como sendo por 'respostaTexto'.
    class Meta:
        ordering = ['respostaTexto']

    def __str__(self):
        return f"{self.respostaTexto} || Respostas: {self.respondido}"


class PersistenciaUserResposta(models.Model):
    """
    Representa a persistência da interação de um usuário com uma resposta.
    """
    user = models.ForeignKey(User, on_delete=models.CASCADE)  # Usuário associado
    postagem = models.ForeignKey(Postagem, on_delete=models.CASCADE, null=True)  # Postagem associada


class Commentarios(models.Model):
    """
    Representa um comentário em uma postagem.
    """
    username = models.CharField(max_length=100)  # Nome de usuário que fez o comentário
    postagem = models.ForeignKey(Postagem, on_delete=models.CASCADE)  # Postagem associada
    text = models.CharField(max_length=500)  # Texto do comentário
    
    #Meta:
    #ordering: Define a ordenação padrão das respostas como sendo por 'respostaTexto'.
    class Meta:
        ordering = ['postagem']

    def __str__(self) -> str:
        return self.text