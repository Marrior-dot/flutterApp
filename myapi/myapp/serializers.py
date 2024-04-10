from rest_framework import serializers
from rest_framework.validators import UniqueTogetherValidator
from .models import User, Postagem, CommentsPostagem

class UserSerializer(serializers.ModelSerializer):

    #def create(self, validated_data):
     #   user = User.objects.crea(**validated_data)
      #  return user

    class Meta:
        model=User
        fields=["id","name","passWord","email","username"]

       # validators = [
        #    UniqueTogetherValidator(
         #       queryset=User.objects.all(),
          #      fields=['username', 'email'])
        #]

class PostagemSerializer(serializers.ModelSerializer):
    class Meta:
        model=Postagem
        fields=["id","content","arquivo", "likes", "dislikes"]
class CommentsPostagemSerializer(serializers.ModelSerializer):
    class Meta:
        model = CommentsPostagem
        fields=["id","user","postagem","text"]