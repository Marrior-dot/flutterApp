import 'package:projeto_perguntas/model/comments.dart';
import 'package:projeto_perguntas/model/postagem.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

/*Future utilizado para obter os comentários do servidor, recebe o um argumento do tipo Postagem
 para fazer usar como parâmetro o atributo 'id' na url, se requisição bem sucedida
 devolve um objeto do tipo List<CommentsPostagem>, o parse das informações foi feito segundo indicações da documentação*/
Future<List<CommentsPostagem>> fetchComments(
    Postagem postagem) async {

  //Parsing da url e requiisção http    
  final response =
      await http.get(
          //Uri.parse('http://10.54.2.110:8000/api/comentarios/${postagem.id}/'));
          Uri.parse('http://localhost:8000/api/comentarios/${postagem.id}/'));
  
  //resposta do servidor
  if (response.statusCode == 200) {
    var commentsMap =
        (jsonDecode(response.body) as List).cast<Map<String, dynamic>>();

    //objeto do tipo List<CommentsPostagem>
    var ccoment = commentsMap
        .map<CommentsPostagem>((json) => CommentsPostagem.fromJson(json)).
        toList().reversed.toList();

    //retorno da função
    return ccoment;

  } 
  //resposta de exceção do servidor
  else {
    throw Exception('Ainda não há comentários');
  }
}

/*Future utilizado para o usuário enviar comentários ao servidor, recebe argumentos do tipo Postagem e String
  se requisição bem sucedida devolve um objeto do tipo CommentsPostagem, o parse das informações foi feito segundo indicações da documentação*/
Future<CommentsPostagem> createComment(
    String username, String text, Postagem postagem) async {
  
  //Parsing da url e requiisção http    
  final response = await http.post(
    //Uri.parse('http://10.54.2.110:8000/api/comentarios/'),
    Uri.parse('http://localhost:8000/api/comentarios/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    // codificação dos dados para envio
    body: jsonEncode(<String, dynamic>{
      "username": username,
      "postagem": postagem,
      "text": text,
    }),
  );
  //resposta do servidor
  if (response.statusCode == 201) {
    //retorno do objeto do tipo CommentsPostagem
    return CommentsPostagem.fromJson(
        //jsonDecode(response.body) as Map<String, String>);
        jsonDecode(response.body) as Map<String, dynamic>);
  } 
  //retorno da exceção do servidor
  else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}
