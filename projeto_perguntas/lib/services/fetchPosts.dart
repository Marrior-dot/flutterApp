import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projeto_perguntas/model/postagem.dart' as postagem;

Future<List<postagem.Postagem>> fetchPostagem() async {
  final response =
      //ip de casa
      //await http.get(Uri.parse('http://192.168.15.7:8000/api/postagemlist'));
      //ip do estágio
      await http.get(Uri.parse('http://10.54.2.110:8000/api/postagemlist/'));
      //await http.get(Uri.parse('http://localhost:8000/api/postagemlist/'));

  //print(response.body);
  if (response.statusCode == 200) {
    var postagemMap =
        (jsonDecode(response.body) as List).cast<Map<String, dynamic>>(); 
    
    var ppost = postagemMap
        .map<postagem.Postagem>((json) => postagem.Postagem.fromJson(json))
        .toList();

    //print(ppost);
    return ppost;
  } else {
    throw Exception('Failed to load album');
  }
}

void removeNullInString(String response){
  RegExp nullRemover = RegExp("null");
  if (nullRemover.hasMatch(response)){
    response = response.replaceAll(nullRemover, "hello");
    }
  }
