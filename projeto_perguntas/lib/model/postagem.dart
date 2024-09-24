import 'dart:convert';
import 'dart:ffi';
import 'package:json_annotation/json_annotation.dart';
import 'dart:io';

class Postagem {
  final int id;
  //final File? arquivo;
  final String? arquivo_path;
  final String content;
  final int likes;
  final int dislikes;
  final List<dynamic> respostas;
  final bool escolha_unica;
  
  Postagem(this.id, /*this.arquivo*/ this.arquivo_path, this.content, this.likes, this.dislikes, this.respostas, this.escolha_unica);

  Postagem.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        //arquivo = json['arquivo'] as File?,
        arquivo_path = json['arquivo_path'] as String?,
        content = json['content'] as String,
        likes = json['likes'] as int,
        dislikes = json['dislikes'] as int,
        respostas = json['respostas'] as List<dynamic>,
        escolha_unica = json['escolha_unica'] as bool;

  Map<String, dynamic> toJson() => {
        'id': id,
        //'arquivo': arquivo,
        'arquivo_path': arquivo_path,
        'content': content,
        'likes': likes,
        'dislikes': dislikes,
        'respostas':respostas,
        'escolha_unica':escolha_unica
      };
}