import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projeto_perguntas/model/postagem.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

StreamController<List<Postagem>> postagemStreamController = StreamController<List<Postagem>>();
List<Postagem> postagensStream = [];

void connectWebSocket(WebSocketChannel streamSocket) async{
  try{
      await streamSocket.ready;
      streamSocket.sink.add(jsonEncode({'message': 'get_postagens'}));
      streamSocket.stream.listen((event) {
        var postagemEvent = jsonDecode(event);
        if (postagemEvent is List){
          var postagem = postagemEvent.map<Postagem>((json) => Postagem.fromJson(json)).toList();
          setPostagensStream(postagem);
          postagemStreamController.add(postagem);

        }
        else{
          Postagem postagem = Postagem.fromJson(postagemEvent);
          //print(postagem.likes);
          postagensStream.insert(0, postagem);
          postagemStreamController.add(postagensStream);
        }
      });
    }
    on WebSocketChannelException catch(e){
      print(e);
    }
}

StreamController<List<Postagem>> getPostagemStreamController(){
  return postagemStreamController;
}

void setPostagensStream(List<Postagem> postagem) {
  for (var element in postagem) {
    postagensStream.add(element);
  }
}

void removeNullInString(String response) {
  RegExp nullRemover = RegExp("null");
  if (nullRemover.hasMatch(response)) {
    response = response.replaceAll(nullRemover, "hello");
  }
}

Future<Postagem> updateLikeDislike(
    String likeOrDislike, int id, int button) async {
  final response = await http.patch(
    Uri.parse('http://localhost:8000/api/postagens/$id/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      likeOrDislike: button + 1,
    }),
  );
  if (response.statusCode == 200) {
    return Postagem.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to update album.');
  }
}

Future<int> fetchLike(int id) async {
  final response =
      //await http.get(Uri.parse('http://10.54.2.110:8000/api/postagens/$id/'));
      await http.get(Uri.parse('http://localhost:8000/api/postagens/${id}/'));
  if (response.statusCode == 200) {
    var postagemMap =
        Postagem.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    return postagemMap.likes;
  } else {
    throw Exception('Failed to load album');
  }
}

Future<void> persistencaLike(String userName, int postagemID) async {
  final response = await http.post(
    //Uri.parse('http://10.54.2.110:8000/api/users/'),
    Uri.parse(
        'http://localhost:8000/api/postagens_persistencia/${userName}/${postagemID}/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "user": userName,
      "postagem": postagemID,
    }),
  );
  if (response.statusCode == 201) {
    return;
  } else {
    throw Exception('Falha ao salvar persistência');
  }
}

Future<bool?> checkLike(String userName, int postagemID) async {
  final response = await http.get(
    //Uri.parse('http://10.54.2.110:8000/api/respostas_persistencia/${idUser}/'),
    Uri.parse(
        'http://localhost:8000/api/postagens_persistencia/${userName}/${postagemID}/'),
  );
  if (response.statusCode == 200) {
      return null;
  }
  return true;
}