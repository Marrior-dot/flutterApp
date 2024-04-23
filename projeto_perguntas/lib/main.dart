import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto_perguntas/model/postagem.dart' as postagem;
import 'package:projeto_perguntas/services/fetchPosts.dart' as fetch;
import 'package:projeto_perguntas/views/PostagemList.dart' as PostagemList;
import 'package:projeto_perguntas/views/LoginPage.dart';
import 'package:projeto_perguntas/services/likeDislikeButton.dart';



void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget /*StatelessWidget*/ {

  const MyApp({
    super.key,
  });

  final String title="Web Socket Demo";

  @override
  //State<MyApp> createState() => LoginPage();
  //State<MyApp> createState() => _MyHomePageState();
  State<MyApp> createState() => _MyAppState();

}

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
                return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index){
                    fetchLike(snapshot.data![index].id);
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
              ])],
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

  convertFutureToint(Future<int> futureInt) async{
    return await futureInt;
  }
}