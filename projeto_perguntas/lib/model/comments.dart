import 'dart:io';
import 'package:projeto_perguntas/model/user.dart' as user;
import 'package:projeto_perguntas/model/postagem.dart' as postagem;

class CommentsPostagem {
  final int id;
  final user.User usuario;
  final postagem.Postagem posts;
  final String texto;

  CommentsPostagem(this.id, this.usuario, this.posts ,this.texto);

  CommentsPostagem.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        usuario = json['usuario'] as user.User,
        posts = json['posts'] as postagem.Postagem,
        texto = json['texto'] as String;

  Map<String, dynamic> toJson() => {
        'id':id,
        'usuario': usuario,
        'posts': posts,
        'texto': texto
      };
}