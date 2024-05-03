from rest_framework import serializers
from rest_framework.validators import UniqueTogetherValidator
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
    user = serializers.PrimaryKeyRelatedField(read_only=True)
    postagem = serializers.PrimaryKeyRelatedField(read_only=True) #PostagemSerializer()
    class Meta:
        model=CommentsPostagem
        fields=["id","user","postagem","text"]
        #fields=["user","postagem","text"]