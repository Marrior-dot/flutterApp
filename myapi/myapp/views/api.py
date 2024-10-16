from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
import re
from myapp.serializers import UserSerializer, PostagemSerializer, CommentsPostagemSerializer, RespostasSerializer 
from myapp.models import User, Postagem, Commentarios, Respostas

#-----User------
@api_view(["GET"])
def usersOverview(req):
    api_urls = {
        "User":"/userlist/",
        "Detail":"/userdetail/<str:pk>",
        "Create":"/usercreate/",
        "Update":"userupdate/<str:pk>",
        "Delete":"/userdelete/<str:pk>"
    }
    return Response(api_urls)

@api_view(["GET", "POST"])
def users_list(req):
    if req.method == 'GET':
        users = User.objects.all()
        serializer = UserSerializer(users, many=True)
        return Response(serializer.data)
    
    #Post, criação de usuário
    elif req.method == 'POST':
        serializer = UserSerializer(data=req.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(["GET", "PATCH", "DELETE"])
def users_detail(req, pk=None, email=None):
    #Login de usuário e checagem se o usuário existe ou não
    if req.method == 'GET':
        if pk:
            users = User.objects.filter(pk=pk).get()
        elif email:
            users = User.objects.filter(email=email).get()            
        serializer = UserSerializer(users, many=False)
        return Response(serializer.data)

    #Usuário poderá fazer alguma alteração nas suas próprias configurações
    if req.method == 'PATCH':
        user = User.objects.get(id=pk)
        serializer = UserSerializer(instance=user, data=req.data)
        if serializer.is_valid():
           serializer.save()
           return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    #Deletar usuário
    if req.method == 'DELETE':
        user = User.objects.get(id=pk)
        user.delete()
        return Response("Item successfully deleted!", status=status.HTTP_204_NO_CONTENT)

@api_view(["GET","POST"])
def postagens_list(req):
    if req.method == 'GET':
        postagens = Postagem.objects.all()
        serializer = PostagemSerializer(postagens, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)
    
    elif req.method == 'POST':
        serializer = PostagemSerializer(data=req.data)
        if serializer.is_valid():
            serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)

@api_view(["GET", "PATCH", "DELETE"])
def postagens_detail(req, pk=None):
    if req.method == 'GET':
        postagens = Postagem.objects.filter(pk=pk).get()
        serializer = PostagemSerializer(postagens, many=False)
        return Response(serializer.data, status=status.HTTP_200_OK)
    if req.method == 'PATCH':
        postagens = Postagem.objects.get(id=pk)
        serializer = PostagemSerializer(instance=postagens, data=req.data, partial = True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data,status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    if req.method == 'DELETE':
        postagens = Postagem.objects.get(id=pk)
        postagens.delete()
        return Response("Item successfully deleted!", status=status.HTTP_204_NO_CONTENT)
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

#@api_view(["GET"])
#def postagensList(req):
#    post = Postagem.objects.all()
#    serializer = PostagemSerializer(post, many=True)
#    return Response(serializer.data)
#
#@api_view(["GET"])
#def postagensDetail(req, pk):
#    post = Postagem.objects.get(id=pk)
#    serializer = PostagemSerializer(post, many=False)
#    return Response(serializer.data)
#
#@api_view(["POST"])
#def postagensCreate(req):
#    serializer = PostagemSerializer(data=req.data)
#
#    if serializer.is_valid():
#        serializer.save()
#
#    return Response(serializer.data)
#
#@api_view(["PATCH"])
#def postagensUpdate(req, pk, likesOrDislikes):
#    post = Postagem.objects.get(id=pk)
#    post.__dict__[f"{likesOrDislikes}"] += 1
#    serializer = PostagemSerializer(instance=post, data=req.data, partial = True)
#    if serializer.is_valid():
#        serializer.save()
#        return Response(serializer.data)
#    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
#
#@api_view(["DELETE"])
#def postagensDelete(req, pk):
#    post = Postagem.objects.get(id=pk)
#    post.delete()
#    return Response("Item successfully deleted!")
#-----Postagem------

#-----Comentários------

@api_view(["POST"])
def comentarios_list(req):
    serializerComments = CommentsPostagemSerializer(data=req.data)
    postagem = Postagem.objects.filter(pk=req.data.get("postagem")["id"]).get()
    if serializerComments.is_valid(): 
        serializerComments.save(postagem=postagem)
        return Response(serializerComments.data, status=status.HTTP_201_CREATED)
    return Response(serializerComments, status=status.HTTP_400_BAD_REQUEST)

@api_view(["GET"])
def comentarios_detail(req, pk=None):
    postagem = Postagem.objects.get(pk=pk)
    comments = Commentarios.objects.filter(postagem=postagem)
    serializer = CommentsPostagemSerializer(comments, many=True)
    return Response(serializer.data, status=status.HTTP_200_OK)


@api_view(["GET"])
def comentariosList(req):
    comments = Commentarios.objects.all()
    serializer = CommentsPostagemSerializer(comments, many=True)
    return Response(serializer.data)

@api_view(["GET"])
def comentariosListPostagem(req, pk):
    postagem = Postagem.objects.get(pk=pk)
    comments = Commentarios.objects.filter(postagem=postagem)
    serializer = CommentsPostagemSerializer(comments, many=True)
    return Response(serializer.data, status=status.HTTP_200_OK)

@api_view(["GET"])
def respostas_list(req, postagem):
        respostas = Respostas.objects.filter(postagem=postagem)
        serializer = RespostasSerializer(respostas, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

@api_view(["PATCH"])
def respostas_detail(req, postagem, pk):
    resposta = Respostas.objects.filter(pk=pk).get()
    req.data["respondido"] = resposta.respondido + 1
    serializer = RespostasSerializer(instance=resposta, data=req.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(["PUT"])
def respostasUpdate(req, respostaTexto):
    ans = Respostas.objects.filter(respostaTexto=respostaTexto).get()
    req.data["respondido"] = ans.respondido + 1
    serializer = RespostasSerializer(instance=ans, data=req.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)