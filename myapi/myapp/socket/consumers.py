import json
from channels.generic.websocket import WebsocketConsumer
from channels.generic.websocket import JsonWebsocketConsumer
from myapp.serializers import PostagemSerializer
from myapp.models import Postagem

class ChatConsumer(WebsocketConsumer):
    def connect(self):
        self.accept()

    def disconnect(self, close_code):
        pass

    def receive(self,text_data):
        text_data_json = json.loads(text_data)
        postagem = Postagem.objects.all()
        serializer = PostagemSerializer(postagem, many=True)
        message = serializer.data #text_data_json["message"]
        #message = text_data_json["message"]
        self.send(text_data=json.dumps({"message": "ola"}))

class PostagemConsumer(JsonWebsocketConsumer):
    def connect(self):
        self.accept()
        

    def disconnect(self, close_code):
        pass

    def receive_json(self,content=Postagem.objects.all()):
        contentSerialized = PostagemSerializer(content, many=True)
        self.send_json(content=contentSerialized)