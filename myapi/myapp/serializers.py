from rest_framework import serializers
from .models import User, Postagem, Commentarios, Respostas, PersistenciaUserPostagem, PersistenciaUserResposta

class UserSerializer(serializers.ModelSerializer):
    """
    Serializador para o modelo User.

    Meta:
        model: O modelo ao qual este serializador está vinculado (User).
        fields: Os campos do modelo que serão incluídos na serialização ('name', 'password', 'email', 'username').
    """
    class Meta:
        model=User
        fields=["name","password","email","username"]

class PostagemSerializer(serializers.ModelSerializer):
    """
    Serializador para o modelo Postagem.

    Meta:
        model: O modelo ao qual este serializador está vinculado (Postagem).
        fields: Os campos do modelo que serão incluídos na serialização ('id', 'content', 'title', 'arquivo', 'likes', 'dislikes', 'escolha_unica').
    """
    class Meta:
        model=Postagem
        fields=["id","content","title","arquivo","likes","dislikes","escolha_unica"]

class RespostasSerializer(serializers.ModelSerializer):
    """
    Serializador para o modelo Respostas.

    Meta:
        model: O modelo ao qual este serializador está vinculado (Respostas).
        fields: Os campos do modelo que serão incluídos na serialização ('respostaTexto', 'respondido', 'postagem').
    """
    class Meta:
        model = Respostas
        fields = ["respostaTexto", "respondido","postagem"]
        
class PersistenciaUserPostagemSerializer(serializers.ModelSerializer):
    """
    Serializador para o modelo PersistenciaUserPostagem.

    Meta:
        model: O modelo ao qual este serializador está vinculado (PersistenciaUserPostagem).
        fields: Os campos do modelo que serão incluídos na serialização ('user', 'postagem', 'tipoBotao', 'habilitado').
    """
    class Meta:
        model = PersistenciaUserPostagem
        fields = ["user","postagem","tipoBotao","habilitado"]

class PersistenciaUserRespostaSerializer(serializers.ModelSerializer):
    """
    Serializador para o modelo PersistenciaUserResposta.

    Meta:
        model: O modelo ao qual este serializador está vinculado (PersistenciaUserResposta).
        fields: Os campos do modelo que serão incluídos na serialização ('user', 'postagem').
    """
    class Meta:
        model = PersistenciaUserResposta
        fields = ["user","postagem"]

class CommentsPostagemSerializer(serializers.ModelSerializer):
    """
    Serializador para o modelo Commentarios.

    Meta:
        model: O modelo ao qual este serializador está vinculado (Commentarios).
        fields: Os campos do modelo que serão incluídos na serialização ('username', 'postagem', 'text').
    """
    postagem = PostagemSerializer(read_only=True)
    class Meta:
        model=Commentarios
        fields=["username","postagem","text"]