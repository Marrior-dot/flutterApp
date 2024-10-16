from django.urls import path, re_path
from .views.api import * 
from .views.views import *

urlpatterns = [path("userHowTo/", usersOverview, name="users-overview"),
    path("users/", users_list, name="users-list"),
    re_path(r'^users/((?P<pk>\w+)||(?P<email>[\w.%+-]+@[A-Za-z0-9.-]+))/', users_detail, name="users-detail"),
    path("postagens/", postagens_list, name="postagens-list"),
    path("postagens/<int:pk>/", postagens_detail, name="postagens-detail"),
    path("comentarios/", comentarios_list, name="coment-overview"),
    path("comentarios/<int:pk>/", comentarios_detail, name="coment-list-postagem"),
    #path("comentariolist/", comentariosList, name="comment-list"),
    #path("comentariocreate/", comentariosPosts, name="comment-create"),
    path("respostas/<int:postagem>/", respostas_list, name="resposta-list"),
    path("respostas/<int:postagem>/<int:pk>/", respostas_detail, name="resposta-update"),
    ]