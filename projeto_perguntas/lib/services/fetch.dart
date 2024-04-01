import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projeto_perguntas/model/postagem.dart' as postagem;

Future<postagem.Postagem> fetchPostagem() async {
  final response =
      //ip de casa
      await http.get(Uri.parse('http://192.168.15.7:8000/api/postagemlist'));
  //ip do estágio
  //await http.get(Uri.parse('http://10.54.2.110:8000/api/postagemlist'));

  if (response.statusCode == 200) {
    String nResponseBody = trimColchetes(response.body);
    //print(nResponseBody);

    //var postagemMap = jsonDecode(response.body) as Map<String, dynamic>;
    var postagemMap = jsonDecode(nResponseBody) as Map<String, dynamic>;
    var ppost = postagem.Postagem.fromJson(postagemMap[0]);

    //return postagem.Postagem.fromJson(
    //    json.decode(nResponseBody) as Map<String, dynamic>);
    return ppost;
  } else {
    throw Exception('Failed to load album');
  }
}

String trimColchetes(String oldResponse) {
  String newResponseBody = "";
  RegExp exp = RegExp(r'(^\[)|(\]*)');
  if (exp.hasMatch(oldResponse) == true) {
    newResponseBody = oldResponse.replaceAll(exp, '').trim();
  }
  return newResponseBody;
}
