# Generated by Django 5.0.3 on 2024-05-06 17:41

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('myapp', '0002_alter_commentspostagem_postagem_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='username',
            field=models.CharField(max_length=100, primary_key=True, serialize=False),
        ),
    ]
