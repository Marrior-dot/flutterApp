from django.urls import path
from . import consumers

websocket_urlpatterns = [
    path("ws/postagem/", consumers.PostagemConsumer.as_asgi()),
]
