import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'dart:io';

class Respostas {
  final String respostaTexto;
  final int respondido;
  final int postagem;

  Respostas(
    {required this.respostaTexto,
    required this.respondido,
    required this.postagem}
  );

  factory Respostas.fromJson(Map<String, dynamic> json){
      final  respostaTexto = json['respostaTexto'] as String;
      final  respondido = json['respondido'] as int;
      final  postagem = json['postagem'] as int;

      return Respostas(
        respostaTexto: respostaTexto,
         respondido: respondido,
          postagem: postagem);
            
  }



  //Respostas.fromJson(Map<String, dynamic> json)
  //    : respostaTexto = json['respostaTexto'] as String,
  //      //arquivo = json['arquivo'] as File?,
  //      respondido = json['respondido'] as int,
  //      postagem = json['postagem'] as int;
//
  //Map<String, dynamic> toJson() => {
  //    'respostaTexto': respostaTexto,
  //    'respondido': respondido,
  //    'postagem': postagem 
  //};
}
