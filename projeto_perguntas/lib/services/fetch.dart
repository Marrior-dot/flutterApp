import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projeto_perguntas/model/postagem.dart' as postagem;

Future<postagem.Postagem> fetchPostagem() async {
  final response =
      //await http.get(Uri.parse('http://localhost:8000/api/postagemlist/'));
      await http.get(Uri.parse('http://10.54.2.110:8000/api/postagemlist'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return postagem.Postagem.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
/*
Future<Object> fetchData(var DataType, String path) async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:8000/api/' + path));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return DataType.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Falha ao carregar dados');
  }
}*/
