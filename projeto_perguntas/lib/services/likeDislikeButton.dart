import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:projeto_perguntas/model/postagem.dart';
import 'package:projeto_perguntas/services/fetchPosts.dart';

Future<Postagem> updateLikeDislike(
    String likeOrDislike, int button, int id, String content, List<dynamic> respostas) async {
  final response = await http.put(
    //Uri.parse('http://192.168.15.7:8000/api/postagemupdate/${id}')
    Uri.parse('http://10.54.2.110:8000/api/postagemupdate/$id/' ),
    //Uri.parse('http://localhost:8000/api/postagemupdate/$id/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      likeOrDislike: button,
      "content": content,
      "respostas": respostas
    }),
  );
  if (response.statusCode == 200) {
    //removeNullInString(response.body);
    return Postagem.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to update album.');
  }
}

//Future<Postagem> fetchLike(int id) async{
Future<int> fetchLike(int id) async{
  final response =
      await http.get(Uri.parse('http://10.54.2.110:8000/api/postagemdetail/$id/'));
  if (response.statusCode == 200) { 
    var postagemMap = Postagem.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    return postagemMap.likes;
  } else {
    throw Exception('Failed to load album');
  }
}



