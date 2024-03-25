from rest_framework.decorators import api_view
from rest_framework.response import Response
from myapp.serializers import UserSerializer, PostagemSerializer 

from myapp.models import User, Postagem

#-----User------
@api_view(["GET"])
def usersOverview(req):
    api_urls = {
        "User":"/userlist/",
        "Detail":"/userdetail",
        "Create":"/usercreate",
        "Update":"userupdate/<str:pk>",
        "Delete":"/userdelete/<str:pk>"
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
#-----User------

#-----Postagem------
@api_view(["GET"])
def postagensOverview(req):
    api_urls = {
        "Postagem":"/postagemlist/",
        "PostagemDetail":"/postagemdetail",
        "PostagemCreate":"/postagemcreate",
        "PostagemUpdate":"postagemupdate/<str:pk>",
        "PostagemDelete":"/postagemdelete/<str:pk>"
    }
    return Response(api_urls)

@api_view(["GET"])
def postagensList(req):
    post = Postagem.objects.all()
    serializer = PostagemSerializer(post, many=True)
    #print(Response(serializer.data[0]))
    return Response(serializer.data)
    #return serializer.data

@api_view(["GET"])
def postagensDetail(req, pk):
    post = Postagem.objects.get(id=pk)
    serializer = PostagemSerializer(post, many=False)
    return Response(serializer.data)

@api_view(["POST"])
def postagensCreate(req):
    serializer = PostagemSerializer(data=req.data)

    if serializer.is_valid():
        serializer.save()

    return Response(serializer.data)

@api_view(["PATCH"])
def postagensUpdate(req, pk):
    post = Postagem.objects.get(id=pk)
    serializer = PostagemSerializer(instance=post, data=req.data)

    if serializer.is_valid():
        serializer.save()

    return Response(serializer.data)

@api_view(["DELETE"])
def postagensDelete(req, pk):
    post = Postagem.objects.get(id=pk)
    post.delete()
    return Response("Item successfully deleted!")
#-----Postagem------