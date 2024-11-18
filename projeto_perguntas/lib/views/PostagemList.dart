import 'package:flutter/material.dart';
import 'package:projeto_perguntas/model/postagem.dart';
import 'package:projeto_perguntas/model/comments.dart';
import 'package:projeto_perguntas/model/respostas.dart';
import 'package:projeto_perguntas/model/user.dart';
import 'package:projeto_perguntas/api/postagem.dart';
import 'package:projeto_perguntas/api/comments.dart';
import 'package:projeto_perguntas/api/respostas.dart';
import 'package:projeto_perguntas/views/IsRadio.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:get_storage/get_storage.dart';
import 'package:projeto_perguntas/views/ImageWidget.dart';
import 'dart:convert' show jsonEncode, utf8, jsonDecode;

class PostagemList extends StatefulWidget {
  final User user;
  const PostagemList({super.key, required this.user});
  @override
  State<PostagemList> createState() => PostagemListState();
}

class PostagemListState extends State<PostagemList> {
  late Future<List<Postagem>> futureFetch;
  late TextEditingController comentarioController;
  late List<dynamic> listSendButtonStateBool;
  late List<String> listSendButtonState;
  late PostagemSocket streamSocket;

  String commentText = "";
  @override
  void initState() {
    super.initState();
    streamSocket = PostagemSocket();
    connectWebSocket();
    futureFetch = fetchPostagem();
  }

  @override
  void dispose() {
    comentarioController.dispose();
    super.dispose();
  }

  void connectWebSocket() {
    IO.Socket socket = IO.io('ws://localhost:8000/ws/postagem/',
        IO.OptionBuilder().setTransports(['websocket']).build());

    // Create a PostagemSocket instance
    final streamSocket = PostagemSocket();

    socket.onConnect((_) {
      print('connected');
      socket.emit('get_postagens');
    });

    socket.on('postagem_update', (data) {
      // Use the function from PostagemSocket to add data
      streamSocket
          .addResponse(data['content']); // Assuming data contains 'content' key
    });

    socket.onDisconnect((_) => print('disconnected'));
    socket.connect();
  }

  void loadDataBool(int lgth) {
    final box = GetStorage();
    listSendButtonStateBool = box.read('listSendButtonStateBool') ??
        List.generate(lgth, (index) => true);
    if (listSendButtonStateBool.length < lgth) {
      listSendButtonStateBool.add(true);
    }
  }

  TextEditingController controllerComments() {
    return TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
            child: StreamBuilder(
                stream: streamSocket.getResponse,
                builder: (context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Text(snapshot.data![index]);
                        });
                  } else {
                    return SizedBox.shrink();
                  }
                })
            /*FutureBuilder<List<Postagem>>(
            future: futureFetch,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                loadDataBool(snapshot.data!.length);
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
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              child: StreamBuilder(
                                  stream: streamSocket.getResponse
                                      .asBroadcastStream(),
                                  builder: (context,
                                      AsyncSnapshot<String> snapshot) {
                                    if (snapshot.hasData) {
                                      return ListView.builder(
                                          itemCount: snapshot.data!.length,
                                          itemBuilder: (context, index) {
                                            return Text(snapshot.data![index]);
                                          });
                                    } else {
                                      return SizedBox.shrink();
                                    }
                                  }),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Text(
                                  snapshot.data![index].content,
                                  //snapshot.data![index],
                                  style: const TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                            ImageWidget(
                                imageUrl: snapshot.data![index].arquivo),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    child: IconButton(
                                      onPressed: () {
                                        updateLikeDislike(
                                            'dislikes',
                                            snapshot.data![index].id,
                                            snapshot.data![index].dislikes);
                                      },
                                      icon: Icon(Icons.thumb_down),
                                      style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                        Color.fromARGB(200, 105, 105, 105),
                                      )),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                        child: IconButton(
                                          onPressed: () async {
                                            setState(() {
                                              updateLikeDislike(
                                                  'likes',
                                                  snapshot.data![index].id,
                                                  snapshot.data![index].likes);
                                              fetchLike(
                                                  snapshot.data![index].id);
                                            });
                                          },
                                          icon: const Icon(Icons.thumb_up),
                                          style: ButtonStyle(
                                              foregroundColor:
                                                  MaterialStateProperty.all(
                                            Color.fromARGB(200, 43, 142, 255),
                                          )),
                                        ),
                                      ),
                                      SizedBox(
                                          height: 20,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          child: FutureBuilder(
                                              future: fetchLike(
                                                  snapshot.data![index].id),
                                              builder: (context, snapshot) {
                                                return Text(
                                                    "${snapshot.data} likes");
                                              }))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            FutureBuilder(
                                future:
                                    fetchRespostas(snapshot.data![index].id),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return OptionsListWidget<String>(
                                        options: snapshot.data!
                                            .map((e) => e.respostaTexto)
                                            .toList(),
                                        isRadio: postagem.escolha_unica,
                                        sendWidgetButton:
                                            listSendButtonStateBool[index],
                                        listSendButtonStateBoolNew:
                                            listSendButtonStateBool,
                                        respostaIndex: index,
                                        postagemId: postagem.id);
                                  } else {
                                    return SizedBox.shrink();
                                  }
                                }),
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
          ),*/
            ),
      ),
    );
  }
}
