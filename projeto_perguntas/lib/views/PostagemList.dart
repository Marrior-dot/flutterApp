import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:projeto_perguntas/model/postagem.dart';
import 'package:projeto_perguntas/model/comments.dart';
import 'package:projeto_perguntas/model/user.dart';
import 'package:projeto_perguntas/services/likeDislikeButton.dart';
import 'package:projeto_perguntas/services/fetchPosts.dart';
import 'package:projeto_perguntas/services/fetchComments.dart';
import 'package:projeto_perguntas/main.dart';
import 'dart:async';
import 'dart:convert';

import 'package:projeto_perguntas/services/sendComments.dart';

class PostagemList extends StatefulWidget {
  final User user;
  const PostagemList({super.key, required this.user});
  State<PostagemList> createState() => PostagemListState();
}

class PostagemListState extends State<PostagemList> {
  late Future<List<Postagem>> futureFetch;
  @override
  void initState() {
    super.initState();
    futureFetch = fetchPostagem();
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
              if (snapshot.hasData) {
                return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var likeButton = snapshot.data![index].likes;
                    return Container(
                      height: 130,
                      child: Column(
                        children: [
                          Text(snapshot.data![index].content),
                          Row(children: [
                            //Botão para mudar os dislikes no feed de postagem, somente manda para o servidor
                            ElevatedButton(
                              onPressed: () {
                                updateLikeDislike(
                                    'dislikes',
                                    snapshot.data![index].dislikes,
                                    snapshot.data![index].id);
                              },
                              child: const Text('dislikes'),
                            ),

                            //Botão para os likes no feed de postagem, atualiza o estado da tela e manda para o servidor
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    likeButton = likeButton + 1;
                                    updateLikeDislike('likes', likeButton,
                                        snapshot.data![index].id);
                                  });
                                },
                                child: FutureBuilder<Postagem>(
                                    future: fetchLike(snapshot.data![index].id),
                                    builder: (context, snapshot) {
                                      return Text(
                                          "likes ${snapshot.data!.likes}");
                                    })),
                          ]),

                          FutureBuilder<List<CommentsPostagem>>(
                              future: fetchComments(snapshot.data![index]),
                              builder: (context, snapshot) {
                                var comentarioController =
                                    TextEditingController();
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                            child: Column(children: [
                                          Text(snapshot.data![index].texto),
                                          TextFormField(
                                              decoration: InputDecoration(
                                                labelText:
                                                    'Envie um Comentário',
                                                prefixIcon: Icon(Icons.comment),
                                              ),
                                              controller: comentarioController),
                                          ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  createComment(
                                                    comentarioController
                                                        .toString(),
                                                    widget.user,
                                                  );
                                                });
                                              },
                                              child: const Text(
                                                  "Enviar comentário"))
                                        ]));
                                      });
                                }
                                //else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                                //}
                                //return const CircularProgressIndicator();
                              }),
                          //TextFormField(
                          //  decoration: InputDecoration(
                          //    labelText: "Escreva um comentário"
//
                          //  ),
                          //  controller: comentarioController,
                          //)
                        ],
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
