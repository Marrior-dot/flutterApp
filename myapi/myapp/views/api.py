from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from myapp.serializers import UserSerializer, PostagemSerializer, CommentsPostagemSerializer 
from django.db.utils import IntegrityError
from myapp.models import User, Postagem, CommentsPostagem

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

@api_view(["GET"])
def userList(req):
    users = User.objects.all()
    serializer = UserSerializer(users, many=True)
    return Response(serializer.data)

@api_view(["GET"])
def userDetail(req, pk):
    #users = User.objects.get()
    users = User.objects.filter(pk=pk).get()
    #print(users)
    serializer = UserSerializer(users)#(users, many=False)
    print(serializer)
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
    return Response(serializer.data)

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

@api_view(["PUT"])
def postagensUpdate(req, pk):
    post = Postagem.objects.get(id=pk)
    serializer = PostagemSerializer(instance=post, data=req.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(["DELETE"])
def postagensDelete(req, pk):
    post = Postagem.objects.get(id=pk)
    post.delete()
    return Response("Item successfully deleted!")
#-----Postagem------

#-----Comentários------
@api_view(["POST"])
def comentariosPosts(req):
    serializerComments = CommentsPostagemSerializer(data=req.data)
    serializerPostagem = PostagemSerializer(data=req.data)
    serializerUser = UserSerializer(data=req.data)
    if serializerComments.is_valid() and serializerPostagem.is_valid() and serializerUser.is_valid():
        postagem = serializerPostagem.save()
        user = serializerUser.save()
        try:
            serializerComments.save(user=user,postagem=postagem)
            return Response(serializerComments.data, 201)
        except IntegrityError as e:
            print(e)
        #comment_data = {'postagem': req.data.get('postagem').id, ''}

    #if serializerUser.is_valid() == True and serializerPostagem.is_valid() == True:
    #    serializerPostagem.save()
    #    serializerUser.save()
    #    user_instance = serializerUser.save()
    #    postagem_instance = serializerPostagem.save()
#
    #    comment_data = {'user':user_instance, 'postagem': postagem_instance.id, 'text': req.data.get('text')}
    #    commentSerializer = CommentsPostagemSerializer(data=comment_data)
#
    #    if commentSerializer.is_valid():
    #        commentSerializer.save()
    #        return Response(commentSerializer.data, status.HTTP_201_CREATED)
    #    else:
    #        user_instance.delete()
    #        postagem_instance.delete()
    #        return Response(commentSerializer.errors, status=400)
    else:
        return Response("Dados não foram salvos: ", status=400)


    #except IntegrityError as e:
    #    print('erro: {}'.format(e))
    #return Response(serializer.errors,status=status.HTTP_400_BAD_REQUEST)

@api_view(["GET"])
def comentariosList(req):
    comments = CommentsPostagem.objects.all()
    serializer = CommentsPostagemSerializer(comments, many=True)
    return Response(serializer.data)

@api_view(["GET"])
def comentariosListPostagem(req,*args):
    comments = CommentsPostagem.objects.filter(postagem=args)
    serializer = CommentsPostagemSerializer(comments, many=True)
    return Response(serializer.data)