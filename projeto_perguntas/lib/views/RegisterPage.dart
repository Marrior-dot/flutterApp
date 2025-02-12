import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_perguntas/views/PostagemList.dart';
import 'package:projeto_perguntas/api/user.dart';

/// Página de registro de novos usuários.
class RegisterPage extends StatefulWidget {
  /// Construtor da classe RegisterPage.
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  /// Controlador para o campo de nome.
  final nameController = TextEditingController();

  /// Controlador para o campo de email.
  final emailController = TextEditingController();

  /// Controlador para o campo de nome de usuário.
  final userNameController = TextEditingController();

  /// Controlador para o campo de senha.
  final passWordController = TextEditingController();

  /// String para exibir mensagens de erro relacionadas ao nome.
  String errorStringNome = "";

  /// String para exibir mensagens de erro relacionadas ao email.
  String errorStringEmail = "";

  /// String para exibir mensagens de erro relacionadas ao nome de usuário.
  String errorStringUserName = "";

  /// Variável booleana para controlar a visibilidade da senha.
  bool passWordVisibility = true;

  /// Chave global para o formulário. Usada para validação.
  final formKey = GlobalKey<FormState>();

  /// Expressão regular para validar a senha.
  final regexSenha = RegExp(r'^(?=.*[A-Z])(?=.*[0-9])[a-zA-Z0-9]+');

  /// Expressão regular para validar o email.
  final regexEmail = RegExp(r'[\w.%+-]+@[A-Za-z0-9.-].[a-zA-Z]+');

  /// Estilo do botão de cadastro.
  final cadastrarButtonStyle = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
    side: const BorderSide(color: Colors.deepPurple, width: 0.5),
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 68, 29, 74),
      fontSize: 40,
    ),
    backgroundColor: Colors.white,
  );

  /// Função assíncrona que verifica se o nome, email e nome de usuário já existem no banco de dados.
  Future<void> checUserExistsIteration() async {
    // Chamada assíncrona para verificar a existência do nome.
    await checkUserExists(nameController.text.toString()).then((value) {
      if (value == 200) {
        errorStringNome += 'Nome já cadastrado';
      }
    }).onError((error, stackTrace) => null);
    // Chamada assíncrona para verificar a existência do email.
    await checkUserExists(emailController.text.toString()).then((value) {
      if (value == 200) {
        errorStringEmail += 'Email já cadastrado';
      }
    }).onError((error, stackTrace) => null);
    // Chamada assíncrona para verificar a existência do nome de usuário.
    await checkUserExists(userNameController.text.toString()).then((value) {
      if (value == 200) {
        errorStringUserName += 'Nome de usuário já cadastrado';
      }
    }).onError((error, stackTrace) => null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Cadastro',
          style:
              GoogleFonts.montserrat(fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    child: Image.asset('assets/registro.png'),
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.25,
                  ),
                  const SizedBox(width: 1, height: 5),

                  /// Campo de texto para o nome.
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                        prefixIcon: Icon(Icons.login),
                      ),
                      controller: nameController,
                      validator: (value) {
                        //Verifica se o campo está vazio ou é nulo
                        if (value == null || value.isEmpty) {
                          //Se sim, retorna uma mensagem de erro
                          errorStringNome += 'Por favor, digite seu nome\n';
                        }
                        //Verifica se o campo de erro é vazio, se não, retorna null
                        return errorStringNome != "" ? errorStringNome : null;
                      },
                    ),
                  ),

                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),

                  /// Campo de texto para a senha.
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        prefixIcon: const Icon(Icons.password),
                        //Sufixo do botão de visibilidade da senha
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.visibility),
                          onPressed: () {
                            //Alterna a visibilidade da senha
                            setState(() {
                              passWordVisibility = !passWordVisibility;
                            });
                          },
                        ),
                      ),
                      controller: passWordController,
                      validator: (value) {
                        String errorStringSenha = "";
                        //Verifica se o campo está vazio ou é nulo
                        if (value == null || value.isEmpty) {
                          //Se sim, adiciona-se mensagem de erro na string de erro pedindo para digitar a senha
                          errorStringSenha += 'Por favor, digite sua senha\n';
                        }

                        //Verifica se a senha tem no mínimo 8 caracteres
                        if (value != "" && value!.length < 8) {
                          //Se não, adiciona uma string na variável de erro para dizer que necessita-se de no mínimo 8 caracteres
                          errorStringSenha +=
                              'A senha deve conter no mínimo 8 caracteres\n';
                        }

                        //Verifica se a senha tem ao menos uma letra maiúscula e um número
                        if (value != "" &&
                            value != null &&
                            !regexSenha.hasMatch(value)) {
                          //Se não, adiciona uma string na variável de erro dizendo para corrigir o erro conforme a regra de regex
                          errorStringSenha +=
                              'A senha deve conter ao menos uma letra maiúscula e um número\n';
                        }

                        return errorStringSenha != "" ? errorStringSenha : null;
                      },
                      obscureText: passWordVisibility,
                    ),
                  ),

                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),

                  /// Campo de texto para o email.
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        //Verifica se o campo está vazio ou é nulo
                        if (value == null || value.isEmpty) {
                          errorStringEmail += 'Por favor, digite seu email\n';
                        }
                        //Verifica se o campo de email, está de acordo com a regex de email
                        if (value != "" &&
                            value != null &&
                            !regexEmail.hasMatch(value)) {
                          //Se não, adiciona uma string na variável de erro para dizer que o email está inválido
                          errorStringEmail +=
                              'Por favor, digite um email válido\n';
                        }

                        return errorStringEmail != "" ? errorStringEmail : null;
                      },
                      controller: emailController,
                    ),
                  ),

                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),

                  /// Campo de texto para o nome de usuário.
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Nome de Usuario',
                        prefixIcon: Icon(Icons.supervised_user_circle),
                      ),
                      controller: userNameController,
                      validator: (value) {
                        //Verifica se o campo está vazio ou é nulo
                        if (value == null || value.isEmpty) {
                          //Se não, adiciona-se mensagem de erro na string de erro pedindo para digitar o nome de usuário
                          errorStringUserName +=
                              'Por favor, digite seu nome de usuário\n';
                        }
                        return errorStringUserName != ""
                            ? errorStringUserName
                            : null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const SizedBox(height: 20.0),
                  Builder(
                    builder: (context) => Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: 50,
                        child: ElevatedButton(
                          style: cadastrarButtonStyle,
                          onPressed: () async {
                            /// Limpa as mensagens de erro, caso o cadastro seja válido
                            errorStringEmail = "";
                            errorStringNome = "";
                            errorStringUserName = "";

                            /// Verifica se o usuário já existe.
                            await checUserExistsIteration();

                            /// Valida o formulário.
                            if (formKey.currentState!.validate()) {
                              /// Cria o usuário.
                              await userCreate(
                                userNameController.text.toString(),
                                emailController.text.toString(),
                                passWordController.text.toString(),
                                nameController.text.toString(),
                              ).then((value) async {
                                /// Faz o login do usuário após a criação.
                                await userLogin(
                                  userNameController.text,
                                  passWordController.text,
                                ).then((value) {
                                  /// Navega para a página contendo todas as postagens
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PostagemList(
                                        user: value,
                                      ),
                                    ),
                                  );
                                });
                              });
                            }
                          },
                          child: Text(
                            'Cadastrar',
                            style: GoogleFonts.openSans(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
