import 'package:projeto_perguntas/model/respostas.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Respostas> updateResposta(String? respostaTexto) async {
  final response = await http.put(
    Uri.parse('http://localhost:8000/api/respostasupdate/${respostaTexto}/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'respostaTexto': respostaTexto,
      //'respondido': respondido + 1
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Respostas.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to update album.');
  }
}
