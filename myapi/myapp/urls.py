from django.urls import path
from .views.api import * 

urlpatterns = [path("userHowTo", usersOverview, name="users-overview"),
    path("userlist/", userList, name="users-list"),
    path("userdetail/<str:pk>/", userDetail, name="users-detail"),
    path("usercreate/", userCreate, name="users-create"),
    path("userupdate/<str:pk>/", userUpdate, name="users-update"),
    path("userdelete/<str:pk>/", userDelete, name="users-delete"),
    path("postagemHowTo", postagensOverview, name="post-overview"),
    path("postagemlist/", postagensList, name="post-list"),
    path("postagemdetail/<str:pk>/", postagensDetail, name="post-detail"),
    path("postagemcreate/", postagensCreate, name="post-create"),
    path("postagemupdate/<int:pk>/", postagensUpdate, name="post-update"),
    path("postagemdelete/<str:pk>/", postagensDelete, name="post-delete"),]