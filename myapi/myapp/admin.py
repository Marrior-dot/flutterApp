from django.contrib import admin
from .models import User, Postagem, CommentsPostagem, Respostas

# Register your models here.

class CommentsPostagemAdmin(admin.StackedInline):
    list_display = ('username', 'postagem', 'text')
    model = CommentsPostagem
    pass

admin.site.register(User)
@admin.register(Postagem)
class PostagemRespostas(admin.ModelAdmin):
    inlines = [CommentsPostagemAdmin]
    pass
