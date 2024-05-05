import 'dart:io';
import 'package:projeto_perguntas/model/user.dart';
import 'package:projeto_perguntas/model/postagem.dart';
import 'package:json_annotation/json_annotation.dart';
part 'commentpostagem.g.dart';

@JsonSerializable(explicitToJson: true)
class CommentsPostagem {
  CommentsPostagem(this.user, this.postagem, this.text);

  User user;
  Postagem postagem;
  String text;

  factory CommentsPostagem.fromJson(Map<String, dynamic> json) =>
      _$CommentsPostagemFromJson(json);
  Map<String, dynamic> toJson() => _$CommentsPostagemToJson(this);
}
/*
class CommentsPostagem {
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
}*/