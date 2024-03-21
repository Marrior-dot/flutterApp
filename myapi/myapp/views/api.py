from rest_framework.decorators import api_view
from rest_framework.response import Response
from myapp.serializers import UserSerializer 

from myapp.models import User

@api_view(["GET"])
def usersOverview(req):
    api_urls = {
        "User":"/user_list/",
        "Detail":"/user_detail",
        "Create":"/user_create",
        "Update":"user_update/<str:pk>",
        "Delete":"/user_delete/<str:pk>"
    }
    return Response(api_urls)

@api_view(["GET"])
def userList(req):
    users = User.objects.all()
    serializer = UserSerializer(users, many=True)
    return Response(serializer.data)

@api_view(["GET"])
def userDetail(req, pk):
    users = User.objects.get(id=pk)
    serializer = UserSerializer(users, many=False)
    return Response(serializer.data)

@api_view(["POST"])
def userCreate(req):
    serializer = UserSerializer(data=req.data)

    if serializer.is_valid():
        serializer.save()

    return Response(serializer.data)

@api_view(["PATCH"])
def userUpdate(req, pk):
    user = User.objects.get(id=pk)
    serializer = UserSerializer(instance=user, data=req.data)

    if serializer.is_valid():
        serializer.save()

    return Response(serializer.data)

@api_view(["DELETE"])
def userDelete(req, pk):
    user = User.objects.get(id=pk)
    user.delete()

    return Response("Item successfully deleted!")