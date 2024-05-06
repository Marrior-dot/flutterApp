import 'package:flutter/material.dart';
import 'package:projeto_perguntas/services/userCreate.dart';
import 'package:projeto_perguntas/model/user.dart';

class RegisterPage extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final passWordController = TextEditingController();

  late Future<User> usuarioLogado;

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //title: Text('Bem-vindo ao (Nome da Aplicação)'),
          ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    prefixIcon: Icon(Icons.email),
                  ),
                  controller: nameController),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: Icon(Icons.email),
                ),
                controller: passWordController,
                obscureText: true,
              ),
              TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  controller: emailController),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nome de Usuario',
                  prefixIcon: Icon(Icons.lock),
                ),
                controller: userNameController,
              ),
              const SizedBox(height: 20.0),
              Builder(
                  builder: (context) => Center(
                        child: ElevatedButton(
                          onPressed: () {
                            userCreate(
                                userNameController.text.toString(),
                                emailController.text.toString(),
                                passWordController.text.toString(),
                                nameController.text.toString());
                            Navigator.pop(context);
                          },
                          child: const Text('Cadastrar'),
                        ),
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
