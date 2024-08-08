# Generated by Django 4.2.11 on 2024-05-13 21:43

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('myapp', '0009_remove_respostas_postagem_postagem_respostas'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='respostas',
            options={'ordering': ['respostaTexto']},
        ),
        migrations.RenameField(
            model_name='respostas',
            old_name='resposta',
            new_name='respostaTexto',
        ),
        migrations.AddField(
            model_name='respostas',
            name='respostaBool',
            field=models.BooleanField(default=False),
        ),
    ]
