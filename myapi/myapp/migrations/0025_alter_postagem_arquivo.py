# Generated by Django 4.2.11 on 2024-09-27 13:11

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('myapp', '0024_remove_respostas_respostabool_respostas_respondido'),
    ]

    operations = [
        migrations.AlterField(
            model_name='postagem',
            name='arquivo',
            field=models.ImageField(blank=True, default='', null=True, upload_to='images'),
        ),
    ]
