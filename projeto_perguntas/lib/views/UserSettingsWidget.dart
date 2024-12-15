import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_perguntas/api/user.dart';
import 'package:projeto_perguntas/model/user.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// Widget para exibir e editar as configurações do usuário.
class UserSettingsWidget extends StatefulWidget {
  /// Usuário atual.
  final User user;

  /// Socket para comunicação em tempo real.
  final WebSocketChannel streamSocket;

  /// Construtor do widget.
  ///
  /// Recebe o [user] e o [streamSocket] como parâmetros obrigatórios.
  UserSettingsWidget(
      {super.key, required this.user, required this.streamSocket});

  @override
  UserSettingsWidgetState createState() => UserSettingsWidgetState();
}

class UserSettingsWidgetState extends State<UserSettingsWidget> {
  /// Controlador para o campo de email.
  final emailController = TextEditingController();

  /// Controlador para o campo de senha.
  final passWordController = TextEditingController();

  /// String para exibir mensagens de erro relacionadas ao email.
  String errorStringEmail = "";

  /// Variável para controlar a visibilidade da senha.
  bool passWordVisibility = false;

  /// Nova senha do usuário (opcional).
  late String? newPassword;

  /// Novo email do usuário (opcional).
  late String? newEmail;

  /// Chave global para o formulário.
  final formKey = GlobalKey<FormState>();

  /// Expressão regular para validar a senha.
  /// A senha deve conter pelo menos uma letra maiúscula e um número.
  final regexSenha = RegExp(r'^(?=.*[A-Z])(?=.*[0-9])[a-zA-Z0-9]+');

  /// Expressão regular para validar o email.
  final regexEmail = RegExp(r'[\w.%+-]+@[A-Za-z0-9.-].[a-zA-Z]+');

  /// Estilo do botão "Alterar Dados".
  final alterarDadosButtonStyle = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      side: BorderSide(color: Colors.deepPurple, width: 0.5),
      textStyle:
          TextStyle(color: const Color.fromARGB(255, 68, 29, 74), fontSize: 40),
      backgroundColor: Colors.white);

  /// Estilo do botão "Cancelar".
  final botaoCancelarStyle = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Colors.deepPurple, width: 1.0),
      borderRadius: BorderRadius.circular(8.0),
    ),
  );

  /// Estilo do botão "Confirmar".
  final botaoConfirmarStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.redAccent,
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: const Color.fromARGB(255, 141, 47, 47),
        width: 0.8,
      ),
      borderRadius: BorderRadius.circular(8.0),
    ),
  );

  /// Verifica se o email já existe no banco de dados.
  dynamic checUserExistsIteration() async {
    await checkUserExists(emailController.text.toString()).then((value) {
      if (value == 200) {
        //Se sim, adiciona a mensagem de erro que o email já existe o banco de dados
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Editar Perfil',
              style: GoogleFonts.montserrat(
                  fontSize: 25, fontWeight: FontWeight.bold)),
        ),
        body: Center(
            child: SingleChildScrollView(
                child: Form(
                    key: formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                              child: Image.asset('assets/registro.png'),
                              width: MediaQuery.of(context).size.width * 0.5,
                              height:
                                  MediaQuery.of(context).size.height * 0.25),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03,
                              height:
                                  MediaQuery.of(context).size.height * 0.03),

                          /// Campo de Nome (somente leitura).
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
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

                          /// Campo de Nome de Usuário (somente leitura).
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
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
                                    prefixIcon:
                                        Icon(Icons.supervised_user_circle),
                                  ),
                                )
                              ],
                            ),
                          ),

                          /// Campo de Senha.
                          /// Validação: mínimo 8 caracteres, pelo menos uma letra maiúscula e um número.
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            alignment: Alignment.centerRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Senha"),
                                TextFormField(
                                  decoration: InputDecoration(
                                    //Botão para ocultar/mostrar senha
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.visibility),
                                      onPressed: () {
                                        setState(() {
                                          //Muda a visibilidade da senha
                                          //true para senha visívels
                                          //false para senha oculta
                                          passWordVisibility =
                                              !passWordVisibility;
                                        });
                                      },
                                    ),
                                    hintText: newPassword,
                                    prefixIcon: Icon(Icons.password),
                                  ),
                                  controller: passWordController,
                                  validator: (value) {
                                    String errorStringSenha = "";
                                    //Verifica se a senha é vazia ou contem menos de 8 caracteres
                                    if (value != "" && value!.length < 8) {
                                      //Se sim, adiciona a mensagem de erro abaixo na string
                                      errorStringSenha +=
                                          'A senha deve conter no mínimo 8 caracteres\n';
                                    }
                                    //Verifica se a senha contem pelo menos uma letra maiúscula e um número
                                    if (value != "" &&
                                        value != null &&
                                        !regexSenha.hasMatch(value)) {
                                      //Se não, adiciona a mensagem de erro abaixo na string
                                      errorStringSenha +=
                                          'A senha deve conter ao menos uma letra maiúscula e um número\n';
                                    }

                                    return errorStringSenha != ""
                                        ? errorStringSenha
                                        : null;
                                  },
                                  //Atribui texto oculto ao texto
                                  obscureText: passWordVisibility,
                                )
                              ],
                            ),
                          ),

                          /// Campo de Email.
                          /// Validação: formato de email válido.
                          Container(
                              width: MediaQuery.of(context).size.width * 0.8,
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
                                      validator: (value) {
                                        //Verifica se o email é válido
                                        if (value != "" &&
                                            value != null &&
                                            !regexEmail.hasMatch(value)) {
                                          //Se não, adiciona a mensagem de erro abaixo na string
                                          errorStringEmail +=
                                              'Por favor, digite um email válido\n';
                                        }
                                        return errorStringEmail != ""
                                            ? errorStringEmail
                                            : null;
                                      },
                                    )
                                  ])),

                          // ... (rest of the code)
                        ])))));
  }
}
