# Generated by Django 5.0.3 on 2024-05-13 13:26

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('myapp', '0009_remove_respostas_postagem_postagem_respostas'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='respostas',
            options={'ordering': ['resposta']},
        ),
        migrations.AddField(
            model_name='respostas',
            name='respostaBool',
            field=models.BooleanField(default=False),
        ),
    ]
