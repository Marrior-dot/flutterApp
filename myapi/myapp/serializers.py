from rest_framework import serializers
from .models import Music

class MusicSerializer(serializers.ModelSerializer):
    class Meta:

        model = Music #modelo a ser serializado
                      #(transformar dados em formatos para ser compartilhado)
        fields = '__all__' #irá pegar todos os campos do modelo a ser serializado

