import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:projeto_perguntas/model/postagem.dart' as postagem;

Future<postagem.Postagem> updateLikeDislike(String likeOrDislike,int button, int id) async {
  final response = await http.put(
    //Uri.parse('http://192.168.15.7:8000/api/postagemupdate/${id}')
    Uri.parse('http://10.54.2.110:8000/api/postagemupdate/${id}/' ),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, int>{
      likeOrDislike: button + 1,
    }),
  );
if (response.statusCode == 200) {
    return postagem.Postagem.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to update album.');
  }
}
  
