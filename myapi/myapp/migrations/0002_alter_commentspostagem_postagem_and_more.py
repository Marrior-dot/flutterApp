# Generated by Django 5.0.3 on 2024-05-06 16:12

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('myapp', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='commentspostagem',
            name='postagem',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='myapp.postagem'),
        ),
        migrations.AlterField(
            model_name='commentspostagem',
            name='user',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='myapp.user'),
        ),
        migrations.AlterField(
            model_name='postagem',
            name='content',
            field=models.CharField(max_length=500),
        ),
        migrations.AlterField(
            model_name='postagem',
            name='dislikes',
            field=models.IntegerField(default=0),
        ),
        migrations.AlterField(
            model_name='postagem',
            name='likes',
            field=models.IntegerField(default=0),
        ),
        migrations.AlterField(
            model_name='user',
            name='name',
            field=models.CharField(max_length=100),
        ),
        migrations.AlterField(
            model_name='user',
            name='password',
            field=models.CharField(max_length=100),
        ),
        migrations.AlterField(
            model_name='user',
            name='username',
            field=models.CharField(max_length=100, primary_key=True, serialize=False, unique=True),
        ),
    ]
