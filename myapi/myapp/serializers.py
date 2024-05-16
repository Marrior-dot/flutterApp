from rest_framework import serializers
from .models import User, Postagem, CommentsPostagem, Respostas

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model=User
        fields=["name","password","email","username"]

class PostagemSerializer(serializers.ModelSerializer):
    respostas = serializers.StringRelatedField(many=True, read_only=True)
    class Meta:
        model=Postagem
        fields=["id","content","arquivo","likes","dislikes","respostas","escolha_unica"]

class RespostasSerializer(serializers.ModelSerializer):
    class Meta:
        model = Respostas
        fields = ["respostaBool"]
        
class CommentsPostagemSerializer(serializers.ModelSerializer):
    postagem = PostagemSerializer(read_only=True)
    class Meta:
        model=CommentsPostagem
        fields=["username","postagem","text"]