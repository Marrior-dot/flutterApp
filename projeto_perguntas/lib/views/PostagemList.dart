import 'package:flutter/material.dart';
import 'package:projeto_perguntas/main.dart';
import 'package:projeto_perguntas/model/postagem.dart';
import 'package:projeto_perguntas/model/comments.dart';
import 'package:projeto_perguntas/model/user.dart';
import 'package:projeto_perguntas/api/postagem.dart';
import 'package:projeto_perguntas/api/comments.dart';
import 'package:projeto_perguntas/views/ImageWidget.dart';
import 'package:projeto_perguntas/views/ContentWidget.dart';
import 'package:projeto_perguntas/views/RespostasWidget.dart';
import 'package:projeto_perguntas/views/TitleWidget.dart';
import 'package:projeto_perguntas/views/LikesDislikesWidget.dart';
import 'dart:convert' show utf8;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:projeto_perguntas/views/UserSettingsWidget.dart';

class PostagemList extends StatefulWidget {
  final User user;
  const PostagemList({super.key, required this.user});
  @override
  State<PostagemList> createState() => PostagemListState();
}

class PostagemListState extends State<PostagemList> {
  late TextEditingController comentarioController;
  WebSocketChannel streamSocket =
      WebSocketChannel.connect(Uri.parse('ws://localhost:8000/ws/postagem/'));

  String commentText = "";
  @override
  void initState() {
    super.initState();
    connectWebSocket(streamSocket);
  }

  @override
  void dispose() {
    super.dispose();
    comentarioController.dispose();
  }

  TextEditingController controllerComments() {
    return TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      routes:{
        '/configurar':(context) => UserSettingsWidget(user: widget.user, streamSocket: streamSocket),
        '/login':(context) => MyApp(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
          actions: [
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                                                  builder: (context) => UserSettingsWidget(
                                                    user: widget.user, streamSocket: streamSocket
                                                  )));}, 
            icon: Icon(Icons.tune))],
        ),
        body: Center(
          child: StreamBuilder<List<Postagem>>(
            stream: getPostagemStreamController().stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, index) {
                    var postagem = snapshot.data![index];
                    comentarioController = controllerComments();
                    return Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleWidget(title: snapshot.data![index].title),
                            ImageWidget(
                                imageUrl: snapshot.data![index].arquivo),
                                ContentWidget(
                                content: snapshot.data![index].content),
                            FutureBuilder(future: checkLike(widget.user.username, snapshot.data![index].id), 
                            builder: (context, snapshot){
                                return LikesDislikesWidget(
                                  likes: postagem.likes,
                                  dislikes: postagem.dislikes,
                                  postagemId: postagem.id,
                                  userName: widget.user.username,
                                  sendButton: snapshot.data);
                            }  
                            )
                                  ,
                            RespostasWidget(
                                postagemid: snapshot.data![index].id,
                                userid: widget.user.username,
                                escolha_unica:
                                    snapshot.data![index].escolha_unica,
                                index: index),
                            const SizedBox(height: 16.0),
                            Column(
                              children: [
                                TextFormField(
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                  decoration: const InputDecoration(
                                    labelText: 'Escreva seu comentário',
                                    prefixIcon: Icon(Icons.comment),
                                    border: OutlineInputBorder(),
                                  ),
                                  controller: comentarioController,
                                  onChanged: (value) => commentText = value,
                                ),
                                const SizedBox(height: 16.0),
                                SizedBox(
                                  height: 40,
                                  width: 200,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        createComment(
                                          widget.user.username,
                                          commentText,
                                          postagem,
                                        );
                                      });
                                    },
                                    child: const Text("Enviar comentário",
                                        style: TextStyle(fontSize: 12.0)),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            SingleChildScrollView(
                              child: FutureBuilder<List<CommentsPostagem>>(
                                future: fetchComments(postagem),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        final item = utf8.decode(snapshot
                                            .data![index].text
                                            .toString()
                                            .codeUnits);
                                        final user =
                                            snapshot.data![index].username;
                                        return ListTile(
                                            title: Text("${user}:${item}"));
                                      },
                                    );
                                  }
                                  return Text('${snapshot.error}');
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return Text('${snapshot.error}');
            },
          ),
        ),
      ),
    );
  }
}
