import 'package:flutter/material.dart';
import 'package:projeto_perguntas/views/RegisterPage.dart';
import 'package:projeto_perguntas/model/user.dart';
import 'package:projeto_perguntas/services/userLogin.dart';
import 'package:projeto_perguntas/views/PostagemList.dart';
import 'package:projeto_perguntas/main.dart';

class LoginPage extends State<MyApp> {
  final userNameController = TextEditingController();
  final passWordController = TextEditingController();
  late Future<User> usuarioLogado;
  int? userId;

  @override
  void dispose() {
    userNameController.dispose();
    passWordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          "/registrar": (context) => RegisterPage(),
          "/user/${userId}/feed": (context) => PostagemList()
        },
        home: Scaffold(
          appBar: AppBar(
            title: Text('Bem-vindo ao (Nome da Aplicação)'),
          ),
          body: Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Usuário',
                      prefixIcon: Icon(Icons.login),
                    ),
                    controller: userNameController,
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                    controller: passWordController,
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                      child: Text("Login"),
                      onPressed: () {
                      //if  (userLogin(userNameController.text.toString(),passWordController.text.toString()));
                      print(userLogin(userNameController.text.toString(),passWordController.text.toString()));
                      
                      //Navigator.pushNamed(context, )
                      }),
                  Builder(
                      builder: (context) => Center(
                           child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/registrar');
                                },
                                child: Text("Não tem Cadastro? Clique aqui")),
                          ))
                ],
              ),
            ),
          ),
        ));
  }
}
