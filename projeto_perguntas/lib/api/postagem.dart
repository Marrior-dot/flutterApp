import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto_perguntas/model/postagem.dart';
import 'package:projeto_perguntas/model/respostas.dart';
import 'package:projeto_perguntas/api/respostas.dart';

Future<List<Postagem>> fetchPostagem() async{
  final response =
      //await http.get(Uri.parse('http://10.54.2.110:8000/api/postagens/'));
      await http.get(Uri.parse('http://localhost:8000/api/postagens/'));
      
  if (response.statusCode == 200) {
    var postagemMap =
        (jsonDecode(response.body) as List).cast<Map<String, dynamic>>();
    var ppost = postagemMap
        .map<Postagem>((json) => Postagem.fromJson(json))
        .toList();

    return ppost;
  } else {
    throw Exception('Failed to load album');
  }
}

void removeNullInString(String response){
  RegExp nullRemover = RegExp("null");
  if (nullRemover.hasMatch(response)){
    response = response.replaceAll(nullRemover, "hello");
    }
  }

Future<Postagem> updateLikeDislike(
    String likeOrDislike, int id, int button) async {
  final response = await http.patch(
    Uri.parse('http://localhost:8000/api/postagens/$id/' ),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      likeOrDislike: button + 1,
    }),
  );
  if (response.statusCode == 200) {
    return Postagem.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to update album.');
  }
}

Future<int> fetchLike(int id) async{
  final response =
      //await http.get(Uri.parse('http://10.54.2.110:8000/api/postagens/$id/'));
      await http.get(Uri.parse('http://localhost:8000/api/postagens/$id/'));
  if (response.statusCode == 200) { 
    var postagemMap = Postagem.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    return postagemMap.likes;
  } else {
    throw Exception('Failed to load album');
  }
}
