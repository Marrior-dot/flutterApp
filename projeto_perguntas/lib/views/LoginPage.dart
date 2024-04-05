import 'package:flutter/material.dart';
import 'package:projeto_perguntas/views/RegisterPage.dart' as RegisterPage;

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

                },
                child: Text('Login'),
              ),
              TextButton(
                  onPressed:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage.RegisterPage()));
                  } 
                  , child: Text("Não tem Cadastro? Clique aqui"))
            ],
          ),
        ),
      ),
    );
  }
}