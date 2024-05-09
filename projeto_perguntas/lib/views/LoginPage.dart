import 'package:flutter/material.dart';
import 'package:projeto_perguntas/views/RegisterPage.dart';
import 'package:projeto_perguntas/services/userLogin.dart';
import 'package:projeto_perguntas/views/PostagemList.dart';
import 'package:projeto_perguntas/main.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends State<MyApp> {
  final userNameController = TextEditingController();
  final passWordController = TextEditingController();

  final elevatedButtonStyle = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5.0),
    ),
    side: BorderSide(color: Colors.deepPurple, width: 0.5),
    textStyle: TextStyle(
      color: const Color.fromARGB(255, 68, 29, 74), fontSize: 40
    ),
    backgroundColor: Colors.white
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
          appBar:AppBar(
            centerTitle: true,
            title: Text('Bem-vindo ao (Nome da Aplicação)', style: GoogleFonts.montserrat(fontSize:40, fontWeight: FontWeight.bold) ),
          ), 
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(child: Image.asset('assets/login.png'), width: MediaQuery.of(context).size.width * 0.5 , height: MediaQuery.of(context).size.height * 0.25),
                  SizedBox(width:1 , height: 5),
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
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: 50,
                              child: ElevatedButton(
                                style: elevatedButtonStyle,
                                child:  Text("Login", style: GoogleFonts.openSans(fontSize:24, fontWeight: FontWeight.bold)),
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
                            )
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
