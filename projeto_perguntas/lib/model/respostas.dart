import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'dart:io';

class Respostas {
  final String respostaTexto;
  final int respondido;
  final int postagem;

  Respostas(this.respostaTexto, this.respondido, this.postagem);

  Respostas.fromJson(Map<String, dynamic> json)
    : respostaTexto = json['respostaTexto'] as String,
      respondido = json['respondido'] as int,
      postagem = json['postagem'] as int;

  Map<String, dynamic> toJson() => {
        'respostaTexto': respostaTexto,
        'respondido': respondido,
        'postagem': postagem,
      };

}
