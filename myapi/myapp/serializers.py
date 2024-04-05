from rest_framework import serializers
from .models import User, Postagem, CommentsPostagem

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model=User
        fields=["id","name","passWord","email","username"]
class PostagemSerializer(serializers.ModelSerializer):
    class Meta:
        model=Postagem
        fields=["id","content","arquivo", "likes", "dislikes"]
class CommentsPostagemSerializer(serializers.ModelSerializer):
    class Meta:
        model = CommentsPostagem
        fields=["id","user","postagem","text"]