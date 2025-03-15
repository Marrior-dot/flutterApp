import 'package:flutter/material.dart';
import 'package:projeto_perguntas/views/RegisterPage.dart';
import 'package:projeto_perguntas/api/user.dart';
import 'package:projeto_perguntas/views/PostagemList.dart';
import 'package:projeto_perguntas/main.dart';
import 'package:google_fonts/google_fonts.dart';

/// Página de Login do aplicativo Projeto Perguntas.
///
/// Esta página permite que os usuários façam login no aplicativo usando seu nome de usuário e senha.
/// Fornece campos de texto para nome de usuário e senha, validação de formulário e navegação para a página de registro.
class LoginPage extends State<MyApp> {
  /// Controlador para o campo de texto do nome de usuário.
  final userNameController = TextEditingController();

  /// Controlador para o campo de texto da senha.
  final passWordController = TextEditingController();

  /// Chave global para o formulário, usada para validação.
  final formKey = GlobalKey<FormState>();

  /// Variável para controlar a visibilidade da senha.
  bool passWordVisibility = true;

  /// Estilo para o botão de login.
  final elevatedButtonStyle = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      side: BorderSide(color: Colors.deepPurple, width: 0.5),
      textStyle:
          TextStyle(color: const Color.fromARGB(255, 68, 29, 74), fontSize: 40),
      backgroundColor: Colors.white);

  /// Método chamado quando o State é descartado, liberando os recursos dos controladores.
  @override
  void dispose() {
    userNameController.dispose();
    passWordController.dispose();
    super.dispose();
  }

  /// Constrói o widget da página de login.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, // Remove a faixa de depuração
        routes: {
          // Define as rotas nomeadas para navegação
          "/registrar": (context) =>
              RegisterPage(), // Rota para a página de cadastro
          "/login": (context) => MyApp(), // Rota para a página de login
        },
        home: Scaffold(
            appBar: AppBar(
              centerTitle: true, // Centraliza o título na AppBar
              title: Text('Bem-vindo ao (Nome da Aplicação)',
                  style: GoogleFonts.montserrat(
                      fontSize: 40, fontWeight: FontWeight.bold)),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey, // Define a chave global para o formulário
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Alinha os elementos no centro verticalmente
                    children: [
                      SizedBox(
                          child: Image.asset(
                              'assets/login.png'), // Exibe a imagem de login
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.25),
                      SizedBox(width: 1, height: 5),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Usuário', // Rótulo do campo de texto
                              prefixIcon: Icon(Icons.login), // Ícone prefixo
                            ),
                            controller:
                                userNameController, // Define o controlador para o campo de texto
                            validator: (value) {
                              // Função de validação
                              value = userNameController.text;
                              //Se valor for vazio ou nulo, retorna uma mensagem de erro
                              if (value.isEmpty || value == null) {
                                return 'Por favor entre o nome de usuário'; // Mensagem de erro
                              }
                              return null; // Retorna nulo se a validação passar
                            },
                          )),
                      const SizedBox(height: 40.0),
                      Container(
                          width: MediaQuery.of(context).size.width *
                              0.8, // Define a largura do container
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Senha', // Rótulo do campo de texto
                              prefixIcon: Icon(Icons.lock), // Ícone prefixo
                              // Ícone sufixo para alternar a visibilidade da senha
                              suffixIcon: IconButton(
                                // Ícone sufixo
                                icon: Icon(
                                    Icons.visibility), // Ícone de visibilidade
                                onPressed: () {
                                  // Função chamada ao pressionar o ícone
                                  setState(() {
                                    // Atualiza o estado do widget
                                    passWordVisibility =
                                        !passWordVisibility; // Alterna a visibilidade da senha
                                  });
                                },
                              ),
                            ),
                            obscureText:
                                // Define se a senha deve ser obscurecida
                                // true, para senha visível, false, para senha oculta
                                passWordVisibility,
                            controller:
                                passWordController, // Define o controlador para o campo de texto
                            validator: (value) {
                              // Função de validação
                              value = passWordController.text;
                              //Se valor for vazio ou nulo, retorna uma mensagem de erro
                              if (value.isEmpty || value == null) {
                                return 'Por favor insira a senha'; // Mensagem de erro
                              }
                              return null; // Retorna nulo se a validação passar
                            },
                          )),
                      const SizedBox(height: 20.0),
                      Builder(
                          // Widget Builder para acessar o contexto
                          builder: (context) => Center(
                                  // Centraliza o botão
                                  child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                height: 50,
                                child: ElevatedButton(
                                    style:
                                        elevatedButtonStyle, // Define o estilo do botão
                                    child: Text("Login", // Texto do botão
                                        style: GoogleFonts.openSans(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold)),
                                    onPressed: () {
                                      // Função chamada ao pressionar o botão
                                      if (formKey.currentState!.validate()) {
                                        // Valida o formulário
                                        // Realiza o login do usuário
                                        userLogin(userNameController.text,
                                                passWordController.text)
                                            .then((value) {
                                          // Navega para a página PostagemList
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PostagemList(
                                                      user: value,
                                                    )),
                                          );
                                        }).catchError((error) {
                                          // Exibe uma mensagem de erro se o login falhar
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Usuário ou senha inválidos')),
                                          );
                                        });
                                      }
                                    }),
                              ))),
                      Builder(
                          // Widget Builder para acessar o contexto
                          builder: (context) => Center(
                                // Centraliza o botão
                                child: TextButton(
                                    // Botão de texto
                                    onPressed: () {
                                      // Função chamada ao pressionar o botão
                                      Navigator.pushNamed(context,
                                          '/registrar'); // Navega para a rota "/registrar"
                                    },
                                    child: const Text(// Texto do botão
                                        "Não tem Cadastro? Clique aqui")),
                              ))
                    ],
                  ),
                ),
              ),
            )));
  }
}
