import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:projeto_perguntas/model/postagem.dart' as postagem;
import 'package:projeto_perguntas/services/likeDislikeButton.dart' as actionButton;
import 'package:projeto_perguntas/services/fetchPosts.dart' as fetch;
import 'package:projeto_perguntas/main.dart';
import 'dart:async';
import 'dart:convert';
/*
class _MyAppState extends State<MyApp> {
  late Future<List<postagem.Postagem>> futureFetch;

  @override
  void initState() {
    super.initState();
    futureFetch = fetch.fetchPostagem();
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
                return PostagemList(posts: snapshot.data!);
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
*/
//class PostagemList extends  StatelessWidget {
  class PostagemList extends StatefulWidget{
  const PostagemList({super.key, required this.posts});

  State<PostagemList> createState() => PostagemListState();

  final List<postagem.Postagem> posts;
}

class PostagemListState extends State<PostagemList>{

  late Future<List<postagem.Postagem>> likeFetch;
  //final List<postagem.Postagem> posts;
   void incrementLikes(int button ,int id){
    setState(() {
      actionButton.updateLikeDislike('likes', button, id);
    });
  }


  @override
  Widget build(BuildContext context) {
  late List<int> likeButtons = getLikesList(); 

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
  );
  }

  List<int> getLikesList(){
    List<int> likesList = [];
    for (int counter = 0; counter < widget.posts.length; counter++){
      likesList.add(widget.posts[counter].likes);
    }
    return likesList;
  }
}