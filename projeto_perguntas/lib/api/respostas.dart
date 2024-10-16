import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projeto_perguntas/model/respostas.dart';

Future<List<Respostas>?> fetchRespostas(int postagem) async {
  Uri.parse('http://10.54.2.110:8000/api/respostas/$postagem/');
  final response =
      await http.get(Uri.parse('http://10.54.2.110:8000/api/respostas/$postagem/'));
      //await http.get(Uri.parse('http://localhost:8000/api/postagemlist/'));

  print(response.body);
  if (response.statusCode == 200) {
    //var respostasMap =
    //    (jsonDecode(response.body) as List).cast<Map<String, dynamic>>();

    List<Respostas>? respostasMap = (jsonDecode(response.body) as List<Respostas>?);
    print(respostasMap);
    //print(respostasMap);
    //var rpost = respostasMap
    //    .map<Respostas>((json) => Respostas.fromJson(json))
    //    .toList();

    return respostasMap ;
  } else {
    throw Exception('Failed to load album');
  }
}