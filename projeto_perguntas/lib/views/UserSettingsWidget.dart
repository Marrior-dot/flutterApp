import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_perguntas/api/user.dart';
import 'package:projeto_perguntas/model/user.dart';
import 'package:projeto_perguntas/main.dart';
import 'package:projeto_perguntas/views/LoginPage.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class UserSettingsWidget extends StatefulWidget{
  final User user;
  final WebSocketChannel streamSocket;
  UserSettingsWidget({super.key, required this.user, required this.streamSocket});

  UserSettingsWidgetState createState() => UserSettingsWidgetState();
}

class UserSettingsWidgetState extends State<UserSettingsWidget>{

  final emailController = TextEditingController();
  final passWordController = TextEditingController();

  String errorStringEmail = "";
  bool passWordVisibility = false;

  late String? newPassword;
  late String? newEmail;
  
  final formKey = GlobalKey<FormState>();
  final regexSenha = RegExp(r'^(?=.*[A-Z])(?=.*[0-9])[a-zA-Z0-9]+$');
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

  dynamic checUserExistsIteration() async{
    await  checkUserExists(emailController.text.toString()).then((value){
        if(value == 200){
            errorStringEmail += 'Email já cadastrado';  
        }
      }).onError((error, stackTrace) => null);
}

  @override
  void initState() {
    super.initState();
    newPassword = widget.user.password;
    newEmail = widget.user.email;
  }

  @override
  Widget build(BuildContext context){  
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Editar Perfil', style: GoogleFonts.montserrat(fontSize:25, fontWeight: FontWeight.bold)),
          ),
      body: Center(
        child: 
        SingleChildScrollView(child:       
         Padding(
          padding: const EdgeInsets.all(16.0),
          child: 
          Form(
            key: formKey,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(child: Image.asset('assets/registro.png'), width: MediaQuery.of(context).size.width * 0.5 , height: MediaQuery.of(context).size.height * 0.25),
                  SizedBox(width: MediaQuery.of(context).size.width *0.03, height:MediaQuery.of(context).size.height *0.03),
                  Container(
                    width:  MediaQuery.of(context).size.width * 0.8,
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Nome"),
                        TextFormField(
                          readOnly: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: widget.user.name,
                              prefixIcon: Icon(Icons.login),
                            ),
              )
                      ],
                    ),
                  ),
                  Container(
                    width:  MediaQuery.of(context).size.width * 0.8,
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Nome de Usuário"),
                        TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: widget.user.username,
                              prefixIcon: Icon(Icons.supervised_user_circle),
                            ),
              )
                      ],
                    ),
                  ),
                  Container(
                    width:  MediaQuery.of(context).size.width * 0.8,
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Senha"),
                        TextFormField(
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    if (passWordVisibility == false) {
                                      passWordVisibility = true;
                                    } else {
                                      passWordVisibility = !passWordVisibility!;
                                    }
                                  });
                                },
                              ),
                              hintText: newPassword,
                              prefixIcon: Icon(Icons.password),
                            ),
                            controller: passWordController,
                            validator: (value){
                              String errorStringSenha = "";
                              if(value != "" && value!.length < 8){
                                errorStringSenha += 'A senha deve conter no mínimo 8 caracteres\n';
                              }

                              if(value != "" && value!= null && regexSenha.hasMatch(value) == false){
                                errorStringSenha += 'A senha deve conter ao menos uma letra maiúscula e um número\n';
                              }

                              return errorStringSenha != "" ? errorStringSenha : null;  
                            },
                            obscureText: passWordVisibility,
              )
                      ],
                    ),
                  ),
              Container(
                    width:  MediaQuery.of(context).size.width * 0.8,
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email"), 
                        TextFormField(
                  decoration: InputDecoration(
                    hintText: newEmail,
                    prefixIcon: Icon(Icons.email),
                    ),
                     controller: emailController,
                  validator: (value){
                    if(value != "" && value!= null && regexEmail.hasMatch(value)== false){
                      errorStringEmail += 'Por favor, digite um email válido\n';
                    }
                    return errorStringEmail != "" ? errorStringEmail : null;
                  },
                 )]
                  )),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                  child:Builder(
                    builder: (context) => Center(
                          child:
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: 50,
                            child:ElevatedButton(
                            style: cadastrarButtonStyle,
                            onPressed: () async{
                              errorStringEmail = "";
                              await checUserExistsIteration();
                              if (formKey.currentState!.validate()) {
                                return showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Dialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(12.0),
                                                ),
                                                elevation: 3.0,
                                                backgroundColor: Colors.white,
                                                child: Container(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: Column(
                                                    children: [
                                                      Text("Os dados serão modificados permanentemente, tem certeza que deseja alterá-los?"),
                                                      Row(
                                                        children: [
                                                          ElevatedButton(onPressed: ()
                                                          {
                                                          Navigator.of(context).pop();
                                                          }, 
                                                          child: Text("Cancelar")),
                                                          ElevatedButton(onPressed: ()
                                                          {
                                                            userEdit(widget.user.username, passWordController.text, emailController.text);
                                                            setState((){
                                                              newPassword = passWordController.text != "" ? passWordController.text : widget.user.password ;
                                                              newEmail = emailController.text != "" ? emailController.text : widget.user.email;
                                                              passWordController.text = "";
                                                              emailController.text = "";
                                                          });
                                                          Navigator.of(context).pop();
                                                          }, 
                                                          child: Text("Confirmar"))   
                                                        ])
                                                  ],)
                                                ),
                                              );
                                            },
);                                          
                              }
                            },
                            child: Text('Alterar Dados',style: GoogleFonts.openSans(fontSize:20, fontWeight: FontWeight.bold)),
                          )) ,
                        )) ),
                        Padding(
                          padding:EdgeInsets.only(top: 10.0),
                          child: Builder(
                            builder: (context) => Center(
                          child:
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: 50,
                            child:TextButton(onPressed: () async{
                              return showDialog(context: context,
                                            builder: (BuildContext context) {
                                              return Dialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(12.0),
                                                ),
                                                elevation: 3.0,
                                                backgroundColor: Colors.white,
                                                child: Container(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: Column(
                                                    children: [
                                                      Text("Os dados serão apagados permanentemente, tem certeza que deseja apagá-los?"),
                                                      Row(
                                                        children: [
                                                          ElevatedButton(onPressed: ()
                                                          {
                                                          Navigator.of(context).pop();
                                                          }, 
                                                          child: Text("Cancelar")),
                                                          ElevatedButton(onPressed: ()
                                                          async {
                                                          userDelete(widget.user.username);
                                                          //Navigator.push(context, MaterialPageRoute(
                                                          //  builder: (context) => MyApp()));
                                                          await widget.streamSocket.sink.close();
                                                          Navigator.pushNamed(
                                                              context, '/login');                                                          
                                                            }, 
                                                          child: Text("Confirmar"))   
                                                        ])
                                                  ],)
                                                ),
                                              );
                                            });
                                      
                                    },
                                    child: const Text(
                                        "Deletar Conta"))
                              ))
                  ))
                          ]
                          ))
         )
        )
      )
    );
  }
}