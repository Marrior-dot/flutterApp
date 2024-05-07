import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projeto_perguntas/model/postagem.dart';
import 'package:projeto_perguntas/model/comments.dart';

Future<List<CommentsPostagem>> fetchComments(
    Postagem postagem) async {
  final response =
      await http.get(
          Uri.parse('http://localhost:8000/api/comentariolist/${postagem}/'));
  if (response.statusCode == 200) {
    var commentsMap =
        (jsonDecode(response.body) as List).cast<Map<String, dynamic>>();

    var ccoment = commentsMap
        .map<CommentsPostagem>((json) => CommentsPostagem.fromJson(json))
        .toList();

    return ccoment;
  } else {
    throw Exception('Ainda não há comentários');
  }
}

/*
void removeNullInString(String response){
  RegExp nullRemover = RegExp("null");
  if (nullRemover.hasMatch(response)){
    response = response.replaceAll(nullRemover, "hello");
    }
  }
*/