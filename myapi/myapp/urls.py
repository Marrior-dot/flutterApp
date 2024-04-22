from django.urls import path
from .views.api import * 
from .views.views import *

urlpatterns = [path("userHowTo/", usersOverview, name="users-overview"),
    path("userlist/", userList, name="users-list"),
    path("userdetail/<str:pk>/", userDetail, name="users-detail"),
    path("usercreate/", userCreate, name="users-create"),
    path("userupdate/<int:pk>/", userUpdate, name="users-update"),
    path("userdelete/<int:pk>/", userDelete, name="users-delete"),
    path("postagemHowTo", postagensOverview, name="post-overview"),
    path("postagemlist/", postagensList, name="post-list"),
    path("postagemdetail/<int:pk>/", postagensDetail, name="post-detail"),
    path("postagemcreate/", postagensCreate, name="post-create"),
    path("postagemupdate/<int:pk>/", postagensUpdate, name="post-update"),
    path("postagemdelete/<int:pk>/", postagensDelete, name="post-delete"),
    path("comentariolist/", comentariosList, name="comment-list"),
    path("comentariocreate/<int:pk>", comentariosPosts, name="comment-create"),
    path("test_websocket/", index, name="websocket_teste")]