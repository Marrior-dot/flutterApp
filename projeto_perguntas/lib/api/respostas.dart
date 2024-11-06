import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projeto_perguntas/model/respostas.dart';

Future<List<Respostas>?> fetchRespostas(int postagem) async {
  final response =
      //await http.get(Uri.parse('http://10.54.2.110:8000/api/respostas/$postagem/'));
      await http.get(Uri.parse('http://localhost:8000/api/respostas/$postagem/'));

  if (response.statusCode == 200) {
    var repostasDecode =
        (jsonDecode(response.body) as List).cast<Map<String, dynamic>>();
    var respostasMap = repostasDecode
        .map<Respostas>((json) => Respostas.fromJson(json))
        .toList();
    
    return respostasMap;
  } else {
    throw Exception('Failed to load album');
  }
}

Future<Respostas> updateResposta(String? respostaTexto, int idPostagem) async {
  final response = await http.patch(
        //Uri.parse('http://10.54.2.110:8000/api/respostas/${idPostagem}/${respostaTexto}/'),
        Uri.parse('http://localhost:8000/api/respostas/${idPostagem}/${respostaTexto}/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
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