from django.urls import path, re_path
from .views.api import * 

urlpatterns = [path("userHowTo/", usersOverview, name="users-overview"),
    #CRUD usuário
    path("users/", users_list, name="users-list"),
    re_path(r'^users/((?P<pk>\w+)||(?P<email>[\w.%+-]+@[A-Za-z0-9.-]+))/', users_detail, name="users-detail"),

    #CRUD Postagem
    path("postagens/", postagens_list, name="postagens-list"),
    path("postagens/<int:pk>/", postagens_detail, name="postagens-detail"),
    path("postagens_persistencia/<str:user>/<int:postagem>/", persistencia_usuario_postagem_detail, name="postagens-persistencia"),

    #CRUD Comentário
    path("comentarios/", comentarios_list, name="coment-overview"),
    path("comentarios/<int:pk>/", comentarios_detail, name="coment-list-postagem"),

    #CRUD Resposta
    path("respostas/<int:postagem>/", respostas_list, name="resposta-list"),
    path("respostas/<int:postagem>/<str:respostaTexto>/", respostas_detail, name="resposta-update"),
    path("respostas_persistencia/<str:user>/<int:postagem>/", persistencia_usuario_resposta_detail, name="respostas-persistencia"),
    ]