import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:projeto_perguntas/model/postagem.dart';
import 'package:projeto_perguntas/model/comments.dart';
import 'package:projeto_perguntas/model/user.dart';
import 'package:projeto_perguntas/services/likeDislikeButton.dart';
import 'package:projeto_perguntas/services/fetchPosts.dart';
import 'package:projeto_perguntas/services/fetchComments.dart';
import 'package:projeto_perguntas/views/radioWidget.dart';
import 'dart:async';
import 'package:projeto_perguntas/services/sendComments.dart';

class PostagemList extends StatefulWidget {
  final User user;
  const PostagemList({super.key, required this.user});
  @override
  State<PostagemList> createState() => PostagemListState();
}

class PostagemListState extends State<PostagemList> {
  late Future<List<Postagem>> futureFetch;
  late TextEditingController comentarioController;
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

  TextEditingController controllerComments() {
    return TextEditingController();
  }

  Widget checkBoxOrRadio(List<dynamic> respostaTexto, bool tipoResposta) {
    if (respostaTexto.length == 0) {
      return EmptyWidget();
    }
    if (tipoResposta == true) {

      /*dynamic currentOption = respostaTexto[0];
      return ListView.builder(
          itemCount: respostaTexto.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Text(respostaTexto[index]),
                leading: Radio(
                    value: respostaTexto[index],
                    groupValue: currentOption,
                    onChanged: (value) {
                      setState(() {
                        currentOption = value;
                      });
                    }));
          });*/
    } else {
      return ListView.builder(
          itemCount: respostaTexto.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Text(respostaTexto[index]),
                leading: Checkbox(
                    value: false,
                    onChanged: (value) {
                      setState(() {
                        if (value == false) {
                          value = true;
                        } else {
                          value = false;
                        }
                      });
                    }));
          });
    }
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
                //Fazendo Fetch das postagens
                child: FutureBuilder<List<Postagem>>(
                    future: futureFetch,
                    builder: (context, snapshot) {
                      //print("carregando");
                      if (snapshot.hasData) {
                        return ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, index) {
                              var likeButton = snapshot.data![index].likes;
                              var postagem = snapshot.data![index];
                              List<dynamic> respostas =
                                  snapshot.data![index].respostas;
                              bool radioOrCheckbox =
                                  snapshot.data![index].escolha_unica;
                              comentarioController = controllerComments();

                              return SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                child: Column(children: [
                                  Text(snapshot.data![index].content),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  checkBoxOrRadio(respostas, radioOrCheckbox),
                                  //Flexible(
                                  //  child:MyWidget(
                                  //    respostaTexto: respostas,
                                  //    tipoResposta: radioOrCheckbox,
                                  //  )),
                                  Wrap(
                                    spacing: 20.0,
                                    children: <Widget>[
                                      Flexible(
                                        child: OutlinedButton(
                                          onPressed: () {
                                            updateLikeDislike(
                                                'dislikes',
                                                snapshot.data![index].dislikes,
                                                snapshot.data![index].id,
                                                snapshot.data![index].content,
                                                respostas);
                                          },
                                          child: const Text('dislikes'),
                                          style: ButtonStyle(
                                              foregroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.grey)),
                                        ),
                                      ),
                                      Flexible(
                                        child: /*ElevatedButton*/
                                            OutlinedButton(
                                          onPressed: () {
                                            setState(() {
                                              likeButton = likeButton + 1;
                                              updateLikeDislike(
                                                  'likes',
                                                  likeButton,
                                                  snapshot.data![index].id,
                                                  snapshot.data![index].content,
                                                  respostas);
                                            });
                                          },
                                          child: FutureBuilder<Postagem>(
                                              future: fetchLike(
                                                  snapshot.data![index].id),
                                              builder: (context, snapshot) {
                                                return Text(
                                                    "likes ${snapshot.data!.likes}");
                                              }),
                                          style: ButtonStyle(
                                            foregroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.blue),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Flexible(
                                      child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          10.0), // Adjust as desired
                                      border: Border.all(
                                        color: Colors
                                            .grey, // Customize border color
                                        width: 1.0, // Adjust border width
                                      ),
                                    ),
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(5),
                                        labelText: 'Escreva seu comentário',
                                        prefixIcon: Icon(Icons.comment),
                                      ),
                                      controller: comentarioController,
                                      onChanged: (value) => commentText = value,
                                    ),
                                  )),
                                  const SizedBox(height: 15.0),
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          createComment(widget.user.username,
                                              commentText, postagem);
                                        });
                                      },
                                      child: const Text("Enviar comentário")),
                                  Flexible(
                                    child:
                                        FutureBuilder<List<CommentsPostagem>>(
                                      future: fetchComments(postagem),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Flexible(
                                            child: ListView.builder(
                                              itemCount: snapshot.data!.length,
                                              itemBuilder: (context, index) {
                                                final item =
                                                    snapshot.data![index].text;
                                                return ListTile(
                                                  title: Text(item),
                                                  trailing: Icon(Icons
                                                      .arrow_right), // Add a trailing icon
                                                );
                                              },
                                            ),
                                          );
                                        }
                                        return Text('${snapshot.error}');
                                      },
                                    ),
                                  ),
                                ]),
                              );
                            });
                      }
                      return Text('${snapshot.error}');
                    }))));
  }
}
