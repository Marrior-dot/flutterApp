import 'dart:io';
import 'package:projeto_perguntas/model/user.dart';
import 'package:projeto_perguntas/model/postagem.dart';

class CommentsPostagem {
  //final int id;
  final User user;
  final Postagem postagem;
  final String text;

  CommentsPostagem(this.user, this.postagem, this.text);

  CommentsPostagem.fromJson(Map<String, dynamic> json)
      : user = json['user'] as User,
        postagem = json['postagem'] as Postagem,
        text = json['text'] as String;

  Map<String, dynamic> toJson() =>
      {'user': user, 'postagem': postagem, 'text': text};
}
