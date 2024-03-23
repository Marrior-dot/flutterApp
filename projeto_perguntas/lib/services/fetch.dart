import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projeto_perguntas/model/postagem.dart' as postagem;

Future<postagem.Postagem> fetchPostagem() async {
  final response =
      await http.get(Uri.parse('http://192.168.15.6:8000/api/postagemlist'));

  if (response.statusCode == 200) {
    print(response.body.runtimeType);
    return postagem.Postagem.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
    //jsonDecode(response.body) as Map<String, String>);
  } else {
    throw Exception('Failed to load album');
  }
}
