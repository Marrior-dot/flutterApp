import 'package:flutter/material.dart';
import 'package:projeto_perguntas/model/postagem.dart';
import 'package:projeto_perguntas/model/comments.dart';
import 'package:projeto_perguntas/model/user.dart';
import 'package:projeto_perguntas/services/likeDislikeButton.dart';
import 'package:projeto_perguntas/services/fetchPosts.dart';
import 'package:projeto_perguntas/services/fetchComments.dart';
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
  String commentText="";

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
  List<TextEditingController> controllersComments(int quantidade){
    List<TextEditingController> listaControllers=[];
    for (int i = 0; i < quantidade; i++) {
      listaControllers.add(TextEditingController());
    }

    return listaControllers;
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
                              late var postagem = snapshot.data![index];
                              //print(snapshot.data!.length);
                              //print(snapshot.data!);
                              //print(controllersComments(snapshot.data!.length));
                              comentarioController = controllersComments(snapshot.data!.length)[index];
                              return SizedBox(
                                width: MediaQuery.of(context).size.width*0.5,
                                height:MediaQuery.of(context).size.height*0.9, //200,
                                child: Column(children: [
                                  Text(snapshot.data![index].content),
                                  Row(
                                  children: [
                                    //Botão para mudar os dislikes no feed de postagem, somente manda para o servidor
                                    ElevatedButton(
                                      onPressed: () {
                                        updateLikeDislike(
                                            'dislikes',
                                            snapshot.data![index].dislikes,
                                            snapshot.data![index].id,
                                            snapshot.data![index].content);
                                      },
                                      child: const Text('dislikes'),
                                    ),

                                    //Botão para os likes no feed de postagem, atualiza o estado da tela e manda para o servidor
                                    ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            likeButton = likeButton + 1;
                                            updateLikeDislike(
                                                'likes',
                                                likeButton,
                                                snapshot.data![index].id,
                                                snapshot.data![index].content);
                                          });
                                        },
                                        child: FutureBuilder<Postagem>(
                                            future: fetchLike(
                                                snapshot.data![index].id),
                                            builder: (context, snapshot) {
                                                        return Text(
                                                  "likes ${snapshot.data!.likes}");
                                            })),
                                  ]),
                                  TextFormField(
                                      decoration: const InputDecoration(
                                        labelText: 'Envie um Comentário',
                                        prefixIcon: Icon(Icons.comment),
                                      ),
                                      controller: comentarioController,
                                      onChanged: (value) => {
                                          commentText = value,
                                      },
                                      ),
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          createComment(
                                              widget.user.username,
                                              //comentarioController.text,
                                              commentText,
                                              postagem);
                                        });
                                      },
                                      child: const Text("Enviar comentário")),
                                  FutureBuilder<List<CommentsPostagem>>(
                                    future: fetchComments(postagem),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            color: Theme.of(context)
                                                .primaryColor, // Use theme color for consistency
                                          ),
                                        );
                                      }

                                      if (snapshot.hasError) {
                                        return Center(
                                          child: Text(
                                            'Error: ${snapshot.error}',
                                            style: TextStyle(
                                                color: Colors
                                                    .red), // Highlight error text
                                          ),
                                        );
                                      }

                                      if (!snapshot.hasData) {
                                        // Handle empty state (no comments)
                                        return Center(
                                          child: Text(
                                            'No comments found.',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: Colors
                                                    .blueGrey), // Subtle blue-gray text
                                          ),
                                        );
                                      }

                                      final comments =
                                          snapshot.data!; // Unwrap data safely

                                      return ListView.separated(
                                        // Use ListView.separated for built-in separator
                                        shrinkWrap:
                                            true, // Optimize for content size
                                        itemCount: comments.length,
                                        separatorBuilder: (context, index) =>
                                            const Divider(
                                          color: Colors
                                              .blueGrey, // Light blue separator
                                          height: 200, // Set separator height
                                        ),
                                        itemBuilder: (context, index) {
                                          final comment = comments[index];

                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5.0,
                                                vertical:
                                                    5.0), // Increased spacing
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start, // Align comment text
                                              children: [
                                                const SizedBox(
                                                    width:
                                                        8.0), // Spacing between avatar and text
                                                Expanded(
                                                  child: Text(
                                                    comment.text,
                                                    style: TextStyle(
                                                      fontSize:
                                                          16.0, // Adjust font size as needed
                                                      color: Colors.blueGrey[
                                                          800], // Darker blue text
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ]),
                              );
                            });
                      }
                      return Text('${snapshot.error}');
                    }))));
  }
}
