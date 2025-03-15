from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from myapp.serializers import UserSerializer, PostagemSerializer, CommentsPostagemSerializer, RespostasSerializer, PersistenciaUserPostagemSerializer, PersistenciaUserRespostaSerializer
from myapp.models import User, Postagem, Commentarios, Respostas, PersistenciaUserPostagem, PersistenciaUserResposta
from minio import Minio
import re

#-----User------
@api_view(["GET"])
def usersOverview(req):
    """
    Visão geral das URLs da API relacionadas a usuários.

    GET:
        Retorna um dicionário contendo as URLs disponíveis para operações com usuários.
    """
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
    """
    Lista todos os usuários ou cria um novo usuário.

    GET:
        Retorna uma lista de todos os usuários.
        Serializador: UserSerializer

    POST:
        Cria um novo usuário.
        Serializador: UserSerializer
        Retorna os dados do novo usuário criado ou erros de validação.
    """
    if req.method == 'GET':
        # Busca todos os usuários no banco de dados
        users = User.objects.all()
        # Serializa os usuários usando o UserSerializer
        serializer = UserSerializer(users, many=True)
        # Retorna os dados serializados e o status HTTP 200 (OK)
        return Response(serializer.data)
    
    elif req.method == 'POST':
        # Serializa os dados do usuário no corpo da requisição
        serializer = UserSerializer(data=req.data)
        # Valida os dados serializados
        if serializer.is_valid():
            # Salva o usuário no banco de dados
            serializer.save()
            # Retorna os dados do novo usuário criado e o status HTTP 201 (Created)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        # Se os dados não forem válidos, retorna os erros de validação e o status HTTP 400 (Bad Request)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(["GET", "PATCH", "DELETE"])
def users_detail(req, pk=None, email=None):
    """
    Recupera, atualiza ou exclui um usuário específico.

    GET:
        Retorna os detalhes de um usuário específico, buscado por pk ou email.
        Serializador: UserSerializer

    PATCH:
        Atualiza parcialmente os dados de um usuário específico.
        Serializador: UserSerializer
        Retorna os dados do usuário atualizado ou erros de validação.

    DELETE:
        Exclui um usuário específico.
        Retorna uma mensagem de sucesso ou um erro.
    """
    if req.method == 'GET':
        # Se pk for fornecido
        if pk:
            # Busca o usuário pelo pk
            users = User.objects.filter(pk=pk).get()
        # Se email for fornecido
        elif email:
            # Busca o usuário pelo email
            users = User.objects.filter(email=email).get()            
        # Serializa o usuário usando o UserSerializer
        serializer = UserSerializer(users, many=False)
        # Retorna os dados serializados e o status HTTP 200 (OK)
        return Response(serializer.data)

    if req.method == 'PATCH':
        # Busca o usuário pelo pk
        user = User.objects.get(pk=pk)
        # Serializa os dados de usuário no corpo da requisição
        serializer = UserSerializer(instance=user, data=req.data, partial=True)
        # Valida os dados serializados
        if serializer.is_valid():
           # Salva o usuário no banco de dados
           serializer.save()
           # Retorna os dados do usuário atualizado e o status HTTP 200 (OK)
           return Response(serializer.data, status=status.HTTP_200_OK)
        # Se os dados não forem válidos, retorna os erros de validação e o status HTTP 400 (Bad Request)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    if req.method == 'DELETE':
        # Busca o usuário pelo pk
        user = User.objects.get(pk=pk)
        # Exclui o usuário do banco de dados
        user.delete()
        # Retorna uma mensagem de sucesso e o status HTTP 204 (No Content)
        return Response("Usuário excluído com sucesso!", status=status.HTTP_204_NO_CONTENT)
    
#-----Postagem------
@api_view(["GET","POST"])
def postagens_list(req):
    """
    Lista todas as postagens ou cria uma nova postagem.

    GET:
        Retorna uma lista de todas as postagens.
        Serializador: PostagemSerializer

    POST:
        Cria uma nova postagem.
        Serializador: PostagemSerializer
        Retorna os dados da nova postagem criada.
    """
    if req.method == 'GET':
        client = Minio("play.min.io", "yvuhnPGjd5Jj0UxDFQnw", "tewvjxadJ60v6PH7Mqg053RQ8Tg9yoE3WxSRH5wB")
     
        # Busca todas as postagens no banco de dados
        postagens = Postagem.objects.all()
        # Serializa as postagens usando o PostagemSerializer
        serializer = PostagemSerializer(postagens, many=True)
        # Retorna os dados serializados e o status HTTP 200 (OK)
        for postagem in serializer.data:
            if postagem["arquivo"] != None:
                postagem_sub =  re.sub(r'^/', '', postagem["arquivo"])
                postagem["arquivo"] = postagem_sub 
                # Get data of an object.
                #try:
                #    response = client.get_object("python-test-bucket", postagem_sub)
                #    postagem["arquivo"] = re.sub(r"^b||\'","",f'{response.data}')
                    
                    #print(postagem["arquivo"])
                    #response.close()
                    #response.release_conn()
                #/except:
                #    print("errpr")
                    #response.close()
                    #response.release_conn()
                    
        return Response(serializer.data, status=status.HTTP_200_OK)
    
    elif req.method == 'POST':
        # Serializa os dados da postagem no corpo da requisição
        serializer = PostagemSerializer(data=req.data)
        # Valida os dados serializados
        if serializer.is_valid():
            # Create a client with the MinIO server playground, its access key
    # and secret key.
            serializer.save()
        # Retorna os dados da nova postagem criada e o status HTTP 201 (Created)
        return Response(serializer.data, status=status.HTTP_201_CREATED)

@api_view(["GET", "PATCH", "DELETE"])
def postagens_detail(req, pk=None):
    """
    Recupera, atualiza ou exclui uma postagem específica.

    GET:
        Retorna os detalhes de uma postagem específica.
        Serializador: PostagemSerializer

    PATCH:
        Atualiza parciamente os dados de uma postagem específica.
        Serializador: PostagemSerializer
        Retorna os dados da postagem atualizada ou erros de validação.

    DELETE:
        Exclui uma postagem específica.
        Retorna uma mensagem de sucesso.
    """
    if req.method == 'GET':
        # Busca a postagem pelo pk
        postagens = Postagem.objects.filter(pk=pk).get()
        # Serializa a postagem usando o PostagemSerializer
        serializer = PostagemSerializer(postagens, many=False)
        # Retorna os dados serializados e o status HTTP 200 (OK)
        return Response(serializer.data, status=status.HTTP_200_OK)

    if req.method == 'PATCH':
        # Busca a postagem pelo id
        postagens = Postagem.objects.get(id=pk)
        # Serializa os dados da postagem no corpo da requisição, permitindo atualização parcial
        serializer = PostagemSerializer(instance=postagens, data=req.data, partial = True)
        # Valida os dados serializados
        if serializer.is_valid():
            # Salva a postagem no banco de dados
            serializer.save()
            # Retorna os dados da postagem atualizada e o status HTTP 200 (OK)
            return Response(serializer.data,status=status.HTTP_200_OK)
        # Se os dados não forem válidos, retorna os erros de validação e o status HTTP 400 (Bad Request)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


    if req.method == 'DELETE':
        # Busca a postagem pelo id
        postagens = Postagem.objects.get(id=pk)
        # Exclui a postagem do banco de dados
        postagens.delete()
        # Retorna uma mensagem de sucesso e o status HTTP 204 (No Content)
        return Response("Postagem excluída com sucesso!", status=status.HTTP_204_NO_CONTENT)

#-----Comentários------
@api_view(["POST"])
def comentarios_list(req):
    """
    Cria um novo comentário.

    POST:
        Cria um novo comentário associado a uma postagem.
        Serializador: CommentsPostagemSerializer
        Retorna os dados do novo comentário criado ou erros de validação.
    """
    # Serializa os dados do comentário no corpo da requisição
    serializerComments = CommentsPostagemSerializer(data=req.data)
    # Busca a postagem relacionada ao comentário
    postagem = Postagem.objects.filter(pk=req.data.get("postagem")["id"]).get()
    # Valida os dados serializados
    if serializerComments.is_valid():
        # Salva o comentário no banco de dados, associando-o à postagem
        serializerComments.save(postagem=postagem)
        # Retorna os dados do novo comentário criado e o status HTTP 201 (Created)
        return Response(serializerComments.data, status=status.HTTP_201_CREATED)
    # Se os dados não forem válidos, retorna os erros de validação e o status HTTP 400 (Bad Request)
    return Response(serializerComments, status=status.HTTP_400_BAD_REQUEST)

@api_view(["GET"])
def comentarios_detail(req, pk=None):
    """
    Lista os comentários de uma postagem específica.

    GET:
        Retorna uma lista de comentários associados a uma postagem.
        Serializador: CommentsPostagemSerializer
    """
    # Busca a postagem pelo pk
    postagem = Postagem.objects.get(pk=pk)
    # Busca os comentários associados à postagem
    comments = Commentarios.objects.filter(postagem=postagem)
    # Serializa os comentários usando o CommentsPostagemSerializer
    serializer = CommentsPostagemSerializer(comments, many=True)
    # Retorna os dados serializados e o status HTTP 200 (OK)
    return Response(serializer.data, status=status.HTTP_200_OK)

#-----Respostas------
@api_view(["GET"])
def respostas_list(req, postagem):
    """
    Lista as respostas de uma postagem específica.

    GET:
        Retorna uma lista de respostas associadas a uma postagem.
        Serializador: RespostasSerializer
        Retorna uma lista vazia se não houver respostas.
    """
    # Busca as respostas associadas à postagem
    respostas = Respostas.objects.filter(postagem=postagem)
    # Serializa as respostas usando o RespostasSerializer
    serializer = RespostasSerializer(respostas, many=True)
    # Se houver respostas
    if serializer.data != []:
        # Retorna os dados serializados e o status HTTP 200 (OK)
        return Response(serializer.data, status=status.HTTP_200_OK)
    # Se não houver respostas, retorna uma lista vazia e o status HTTP 404 (Not Found)
    return Response([], status=status.HTTP_404_NOT_FOUND)


@api_view(["PATCH"])
def respostas_detail(req,postagem,respostaTexto):
    """
    Atualiza o contador de respostas de uma resposta específica.

    PATCH:
        Incrementa o contador 'respondido' de uma resposta específica.
        Serializador: RespostasSerializer
        Retorna os dados da resposta atualizada ou erros de validação.
    """
    # Busca a resposta pelo texto e postagem
    tryResposta = Respostas.objects.filter(respostaTexto=respostaTexto, postagem=postagem).get()
    resposta = tryResposta
    # Incrementa o contador 'respondido'
    req.data["respondido"] = resposta.respondido + 1
    # Serializa os dados da resposta, permitindo atualização parcial
    serializer = RespostasSerializer(instance=resposta, data=req.data, partial= True)
    # Valida os dados serializados
    if serializer.is_valid():
        # Salva a resposta no banco de dados
        serializer.save()
        # Retorna os dados da resposta atualizada e o status HTTP 200 (OK)
        return Response(serializer.data)
    # Se os dados não forem válidos, retorna os erros de validação e
#-----Persistência Usuário Postagem------
@api_view(["GET","POST"])
def persistencia_usuario_postagem_detail(req, user, postagem):
    """
    Gerencia a persistência da interação do usuário com a postagem.

    GET:
        Retorna os dados de persistência para um usuário e postagem específicos.
        Serializador: PersistenciaUserPostagemSerializer
        Retorna 204 se não houver dados de persistência.

    POST:
        Cria um novo registro de persistência.
        Serializador: PersistenciaUserPostagemSerializer
        Retorna os dados do novo registro ou erros de validação.
    """
    if req.method == 'GET':
        # Tenta buscar a persistência pelo usuário e postagem
        try:
            persistencia = PersistenciaUserPostagem.objects.filter(user=user, postagem=postagem)
            # Serializa a persistência usando o PersistenciaUserPostagemSerializer
            serializer = PersistenciaUserPostagemSerializer(persistencia, many=True)
            # Retorna os dados serializados e o status HTTP 200 (OK)
            return Response(serializer.data, status=status.HTTP_200_OK)
        # Se a persistência não existir
        except PersistenciaUserPostagem.DoesNotExist:
            # Retorna o status HTTP 204 (No Content)
            return Response(status=status.HTTP_204_NO_CONTENT)  
    
    if req.method == 'POST':
        # Serializa os dados da persistência no corpo da requisição
        serializer = PersistenciaUserPostagemSerializer(data=req.data)
        # Valida os dados serializados
        if serializer.is_valid():
            # Salva a persistência no banco de dados
            serializer.save()
            # Retorna os dados da nova persistência criada e o status HTTP 201 (Created)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        # Se os dados não forem válidos, retorna os erros de validação e o status HTTP 400 (Bad Request)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        
#-----Persistência Usuário Resposta------
@api_view(["GET","POST"])
def persistencia_usuario_resposta_detail(req, user, postagem):
    """
    Gerencia a persistência da interação do usuário com a resposta.

    GET:
        Verifica se existe um registro de persistência para um usuário e postagem específicos.
        Retorna 200 se existir e 204 se não existir.

    POST:
        Cria um novo registro de persistência.
        Serializador: PersistenciaUserRespostaSerializer
        Retorna os dados do novo registro ou erros de validação.
    """
    if req.method == 'GET':
        # Tenta buscar a persistência pelo usuário e postagem
        try:
            persistencia = PersistenciaUserResposta.objects.get(user=user, postagem=postagem)
            # Se a persistência existir, retorna o status HTTP 200 (OK)
            return Response(status=status.HTTP_200_OK)
        # Se a persistência não existir
        except PersistenciaUserResposta.DoesNotExist:
            # Retorna o status HTTP 204 (No Content)
            return Response(status=status.HTTP_204_NO_CONTENT)  
   
    if req.method == 'POST':
        # Serializa os dados da persistência no corpo da requisição
        serializer = PersistenciaUserRespostaSerializer(data=req.data)
        # Valida os dados serializados
        if serializer.is_valid():
            # Salva a persistência no banco de dados
            serializer.save()
            # Retorna os dados da nova persistência criada e o status HTTP 201 (Created)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        # Se os dados não forem válidos, retorna os erros de validação e o status HTTP 400 (Bad Request)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)