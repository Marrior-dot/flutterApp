//import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:projeto_perguntas/model/respostas.dart';
import 'dart:io';

class Postagem{
  final int id;
  final String? arquivo;
  final String? content;
  final String title;
  final int likes;
  final int dislikes;
  final bool escolha_unica;
  //final List<Respostas>? respostas;

  Postagem(this.id, this.arquivo, this.content, this.likes, this.dislikes,this.escolha_unica, this.title);

  Postagem.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        arquivo = json['arquivo'] as String?,
        title = json['title'] as String,
        content = json['content'] as String?,
        likes = json['likes'] as int,
        dislikes = json['dislikes'] as int,
        escolha_unica = json['escolha_unica'] as bool;

  Map<String, dynamic> toJson() =>{
        'id': id,
        'arquivo': arquivo,
        'content': content,
        'title': title,
        'likes': likes,
        'dislikes': dislikes,
        'escolha_unica': escolha_unica,
      };
}
