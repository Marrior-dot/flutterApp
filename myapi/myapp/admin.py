from django.contrib import admin
from .models import User, Postagem, CommentsPostagem, Respostas

# Register your models here.
admin.site.register(User)
#admin.site.register(Postagem)
@admin.register(Postagem, Respostas)
class PostagemRespostas(admin.ModelAdmin):
    
    #Respostas.clean()
    pass
admin.site.register(CommentsPostagem)
#admin.site.register(newUSer)
