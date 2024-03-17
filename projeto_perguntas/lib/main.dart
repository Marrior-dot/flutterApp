import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<String> perguntas = ["pergunas1", "pergunta2"];
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text("Perguntas")),
            body: Column(children: [
              Text("Olá FLutter"),
              Text("Olá FLutter2"),
              Text("Olá FLutter3"),
              ElevatedButton(onPressed: null, child: Text("Resposta 1"))
            ])));
  }
}
