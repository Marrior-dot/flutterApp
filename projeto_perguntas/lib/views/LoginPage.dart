import 'package:flutter/material.dart';
import 'package:projeto_perguntas/views/RegisterPage.dart';
import 'package:projeto_perguntas/services/userLogin.dart';
import 'package:projeto_perguntas/views/PostagemList.dart';
import 'package:projeto_perguntas/main.dart';

class LoginPage extends State<MyApp> {
  final userNameController = TextEditingController();
  final passWordController = TextEditingController();
  //late Future<User> usuarioLogado;
  //String? userName;

  final loginButtonStyle = ButtonStyle(
    foregroundColor: MaterialStateProperty.all(Colors.white),
  );

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
          //"/user/${userName}/feed": (context) => PostagemList()
        },
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Bem-vindo ao (Nome da Aplicação)'),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Colors.grey, width: 1.0)),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Usuário',
                          prefixIcon: Icon(Icons.login),
                        ),
                        controller: userNameController,
                      )),
                  const SizedBox(height: 40.0),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Colors.grey, width: 1.0)),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Senha',
                          prefixIcon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                        controller: passWordController,
                      )),
                  const SizedBox(height: 20.0),
                  Builder(
                      builder: (context) => Center(
                            child: ElevatedButton(
                                style: loginButtonStyle,
                                child: const Text("Login"),
                                onPressed: () {
                                  userLogin(userNameController.text.toString(),
                                      passWordController.text.toString());
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              FutureBuilder(
                                                  future: userLogin(
                                                      userNameController.text
                                                          .toString(),
                                                      passWordController.text
                                                          .toString()),
                                                  builder:
                                                      (BuildContext context,
                                                              AsyncSnapshot
                                                                  snapshot) =>
                                                          PostagemList(
                                                              user: snapshot
                                                                  .data!))));
                                }),
                          )),
                  Builder(
                      builder: (context) => Center(
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/registrar');
                                },
                                child: const Text(
                                    "Não tem Cadastro? Clique aqui")),
                          ))
                ],
              ),
            ),
          ),
        ));
  }
}
