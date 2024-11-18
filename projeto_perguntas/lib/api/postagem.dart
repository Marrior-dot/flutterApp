import 'dart:async';
import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;
import 'package:projeto_perguntas/model/postagem.dart';

Future<List<Postagem>> fetchPostagem() async {
  final response =
      //await http.get(Uri.parse('http://10.54.2.110:8000/api/postagens/'));
      await http.get(Uri.parse('http://localhost:8000/api/postagens/'));

  if (response.statusCode == 200) {
    var postagemMap =
        (jsonDecode(response.body) as List).cast<Map<String, dynamic>>();
    var ppost =
        postagemMap.map<Postagem>((json) => Postagem.fromJson(json)).toList();

    return ppost;
  } else {
    throw Exception('Failed to load album');
  }
}

class PostagemSocket {
  final _socketResponse = StreamController<String>(); // Stream of strings

  // Function to add data to the stream
  void addResponse(String data) {
    _socketResponse.sink.add(data);
  }

  // Stream to listen for incoming data
  Stream<String> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}

//void connectWebSocket() {
//  IO.Socket socket;
//  socket = IO.io('http://localhost:8000/ws/postagem/',
//      IO.OptionBuilder().setTransports(['websocket']).build());
//
//  socket.onConnect((_) {
//    print('connected');
//    socket.emit('get_postagens');
//  });
//
//  socket.on('postagem_update', (data) {
//    var postagemMap = (jsonDecode(data) as List).cast<Map<String, dynamic>>();
//    var ppost =
//        postagemMap.map<Postagem>((json) => Postagem.fromJson(json)).toList();
//
//    //setState(() {
//    //  postagens.add(data['content']);
//    //});
//  });
//  socket.onDisconnect((_) => print('disconnected'));
//  socket.connect();
//}

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
      await http.get(Uri.parse('http://localhost:8000/api/postagens/$id/'));
  if (response.statusCode == 200) {
    var postagemMap =
        Postagem.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    return postagemMap.likes;
  } else {
    throw Exception('Failed to load album');
  }
}
