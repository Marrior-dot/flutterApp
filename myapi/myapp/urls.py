from django.urls import path, re_path
from .views.api import * 
from .views.views import *

urlpatterns = [path("userHowTo/", usersOverview, name="users-overview"),
    path("userlist/", userList, name="users-list"),
    re_path(r"^userdetail/((?P<pk>\w+)||(?P<email>[\w.%+-]+@[A-Za-z0-9.-]+))/$", userDetail, name="users-detail"),
    re_path(r'^userexists/((?P<pk>\w+)||(?P<email>[\w.%+-]+@[A-Za-z0-9.-]+)||(?P<name>\w+))/', userExists, name="users-detail"),
    path("usercreate/", userCreate, name="users-create"),
    path("userupdate/<int:pk>/", userUpdate, name="users-update"),
    path("userdelete/<int:pk>/", userDelete, name="users-delete"),
    path("postagemHowTo", postagensOverview, name="post-overview"),
    path("postagemlist/", postagensList, name="post-list"),
    path("postagemdetail/<int:pk>/", postagensDetail, name="post-detail"),
    path("postagemcreate/", postagensCreate, name="post-create"),
    #path("postagemupdate/<int:pk>/", postagensUpdate, name="post-update"),
    re_path(r"^likeDislikeUpdate/(?P<pk>[0-9]+)/(?P<likesOrDislikes>\w+)/", postagensUpdate, name="post-update"),
    path("postagemdelete/<int:pk>/", postagensDelete, name="post-delete"),
    path("comentariolist/<int:pk>/", comentariosListPostagem, name="coment-list-postagem"),
    path("comentariolist/", comentariosList, name="comment-list"),
    path("comentariocreate/", comentariosPosts, name="comment-create"),
    path("respostasupdate/<str:respostaTexto>/", respostasUpdate, name="resposta-update"),
    ]