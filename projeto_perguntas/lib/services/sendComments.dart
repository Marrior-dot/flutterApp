import 'package:projeto_perguntas/model/comments.dart' as comments;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<comments.CommentsPostagem> createComment(String texto, int id) async {
  final response = await http.post(
    //Uri.parse('http://10.54.2.110:8000/api/comentariocreate'),
    //Uri.parse('http://localhost:8000/api/comentariocreate/${usuario}/'),
    Uri.parse('http://localhost:8000/api/postagemdetail/${id}/comentarioCreate/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'texto': texto,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return comments.CommentsPostagem.fromJson(jsonDecode(response.body) as Map<String, String>);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}