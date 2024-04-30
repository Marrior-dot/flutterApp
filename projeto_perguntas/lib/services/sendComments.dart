import 'package:projeto_perguntas/model/comments.dart';
import 'package:projeto_perguntas/model/postagem.dart';
import 'package:projeto_perguntas/model/user.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<CommentsPostagem> createComment(
    String texto, User user, Postagem postagem) async {
  final response = await http.post(
    //Uri.parse('http://10.54.2.110:8000/api/comentariocreate'),
    //Uri.parse('http://localhost:8000/api/comentariocreate/${usuario}/'),
    Uri.parse('http://localhost:8000/api/comentarioCreate/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'user': user,
      'postagem': postagem,
      'text': texto,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return CommentsPostagem.fromJson(
        jsonDecode(response.body) as Map<String, String>);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}
