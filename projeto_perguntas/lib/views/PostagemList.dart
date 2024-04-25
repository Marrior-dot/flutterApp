import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:projeto_perguntas/model/postagem.dart' as postagem;
import 'package:projeto_perguntas/services/likeDislikeButton.dart';
import 'package:projeto_perguntas/services/fetchPosts.dart';
import 'package:projeto_perguntas/services/fetchComments.dart';
import 'package:projeto_perguntas/main.dart';
import 'dart:async';
import 'dart:convert';

  class PostagemList extends StatefulWidget{
  const PostagemList({super.key});

  State<PostagemList> createState() => PostagemListState();

}

class PostagemListState extends State<PostagemList>{
   late Future<List<postagem.Postagem>> futureFetch;
   var comentarioController = TextEditingController();

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
          child: FutureBuilder<List<postagem.Postagem>>(
            future: futureFetch,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index){
                    var likeButton = snapshot.data![index].likes;                    
                    return Container(
                      height: 50,
                          child: Column(
                          children: [
                          Text(snapshot.data![index].content),
                            Row(children: [
                              ElevatedButton(
                                onPressed: (){
                                  updateLikeDislike('dislikes', snapshot.data![index].dislikes, snapshot.data![index].id);
                                },
                                child: const Text('dislikes'),
                              ),ElevatedButton(
                                onPressed:(){
                                  setState(() {
                                    likeButton = likeButton + 1;
                                    updateLikeDislike('likes', likeButton,snapshot.data![index].id);
                                    });

                                } ,
                                child:FutureBuilder<postagem.Postagem>(
                                  future: fetchLike(snapshot.data![index].id),
                                  builder: (context, snapshot){
                                    return Text("likes ${snapshot.data!.likes}");
                                  }
                                )
                ),
              ]),
              FutureBuilder(future: fetchComments(), builder: (context, snapshot){
                
              })
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Escreva um comentário"

                ),
                controller: comentarioController,
              )],
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
/*
  late Future<List<postagem.Postagem>> likeFetch;
  //final List<postagem.Postagem> posts;
   void incrementLikes(int button ,int id){
    setState(() {
      actionButton.updateLikeDislike('likes', button, id);
    });
  }


  @override
  Widget build(BuildContext context) {

  return  ListView.builder(
  padding: const EdgeInsets.all(8),
  itemCount: widget.posts.length,
  itemBuilder: (context, index){
    return Container(
            height: 50,
            child: Column(
            children: [
            Text(widget.posts[index].content),
              Row(children: [
                          //Navigator.pushNamed(context,'/user/${userName}/feed');
                ElevatedButton(
                  onPressed: (){
                    actionButton.updateLikeDislike('dislikes', widget.posts[index].dislikes, widget.posts[index].id);
                  },
                  child: const Text('dislikes'),
                ),ElevatedButton(
                  onPressed:(){
                    setState(() {
                      likeButtons[index]++;
                      //incrementLike(, id)
                      //actionButton.updateLikeDislike('likes', likeButton, widget.posts[index].id);
                      actionButton.updateLikeDislike('likes', likeButtons[index], widget.posts[index].id);
                      });
                      
                  } ,
                  child:Text('like ${likeButtons[index]}'),
                ),
              ])],
            
            ),
    );
  },
  );*/
  }