import 'package:flutter/material.dart';
import 'package:projeto_perguntas/main.dart';
import 'package:projeto_perguntas/model/postagem.dart';
import 'package:projeto_perguntas/model/user.dart';
import 'package:projeto_perguntas/api/postagem.dart';
import 'package:projeto_perguntas/views/ImageWidget.dart';
import 'package:projeto_perguntas/views/ContentWidget.dart';
import 'package:projeto_perguntas/views/RespostasWidget.dart';
import 'package:projeto_perguntas/views/TitleWidget.dart';
import 'package:projeto_perguntas/views/LikesDislikesWidget.dart';
import 'package:projeto_perguntas/views/ComentariosWidget.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:projeto_perguntas/views/UserSettingsWidget.dart';

class PostagemList extends StatefulWidget {
  final User user;
  const PostagemList({super.key, required this.user});
  @override
  State<PostagemList> createState() => PostagemListState();
}

class PostagemListState extends State<PostagemList> {
  WebSocketChannel streamSocket = WebSocketChannel.connect(Uri.parse('ws://localhost:8000/ws/postagem/'));
  String commentText = "";

  @override
  void initState() {
    super.initState();
    connectWebSocket(streamSocket);
  }

  @override
  void dispose() {
    super.dispose();
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
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
            },
          ),
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
            stream: getPostagemStreamController().stream.asBroadcastStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, index) {
                    Postagem postagem = snapshot.data![index];
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
                            LikesDislikesWidget(likes: snapshot.data![index].likes, 
                                                dislikes: snapshot.data![index].dislikes, 
                                                postagemId: snapshot.data![index].id, 
                                                userName: widget.user.username)
                                  ,
                            RespostasWidget(
                                postagemid: snapshot.data![index].id,
                                userid: widget.user.username,
                                escolha_unica:
                                    snapshot.data![index].escolha_unica,
                                ),
                            ComentariosWidget(postagem: postagem, user: widget.user)
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
