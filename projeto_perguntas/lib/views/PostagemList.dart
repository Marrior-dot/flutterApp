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
  final TextEditingController comentarioController = TextEditingController();
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
                        //final TextEditingController comentarioController =
                        //  TextEditingController();
                        return ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              var likeButton = snapshot.data![index].likes;
                              late var postagem = snapshot.data![index];
                              return SizedBox(
                                height: 130,
                                child: Column(children: [
                                  Text(snapshot.data![index].content),
                                  Row(children: [
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
                                      controller: comentarioController),
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          createComment(
                                              widget.user.username,
                                              comentarioController.text
                                                  .toString(),
                                              postagem);
                                        });
                                      },
                                      child: const Text("Enviar comentário")),
                                  /*FutureBuilder<List<CommentsPostagem>>(
                                    future: fetchComments(postagem),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      if (snapshot.hasData) {
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: snapshot.data!.length,
                                          itemBuilder: (context, index) {
                                            return Text(
                                                snapshot.data![index].text);
                                          },
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text('${snapshot.error}');
                                      } else {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                  ),*/
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
                                          height: 5.0, // Set separator height
                                        ),
                                        itemBuilder: (context, index) {
                                          final comment = comments[index];

                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 24.0,
                                                vertical:
                                                    30.0), // Increased spacing
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start, // Align comment text
                                              children: [
                                                //CircleAvatar(
                                                //  backgroundColor: Colors.blueGrey[200], // Placeholder avatar color
                                                //  backgroundImage: comment.user?.avatarUrl != null
                                                //      ? NetworkImage(comment.user!.avatarUrl!)
                                                //      : null, // Use user's avatar if available
                                                //),
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
