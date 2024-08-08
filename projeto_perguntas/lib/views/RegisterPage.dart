import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projeto_perguntas/services/userCreate.dart';
import 'package:projeto_perguntas/model/user.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final passWordController = TextEditingController();

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cadastro', style: GoogleFonts.montserrat(fontSize:40, fontWeight: FontWeight.bold) ),
          ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                  controller: nameController)),
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
                            userCreate(
                                userNameController.text.toString(),
                                emailController.text.toString(),
                                passWordController.text.toString(),
                                nameController.text.toString());
                            Navigator.pop(context);
                          },
                          child: Text('Cadastrar',style: GoogleFonts.openSans(fontSize:24, fontWeight: FontWeight.bold)),
                        )) ,
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
