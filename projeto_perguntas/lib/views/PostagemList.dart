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

  TextEditingController controllerComments(){
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
                              var postagem = snapshot.data![index];
                              comentarioController = controllerComments();

                              return SizedBox(
                                width: MediaQuery.of(context).size.width*0.4,
                                height:MediaQuery.of(context).size.height*0.5, //200,
                                child: Column(children: 
                                [Text(snapshot.data![index].content),
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    Flexible(
      child: ElevatedButton(
        onPressed: () {
          updateLikeDislike(
              'dislikes',
              snapshot.data![index].dislikes,
              snapshot.data![index].id,
              snapshot.data![index].content);
        },
        child: const Text('dislikes'),
      ),
    ),
    Flexible(
      child: ElevatedButton(
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
              future: fetchLike(snapshot.data![index].id),
              builder: (context, snapshot) {
                return Text(
                  "likes ${snapshot.data!.likes}");
              })),
    ),
  ],
),
Flexible(
  child: TextFormField(
    decoration: const InputDecoration(
      contentPadding: EdgeInsets.all(5),
      labelText: 'Escreva seu comentário',
      prefixIcon: Icon(Icons.comment),
    ),
    controller: comentarioController,
    onChanged: (value) => commentText = value,
  ),
),
ElevatedButton(
  onPressed: () {
    setState(() {
      createComment(
          widget.user.username,
          commentText,
          postagem);
    });
  },
  child: const Text("Enviar comentário")),
Flexible(
  child: FutureBuilder<List<CommentsPostagem>>(
    future: fetchComments(postagem),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
          return Flexible(
      child: ListView.separated(
        itemCount: snapshot.data!.length,
        separatorBuilder: (context, index) => const Divider(
          color: Colors.grey,
          thickness: 1.0, // Adjust divider thickness as needed
        ),
        itemBuilder: (context, index) {
          final item = snapshot.data![index].text;
          return ListTile(
            title: Text(item),
            trailing: Icon(Icons.arrow_right), // Add a trailing icon
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
                            }
                          );
                      }
                      return Text('${snapshot.error}');
                    }
                  )
                )
              )
            );
  }
}
