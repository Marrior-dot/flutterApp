# Generated by Django 5.0.3 on 2024-05-13 12:11

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('myapp', '0008_respostas'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='respostas',
            name='postagem',
        ),
        migrations.AddField(
            model_name='postagem',
            name='respostas',
            field=models.ManyToManyField(to='myapp.respostas'),
        ),
    ]
