from django.contrib import admin
from .models import User, Postagem, Commentarios, Respostas

# Register your models here.

class CommentsPostagemAdmin(admin.StackedInline):
    list_display = ('username', 'postagem', 'text')
    model = Commentarios
    pass

class RespostasAdmin(admin.StackedInline):
    list_display = ('respostaTexto', 'respondido','postagem')
    model = Respostas
    pass

admin.site.register(User)
@admin.register(Postagem)
class PostagemRespostas(admin.ModelAdmin):
    inlines = [CommentsPostagemAdmin, RespostasAdmin]
    pass
