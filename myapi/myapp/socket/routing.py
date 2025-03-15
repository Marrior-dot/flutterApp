from django.urls import path
from . import consumers

#Urls do websocket
websocket_urlpatterns = [
    #URL do websocket para enviar as postagens assim que houver uma atualização no banco
    path("ws/postagem/", consumers.PostagemConsumer.as_asgi()),
]
