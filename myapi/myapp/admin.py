from django.contrib import admin
from .models import User, Postagem, Commentarios, Respostas

# Registra os modelos no painel de administração do Django.

class CommentsPostagemAdmin(admin.StackedInline):
    """
    Representação em linha dos comentários de uma postagem.
    Permite editar comentários diretamente na página de administração da postagem.
    Exibe o nome de usuário, a postagem e o texto do comentário.
    """
    list_display = ('username', 'postagem', 'text')
    model = Commentarios


class RespostasAdmin(admin.StackedInline):
    """
    Representação em linha das respostas de uma postagem.
    Permite editar respostas diretamente na página de administração da postagem.
    Exibe o texto da resposta, o número de vezes que foi respondida e a postagem.
    """
    list_display = ('respostaTexto', 'respondido','postagem')
    model = Respostas


admin.site.register(User) # Registra o modelo de Usuário para administração direta.


@admin.register(Postagem)
class PostagemRespostas(admin.ModelAdmin):
    """
    Representação da postagem no painel de administração.
    Inclui representações em linha para comentários e respostas.
    """
    inlines = [CommentsPostagemAdmin, RespostasAdmin]