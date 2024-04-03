import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:projeto_perguntas/model/postagem.dart' as postagem;
import 'package:projeto_perguntas/services/likeDislikeButton.dart' as actionButton;

class PostagemList extends StatelessWidget {
  const PostagemList({super.key, required this.posts});

  final List<postagem.Postagem> posts;

  @override
  Widget build(BuildContext context) {
  return  ListView.builder(
  padding: const EdgeInsets.all(8),
  itemCount: posts.length,
  itemBuilder: (context, index){
    return Container(
            height: 50,
            child: Column(
            children: [//Image.asset(posts[index].arquivo),
            Text(posts[index].content),
              Row(children: [
                ElevatedButton(
                  onPressed: null,
                  child:
                    //Image(image:AssetImage('gostar.png')) 
                  const Text('Disabled'),
                ),ElevatedButton(
                  onPressed:(){
                    actionButton.updateLikeDislike('likes', posts[index].likes, posts[index].id);
                  } ,
                  child: const Text('likes'),
                ),
              ])],
            
            ),
    );
  },
  );
  }
}