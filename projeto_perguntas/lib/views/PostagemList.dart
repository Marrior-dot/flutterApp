import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:projeto_perguntas/model/postagem.dart' as postagem;
import 'package:projeto_perguntas/services/likeDislikeButton.dart' as actionButton;
import 'package:projeto_perguntas/services/fetchPosts.dart' as fetch;
import 'package:projeto_perguntas/main.dart';

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
                  onPressed: (){
                    actionButton.updateLikeDislike('dislikes', posts[index].dislikes, posts[index].id);
                  },
                  child: const Text('dislikes'),
                ),ElevatedButton(
                  onPressed:(){
                    actionButton.updateLikeDislike('likes', posts[index].likes, posts[index].id);
                  } ,
                  child:Text('likes ${posts[index].likes}') ,
                ),
              ])],
            
            ),
    );
  },
  );
  }
}