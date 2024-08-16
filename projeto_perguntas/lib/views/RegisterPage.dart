import 'dart:async';

import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:projeto_perguntas/services/userCreate.dart';
import 'package:projeto_perguntas/model/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_perguntas/services/userLogin.dart';
import 'package:projeto_perguntas/views/PostagemList.dart';
import 'package:projeto_perguntas/services/checkUserExists.dart';

class RegisterPage extends StatefulWidget{
  const RegisterPage({super.key});

    State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage>{
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final passWordController = TextEditingController();
  late int checkingUserExists;

  final formKey = GlobalKey<FormState>();
  final regexSenha = RegExp(r'^[a-zA-Z]+$[0-9]*[A-Z]*');
  //final regexEmail = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]$');
  final regexEmail = RegExp(r'[\w.%+-]+@[A-Za-z0-9.-].[a-zA-Z]+');

  final cadastrarButtonStyle = ElevatedButton.styleFrom(
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
  void initState() {
    super.initState();
    checkingUserExists = 0;
  }

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cadastro', style: GoogleFonts.montserrat(fontSize:40, fontWeight: FontWeight.bold) ),
          ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: 
          Form(
            key: formKey,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(child: Image.asset('assets/registro.png'), width: MediaQuery.of(context).size.width * 0.5 , height: MediaQuery.of(context).size.height * 0.25),
              SizedBox(width:1 , height: 5),
              Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Colors.grey, width: 1.0)),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    prefixIcon: Icon(Icons.login),
                  ),
                  controller: nameController,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Por favor, digite seu nome';
                    }
                  
                    if(checkingUserExists == 200){
                      return 'Nome já cadastrado';
                    }

                    return null;
                  },)),
                  SizedBox(width: MediaQuery.of(context).size.width *0.03, height:MediaQuery.of(context).size.height *0.03),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Colors.grey, width: 1.0)),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: Icon(Icons.password),
                ),
                controller: passWordController,
                validator: (value){
                  String errorStringSenha = "";
                  if(value == null || value.isEmpty){
                    return 'Por favor, digite sua senha';
                  }

                  if(value.length < 8){
                    errorStringSenha += 'A senha deve conter no mínimo 8 caracteres\n';
                  }

                  if(!regexSenha.hasMatch(value)){
                    errorStringSenha += 'A senha deve conter ao menos uma letra maiúscula e um número\n';
                  }

                  if (errorStringSenha != "") {
                    return errorStringSenha;
                  }

                  return null;
                },
                obscureText: true,
              )),                  
              SizedBox(width: MediaQuery.of(context).size.width *0.03, height:MediaQuery.of(context).size.height *0.03),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Colors.grey, width: 1.0)),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Por favor, digite seu email';
                    }
                    if(!regexEmail.hasMatch(value)){
                      return 'Por favor, digite um email válido';
                    }

                    return null;
                  },
                  controller: emailController)),                 
                  SizedBox(width: MediaQuery.of(context).size.width *0.03, height:MediaQuery.of(context).size.height *0.03),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Colors.grey, width: 1.0)),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nome de Usuario',
                  prefixIcon: Icon(Icons.supervised_user_circle),
                ),
                controller: userNameController,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Por favor, digite seu nome de usuário';
                  }
                  if(value.length < 8){
                    return 'O nome de usuário deve conter no mínimo 8 caracteres';
                  }
                  //checkUserExists(value).then((value){
                  //    if (value == 200){
                  //      return 'Nome de usuário já cadastrado';
                  //    }
                  //  });
                  return null;
                },
              )),              
              const SizedBox(height: 20.0),
              const SizedBox(height: 20.0),
              Builder(
                  builder: (context) => Center(
                        child:
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: 50,
                          child:ElevatedButton(
                          style: cadastrarButtonStyle,
                          onPressed: () {
                            if (formKey.currentState!.validate()){
                            userCreate(
                                userNameController.text.toString(),
                                emailController.text.toString(),
                                passWordController.text.toString(),
                                nameController.text.toString()).then((value){
                                    userLogin(userNameController.text, passWordController.text).then((value) { 
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => PostagemList(
                                                    user: value,
                                                  )),
                                              );
                                        });
                                });
                            }
                          },
                          child: Text('Cadastrar',style: GoogleFonts.openSans(fontSize:24, fontWeight: FontWeight.bold)),
                        )) ,
                      ))
            ],
          ),
        ),
      ),
    )
    );
  }
}
/*
class RegisterPage extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final passWordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final regexSenha = RegExp(r'^[a-zA-Z]+$[0-9]*[A-Z]*');
  final regexEmail = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]$');

  RegisterPage({super.key});
  final cadastrarButtonStyle = ElevatedButton.styleFrom(
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
  Widget build(BuildContext context) {  
    int checkingUserExists = 0;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cadastro', style: GoogleFonts.montserrat(fontSize:40, fontWeight: FontWeight.bold) ),
          ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: 
          Form(
            key: formKey,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(child: Image.asset('assets/registro.png'), width: MediaQuery.of(context).size.width * 0.5 , height: MediaQuery.of(context).size.height * 0.25),
              SizedBox(width:1 , height: 5),
              Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Colors.grey, width: 1.0)),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    prefixIcon: Icon(Icons.login),
                  ),
                  controller: nameController,
                  validator: (value){
                    FutureBuilder<int>(
                      future: checkUserExists(value),
                      builder: (context, snapshot)
                      {
                        if(snapshot.data! == 200){
                          checkingUserExists = snapshot.data!;
                        }
                        return EmptyWidget();
                      },
                    );
                    
                    if(checkingUserExists == 200){
                      return 'Nome já cadastrado';
                    }

                    if(value == null || value.isEmpty){
                      return 'Por favor, digite seu nome';
                    }
                    return null;
                  },)),
                  SizedBox(width: MediaQuery.of(context).size.width *0.03, height:MediaQuery.of(context).size.height *0.03),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Colors.grey, width: 1.0)),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: Icon(Icons.password),
                ),
                controller: passWordController,
                validator: (value){
                  String errorStringSenha = "";
                  if(value == null || value.isEmpty){
                    return 'Por favor, digite sua senha';
                  }

                  if(value.length < 8){
                    errorStringSenha += 'A senha deve conter no mínimo 8 caracteres\n';
                  }

                  if(!regexSenha.hasMatch(value)){
                    errorStringSenha += 'A senha deve conter ao menos uma letra maiúscula e um número\n';
                  }

                  if (errorStringSenha != "") {
                    return errorStringSenha;
                  }

                  return null;
                },
                obscureText: true,
              )),                  
              SizedBox(width: MediaQuery.of(context).size.width *0.03, height:MediaQuery.of(context).size.height *0.03),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Colors.grey, width: 1.0)),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Por favor, digite seu email';
                    }
                    if(!regexEmail.hasMatch(value)){
                      return 'Por favor, digite um email válido';
                    }
                    checkUserExists(value).then((value){
                      if (value == 200){
                        return 'Email já cadastrado';
                      }
                    });

                    return null;
                  },
                  controller: emailController)),                 
                  SizedBox(width: MediaQuery.of(context).size.width *0.03, height:MediaQuery.of(context).size.height *0.03),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Colors.grey, width: 1.0)),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nome de Usuario',
                  prefixIcon: Icon(Icons.supervised_user_circle),
                ),
                controller: userNameController,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Por favor, digite seu nome de usuário';
                  }
                  if(value.length < 8){
                    return 'O nome de usuário deve conter no mínimo 8 caracteres';
                  }
                  checkUserExists(value).then((value){
                      if (value == 200){
                        return 'Nome de usuário já cadastrado';
                      }
                    });
                  return null;
                },
              )),              
              const SizedBox(height: 20.0),
              const SizedBox(height: 20.0),
              Builder(
                  builder: (context) => Center(
                        child:
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: 50,
                          child:ElevatedButton(
                          style: cadastrarButtonStyle,
                          onPressed: () {
                            if (formKey.currentState!.validate()){
                            userCreate(
                                userNameController.text.toString(),
                                emailController.text.toString(),
                                passWordController.text.toString(),
                                nameController.text.toString());
                                userLogin(userNameController.text, passWordController.text).then((value) { 
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => PostagemList(
                                                    user: value,
                                                  )),
                                              );
                                          
                                        });
                            //Navigator.pop(context);
                            }
                          },
                          child: Text('Cadastrar',style: GoogleFonts.openSans(fontSize:24, fontWeight: FontWeight.bold)),
                        )) ,
                      ))
            ],
          ),
        ),
      ),
    )
    );
  }
}
*/