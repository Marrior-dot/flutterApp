import 'package:flutter/material.dart';
import 'package:projeto_perguntas/model/postagem.dart';
import 'package:projeto_perguntas/model/comments.dart';
import 'package:projeto_perguntas/model/respostas.dart';
import 'package:projeto_perguntas/model/user.dart';
import 'package:projeto_perguntas/api/postagem.dart';
import 'package:projeto_perguntas/api/comments.dart';
import 'package:projeto_perguntas/api/respostas.dart';
import 'package:projeto_perguntas/views/IsRadio.dart';
import 'dart:async';
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

  void loadDataBool(int lgth) {
    final box = GetStorage();
    listSendButtonStateBool = box.read('listSendButtonStateBool') ??
        List.generate(lgth, (index) => true);
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
          child: FutureBuilder<List<Postagem>>(
            future: futureFetch,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                loadDataBool(snapshot.data!.length);
                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, index) {
                    var postagem = snapshot.data![index];
                    //List<dynamic> respostas = FutureBuilder<List<Respostas>>()
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
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Text(
                                  snapshot.data![index].content,
                                  style: const TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                            ImageWidget(
                                imageUrl: snapshot.data![index].arquivo),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                width: MediaQuery.of(context).size.width * 1,
                                child:
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.1,
                                      child: IconButton(
                                        onPressed: () {
                                          updateLikeDislike(
                                            'dislikes',
                                            snapshot.data![index].id,
                                            snapshot.data![index].dislikes
                                          );
                                        },
                                        icon: Icon(Icons.thumb_down),
                                        style: ButtonStyle(
                                          foregroundColor: MaterialStateProperty.all(
                                            Color.fromARGB(
                                                200,105,105,105),
                                          )
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.1,
                                      child: IconButton(
                                        onPressed: (){
                                          setState(() {
                                             updateLikeDislike(
                                              'likes',
                                              snapshot.data![index].id,
                                              snapshot.data![index].likes
                                            );

                                          });
                                        },
                                        icon: const Icon(Icons.thumb_up),
                                        style: ButtonStyle(
                                          foregroundColor: MaterialStateProperty.all(
                                            Color.fromARGB(
                                                200, 43, 142, 255),
                                          )
                                        ),
                                      ),
                                    ),
                                  SizedBox(
                                    height: 20,
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    child:
                                    FutureBuilder(
                                      future: fetchLike(snapshot.data![index].id), 
                                        builder: (context, snapshot) {
                                          return  Text("${snapshot.data} likes") ;
                                        })
                                )],)
                                  ],
                                ),
                              ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05),
                            //OptionsListWidget<String>(
                            //  options: respostas.cast<String>(),
                            //  isRadio: postagem.escolha_unica,
                            //  sendWidgetButton: listSendButtonStateBool[index],
                            //  listSendButtonStateBoolNew:
                            //      listSendButtonStateBool,
                            //  respostaIndex: index,
                            //),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.08,
                            ),
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
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.025,
                            ),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).width * 0.1,
                              width: MediaQuery.sizeOf(context).width * 0.45,
                              child: 
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
                                  child: const Text(
                                    "Enviar comentário",
                                    style: TextStyle(fontSize: 12.0)),
                                  ),
                                )],
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
                                        final item = snapshot.data![index].text;
                                        return ListTile(
                                          title: Text(item),
                                          trailing:
                                              const Icon(Icons.arrow_right),
                                        );
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
