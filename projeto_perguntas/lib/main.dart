import 'dart:io';
import 'package:flutter/material.dart';
import 'package:projeto_perguntas/model/postagem.dart' as postagem;
import 'package:projeto_perguntas/services/fetch.dart' as fetch;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Aq começam as postagens");
    print(fetch.fetchPostagem());
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('Bem-vindo ao (Nome da Aplicação)'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Handle login button press
                },
                child: Text('Login'),
              ),
              TextButton(
                  onPressed: null, child: Text("Não tem Cadastro? Clique aqui"))
            ],
          ),
        ),
      ),
    );
  }
}

/*
class FirstRoute extends StatelessWidget {

  const FirstRoute({super.key})

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar,
    )
  }

}*/
