from django.urls import path
from .views.api import * 

urlpatterns = [path("", usersOverview, name="api-overview"),
    path("userlist/", userList, name="api-list"),
    path("userdetail/<str:pk>/", userDetail, name="api-detail"),
    path("usercreate/", userCreate, name="api-create"),
    path("userupdate/<str:pk>/", userUpdate, name="api-update"),
    path("userdelete/<str:pk>/", userDelete, name="api-delete")]