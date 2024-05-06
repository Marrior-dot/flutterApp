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
    #user = UserSerializer(many=True, read_only=True) #serializers.PrimaryKeyRelatedField(read_only=True)
    #postagem = PostagemSerializer(many=True, read_only=True) #serializers.PrimaryKeyRelatedField(read_only=True)
    #class Meta:
    #    model=CommentsPostagem
    #    fields=["id","user","postagem","text"]
    class Meta:
        model=CommentsPostagem
        fields=["text"]