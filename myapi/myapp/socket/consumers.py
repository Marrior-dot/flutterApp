import json
from channels.db import database_sync_to_async
from channels.generic.websocket import AsyncWebsocketConsumer
from django.db.models.signals import post_save
from channels.layers import get_channel_layer
from myapp.models import Postagem
from myapp.serializers import PostagemSerializer

#Consumer que envia as postagens para o websocket assim que houver uma atualização no banco
#Atualiza somente quando existe alguma postagem nova
class PostagemConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        #Nome do grupo do websocket
        self.group_name = 'postagem_updates'
        #Canal por onde as mensagens devem passar  
        await self.channel_layer.group_add(self.group_name, self.channel_name)
        #Aceita a conexão com o cliente
        await self.accept()

    async def disconnect(self, close_code):
        # Remove o canal do grupo quando a conexão é encerrada
        await self.channel_layer.group_discard(self.group_name, self.channel_name)

    async def receive(self, text_data):
        #Recebe a mensagem do cliente, e decodifica o json
        text_data_json = json.loads(text_data)
        #Obtém a mensagem do cliente a partir do atributo 'message'
        message = text_data_json['message']
        #Se a mensagem for 'get_postagens', obtém todas as postagens e envia para o cliente
        if message == 'get_postagens':
            postagens = await self.get_all_postagens()
            serializer = await self.get_data_to_serialize(postagens)
            message = await self.get_json_dump(serializer)
            await self.send(text_data=message)

    #Método de classe que é executado no websocket
    #É executado toda vez que ocorre uma atualização no banco
    #Notifica o websocket que existe uma atualização nova
    @classmethod
    async def notify_postagem_update (self, sender, instance, created, **kwargs):
        #Se um postagem postagem for criado, notifica o websocket
        if created:    
            #Serializa a postagem
            serializer = PostagemSerializer(instance).data
            #transforma em json
            data = json.dumps(serializer)
            #Manda a mensagem para o websocket
            #Utiliza a função 'postagem_updates' para tratar a mensagem ao ser enviada
            try:
                await get_channel_layer().group_send('postagem_updates',{'type':'postagem_updates',"message":data})
            except ValueError as e:            
                print(e)

    #Método que é executado quando o servidor envia uma mensagem para o websocket
    async def postagem_updates(self, event):
            message = event["message"]
            await self.send(text_data=message) 

    #Método que obtém todas as postagens do banco
    #Função sincrona feita de maneira assíncrona
    @database_sync_to_async 
    def get_all_postagens(self):
        return Postagem.objects.all().order_by('-id')
    
    #Método que serializa as postagens passadas como parâmetro
    #Função sincrona feita de maneira assíncrona
    @database_sync_to_async
    def get_data_to_serialize(self, postagens):
        return PostagemSerializer(postagens, many=True).data
    
    #Método que transforma uma lista de dados serializados em json
    #Função sincrona feita de maneira assíncrona
    @database_sync_to_async
    def get_json_dump(self, serialized_data):
        return json.dumps(serialized_data)

#Gatilho para a atualização de postagens
#Executa a função notify_postagem_update toda vez que há uma atualização no banco
#Identifica o model Postagem como responsável pela atualização
post_save.connect(PostagemConsumer.notify_postagem_update, sender=Postagem)

#Método utilizado no browser para se conectar ao websocket e receber as postagens
'''
const socket = new WebSocket('ws://localhost:8000/ws/postagem/'); // Replace with your WebSocket endpoint

socket.onopen = function(event) {
  console.log('Connected to WebSocket server');
  socket.send(JSON.stringify({'message': 'get_postagens'}));
};

socket.onmessage = function(event) {
  const data = JSON.parse(event.data);
  console.log('Received data:', data);
};

socket.onclose = function(event) {
  console.log('WebSocket connection closed');
};
'''