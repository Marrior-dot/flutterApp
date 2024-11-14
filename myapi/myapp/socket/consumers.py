#ws://localhost:8000/ws/postagem/
import json
from channels.db import database_sync_to_async
from channels.generic.websocket import AsyncWebsocketConsumer
from django.db.models.signals import post_save
from channels.layers import get_channel_layer
from myapp.models import Postagem
from myapp.serializers import PostagemSerializer

class PostagemConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        self.group_name = 'postagem_updates'  # Group name for broadcasting updates
        # Add self to the group to receive broadcast messages

        await self.channel_layer.group_add(self.group_name, self.channel_name)

        await self.accept()

    async def disconnect(self, close_code):
        # Remove self from the group on disconnect
        await self.channel_layer.group_discard(self.group_name, self.channel_name)

    async def receive(self, text_data):
        # Parse the incoming JSON data
        text_data_json = json.loads(text_data)
        message = text_data_json['message']
        if message == 'get_postagens':
            postagens = await self.get_all_postagens()
            serializer = await self.get_data_to_serialize(postagens)
            message = await self.get_json_dump(serializer)
            await self.send(text_data=message)
        # Websocket messages not relevant for this implementation

    @classmethod
    async def notify_postagem_update (self, sender, instance, created, **kwargs):#(self, cls, sender, instance, created, **kwargs):
        """
        Signal handler to broadcast serialized Postagem data upon save
        """ 
        if created:
            serializer = PostagemSerializer(instance).data
            data = json.dumps(serializer)
            try:
                await get_channel_layer().group_send('postagem_updates',{'type':'postagem_updates',"message":data})
            except ValueError as e:            
                print(e)

    async def postagem_updates(self, event):
            message = event["message"]
            # Send message to WebSocket
            await self.send(text_data=message) #self.send(text_data=json.dumps({"message": message}))

    @database_sync_to_async 
    def get_all_postagens(self):
        return Postagem.objects.all()
    
    @database_sync_to_async
    def get_data_to_serialize(self, postagens):
        return PostagemSerializer(postagens, many=True).data
    
    @database_sync_to_async
    def get_json_dump(self, serialized_data):
        return json.dumps(serialized_data)

# Connect the signal handler to Postagem model save
post_save.connect(PostagemConsumer.notify_postagem_update, sender=Postagem)

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