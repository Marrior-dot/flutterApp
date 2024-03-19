from django.db import models

# Create your models here.

class Music(models.Model):

    class Meta():
        #Tabela dentro do banco de dados
        db_table = 'music'

    title = models.CharField(max_length=200)
    seconds = models.IntegerField()

    def __str__(self) -> str:
        return self.title