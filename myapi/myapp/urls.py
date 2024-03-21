from django.urls import path
from .views.api import * 

urlpatterns = [path("userHowTo", usersOverview, name="api-overview"),
    path("userlist/", userList, name="api-list"),
    path("userdetail/<str:pk>/", userDetail, name="api-detail"),
    path("usercreate/", userCreate, name="api-create"),
    path("userupdate/<str:pk>/", userUpdate, name="api-update"),
    path("userdelete/<str:pk>/", userDelete, name="api-delete"),
    path("postagemHowTo", postagensOverview, name="api-overview"),
    path("postagemlist/", postagensList, name="api-list"),
    path("postagemdetail/<str:pk>/", postagensDetail, name="api-detail"),
    path("postagemcreate/", postagensCreate, name="api-create"),
    path("postagemupdate/<str:pk>/", postagensUpdate, name="api-update"),
    path("postagemdelete/<str:pk>/", postagensDelete, name="api-delete"),]