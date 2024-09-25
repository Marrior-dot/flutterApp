import 'package:flutter/material.dart';
import 'package:projeto_perguntas/model/postagem.dart';
import 'package:projeto_perguntas/model/comments.dart';
import 'package:projeto_perguntas/model/user.dart';
import 'package:projeto_perguntas/services/likeDislikeButton.dart';
import 'package:projeto_perguntas/services/fetchPosts.dart';
import 'package:projeto_perguntas/services/fetchComments.dart';
import 'package:projeto_perguntas/views/IsRadio.dart';
import 'dart:async';
import 'package:projeto_perguntas/services/sendComments.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_storage/get_storage.dart';
import 'package:projeto_perguntas/views/ImageWidget.dart';

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
  String commentText = "";

  @override
  void initState() {
    super.initState();
    futureFetch = fetchPostagem();  
    }

  @override
  void dispose() {
    comentarioController.dispose();
    super.dispose();
  }

  void loadDataBool(int lgth){
    final box = GetStorage();
    listSendButtonStateBool = box.read('listSendButtonStateBool') ?? List.generate(lgth, (index) => true);
    }

  TextEditingController controllerComments() {
    return TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    //GetStorage().remove('listSendButtonStateBool');
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
          child: FutureBuilder<List<Postagem>>(
            future: futureFetch,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //_loadButtonState(snapshot.data!.length);
                loadDataBool(snapshot.data!.length);
                //print(listSendButtonStateBool);
                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, index) {
                    var likeButton = snapshot.data![index].likes;
                    var postagem = snapshot.data![index];
                    List<dynamic> respostas = snapshot.data![index].respostas;
                    comentarioController = controllerComments();
                    return Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: //Padding(
                        SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.width * 0.8,
                                child: Text(
                                  snapshot.data![index].content,
                                  style: const TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                            ),
                            ImageWidget(imagePath: snapshot.data![index].arquivo),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                            OptionsListWidget<String>(
                              options: respostas.cast<String>(),
                              isRadio: postagem.escolha_unica,
                              sendWidgetButton: listSendButtonStateBool[index],
                              listSendButtonStateBoolNew: listSendButtonStateBool,
                              respostaIndex: index,
                            ),
                            const SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                OutlinedButton.icon(
                                  onPressed: () {
                                    updateLikeDislike(
                                      'dislikes',
                                      snapshot.data![index].dislikes,
                                      snapshot.data![index].id,
                                      snapshot.data![index].content,
                                      respostas,
                                    );
                                  },
                                  icon: const Icon(Icons.thumb_down),
                                  label: const Text('Dislike'),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.grey,
                                  ),
                                ),
                                OutlinedButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      likeButton = likeButton + 1;
                                      updateLikeDislike(
                                        'likes',
                                        likeButton,
                                        snapshot.data![index].id,
                                        snapshot.data![index].content,
                                        respostas,
                                      );
                                    });
                                  },
                                  icon: const Icon(Icons.thumb_up),
                                  label: FutureBuilder<Postagem>(
                                    future: fetchLike(snapshot.data![index].id),
                                    builder: (context, snapshot) {
                                      return Text(
                                          "Likes ${snapshot.data!.likes}");
                                    },
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Escreva seu comentário',
                                prefixIcon: Icon(Icons.comment),
                                border: OutlineInputBorder(),
                              ),
                              controller: comentarioController,
                              onChanged: (value) => commentText = value,
                            ),
                            SizedBox(
                              height: 16.0,
                              width: MediaQuery.sizeOf(context).width * 0.4,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  createComment(
                                    widget.user.username,
                                    commentText,
                                    postagem,
                                  );
                                });
                              },
                              child: const Text("Enviar comentário"),
                            ),
                            const SizedBox(height: 16.0),
                            SingleChildScrollView(
                              child:  FutureBuilder<List<CommentsPostagem>>(
                              future: fetchComments(postagem),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      final item = snapshot.data![index].text;
                                      return ListTile(
                                        title: Text(item),
                                        trailing: const Icon(Icons.arrow_right),
                                      );
                                    },
                                  );
                                }
                                return Text('${snapshot.error}');
                              },
                            ),
                            ),
                            //FutureBuilder<List<CommentsPostagem>>(
                            //  future: fetchComments(postagem),
                            //  builder: (context, snapshot) {
                            //    if (snapshot.hasData) {
                            //      return ListView.builder(
                            //        shrinkWrap: true,
                            //        physics:
                            //            const NeverScrollableScrollPhysics(),
                            //        itemCount: snapshot.data!.length,
                            //        itemBuilder: (context, index) {
                            //          final item = snapshot.data![index].text;
                            //          return ListTile(
                            //            title: Text(item),
                            //            trailing: const Icon(Icons.arrow_right),
                            //          );
                            //        },
                            //      );
                            //    }
                            //    return Text('${snapshot.error}');
                            //  },
                            //),
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
