from rest_framework import serializers
from .models import User, Postagem, Commentarios, Respostas, PersistenciaUserPostagem, PersistenciaUserResposta

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model=User
        fields=["name","password","email","username"]

class PostagemSerializer(serializers.ModelSerializer):
    class Meta:
        model=Postagem
        fields=["id","content","title","arquivo","likes","dislikes","escolha_unica"]

class RespostasSerializer(serializers.ModelSerializer):
    class Meta:
        model = Respostas
        fields = ["respostaTexto", "respondido","postagem"]
        
class PersistenciaUserPostagemSerializer(serializers.ModelSerializer):
    class Meta:
        model = PersistenciaUserPostagem
        fields = ["user","postagem","tipo","habilitado"]

class PersistenciaUserRespostaSerializer(serializers.ModelSerializer):
    class Meta:
        model = PersistenciaUserResposta
        fields = ["user","postagem"]

class CommentsPostagemSerializer(serializers.ModelSerializer):
    postagem = PostagemSerializer(read_only=True)
    class Meta:
        model=Commentarios
        fields=["username","postagem","text"]