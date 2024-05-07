from rest_framework import serializers
from .models import User, Postagem, CommentsPostagem

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model=User
        fields=["name","password","email","username"]

class PostagemSerializer(serializers.ModelSerializer):
    class Meta:
        model=Postagem
        fields=["id","content","arquivo","likes","dislikes"]
        
class CommentsPostagemSerializer(serializers.ModelSerializer):
    postagem = PostagemSerializer(read_only=True)
    class Meta:
        model=CommentsPostagem
        fields=["username","postagem","text"]