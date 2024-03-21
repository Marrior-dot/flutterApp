from rest_framework import serializers
from .models import User, Postagem

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model=User
        fields=["id","name","passWord","email","username"]
class PostagemSerializer(serializers.ModelSerializer):
    class Meta:
        model=Postagem
        fields=["isTextQuestion ","content","arquivo", "likes", "dislikes"]