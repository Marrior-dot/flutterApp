import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto_perguntas/model/postagem.dart' as postagem;
import 'package:projeto_perguntas/services/fetchPosts.dart' as fetch;
import 'package:projeto_perguntas/views/PostagemList.dart' as PostagemList;
import 'package:projeto_perguntas/views/LoginPage.dart';
import 'package:projeto_perguntas/services/likeDislikeButton.dart';


void main() {
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

  //@override
  //Widget build(BuildContext context) {
  // return MaterialApp(home: LoginPage());
  //}
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
/*
class _MyHomePageState extends State<MyApp> {
  final TextEditingController _controller = TextEditingController();
  final _channel = WebSocketChannel.connect(
    //Uri.parse('wss://echo.websocket.events'),
    Uri.parse('http://localhost:8000/api/postagemlist/')
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Send a message'),
              ),
            ),
            const SizedBox(height: 24),
            StreamBuilder(
              stream: _channel.stream,
              builder: (context, snapshot) {
                return Text(snapshot.hasData ? '${snapshot.data}' : '');
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: const Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      _channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    _controller.dispose();
    super.dispose();
  }
}
*/
