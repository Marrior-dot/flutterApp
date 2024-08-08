import 'package:projeto_perguntas/model/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<User> userCreate(
    String usuario, String email, String senha, String nome) async {
  final response = await http.post(
    Uri.parse('http://localhost:8000/api/usercreate/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "name": nome,
      "password": senha,
      "email": email,
      "username": usuario
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}
