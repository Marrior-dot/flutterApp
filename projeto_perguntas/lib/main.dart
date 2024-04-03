import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto_perguntas/model/postagem.dart' as postagem;
import 'package:projeto_perguntas/services/fetch.dart' as fetch;
import 'package:projeto_perguntas/views/PostagemList.dart' as PostagemList;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget /*StatelessWidget */ {
  @override
  State<MyApp> createState() => _MyAppState();
  /*@override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }*/
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
                return PostagemList.PostagemList(posts: snapshot.data!);
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