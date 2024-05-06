import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projeto_perguntas/model/postagem.dart';
import 'package:projeto_perguntas/model/comments.dart';

Future<List<CommentsPostagem>> fetchComments(
    Postagem postagem) async {
  final response =
      //ip de casa
      //await http.get(Uri.parse('http://192.168.15.7:8000/api/postagemlist'));
      //ip do estágio
      //await http.get(Uri.parse('http://10.54.2.110:8000/home/postagemlist'));
      //await http.get(Uri.parse('http://10.113.160.36:8000/home/postagemlist'));
      //await http.get(Uri.parse('http://localhost:8000/api/postagemlist/'));
      //await http.get(Uri.parse('http://localhost:8000/api/postagemdetail/${id}/comentarioList/'));
      await http.get(
          Uri.parse('http://localhost:8000/api/comentariolist/${postagem}/'));
          //Uri.parse('http://localhost:8000/api/comentarioList/'));
  //print(response.body);
  if (response.statusCode == 200) {
    var commentsMap =
        (jsonDecode(response.body) as List).cast<Map<String, dynamic>>();

    var ccoment = commentsMap
        .map<CommentsPostagem>((json) => CommentsPostagem.fromJson(json))
        .toList();

    //print(ppost);
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