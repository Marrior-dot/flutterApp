import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:projeto_perguntas/model/postagem.dart' as postagem;
import 'package:projeto_perguntas/services/fetchPosts.dart';

Future<postagem.Postagem> updateLikeDislike(
    String likeOrDislike, int button, int id) async {
  final response = await http.put(
    //Uri.parse('http://192.168.15.7:8000/api/postagemupdate/${id}')
    //Uri.parse('http://10.54.2.110:8000/api/postagemupdate/${id}/' ),
    Uri.parse('http://localhost:8000/api/postagemupdate/$id/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, int>{
      likeOrDislike: button,
    }),
  );
  
  if (response.statusCode == 200) {
    removeNullInString(response.body);
    return postagem.Postagem.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to update album.');
  }
}

Future<postagem.Postagem> fetchLike(int id) async{
  final response =
      //ip de casa
      //await http.get(Uri.parse('http://192.168.15.7:8000/api/postagemlist'));
      //ip do estágio
      //await http.get(Uri.parse('http://10.54.2.110:8000/home/postagemlist'));
      //await http.get(Uri.parse('http://10.113.160.36:8000/home/postagemlist'));
      await http.get(Uri.parse('http://localhost:8000/api/postagemdetail/$id'));
  if (response.statusCode == 200) { 
    var postagemMap = postagem.Postagem.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    //print(postagemMap[0]["likes"]);
    return postagemMap;
  } else {
    throw Exception('Failed to load album');
  }
}



