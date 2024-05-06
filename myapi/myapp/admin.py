from django.contrib import admin
from .models import User, Postagem, CommentsPostagem
#from .models import Postagem 
#from django.contrib.auth.models import User

# Register your models here.
admin.site.register(User)
admin.site.register(Postagem)
admin.site.register(CommentsPostagem)
#admin.site.register(newUSer)
