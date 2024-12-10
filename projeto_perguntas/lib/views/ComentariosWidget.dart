import 'package:flutter/material.dart';
import 'package:projeto_perguntas/api/comments.dart';
import 'package:projeto_perguntas/model/comments.dart';
import 'package:projeto_perguntas/model/user.dart';
import 'package:projeto_perguntas/model/postagem.dart';
import 'dart:convert' show utf8;

/// Widget para exibir e adicionar comentários a uma postagem.
class ComentariosWidget extends StatefulWidget {
  /// A postagem à qual os comentários pertencem.
  final Postagem postagem;

  /// O usuário atual.
  final User user;

  /// Construtor do widget.
  ///
  /// Recebe a [postagem] e o [user] como parâmetros obrigatórios.
  ComentariosWidget({
    super.key,
    required this.postagem,
    required this.user,
  });

  @override
  State<ComentariosWidget> createState() => ComentariosWidgetState();
}

/// Estado do widget `ComentariosWidget`.
class ComentariosWidgetState extends State<ComentariosWidget> {
  /// Controlador para o campo de texto do comentário.
  late TextEditingController comentarioController;

  /// Variável booleana que controla a visibilidade dos comentários.
  bool mostrarComentarios = false;

  /// Texto do botão que mostra/esconde os comentários.
  String botaoMostrarComentarios = "Mostrar comentários";

  /// Texto do comentário digitado pelo usuário.
  String textoComentario = "";

  @override
  void initState() {
    super.initState();
  }

  /// Retorna um novo controlador de texto para o campo de comentário.
  TextEditingController controllerComments() {
    return TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    comentarioController = controllerComments();
    return Column(
      children: [
        /// Campo de texto para digitar o comentário.
        TextFormField(
          style: TextStyle(
            fontSize: 15,
          ),
          decoration: InputDecoration(
            labelText: 'Escreva seu comentário',
            prefixIcon: Icon(Icons.comment),
            border: OutlineInputBorder(),
          ),
          controller: comentarioController,
          onChanged: (value) => textoComentario = value,
        ),
        const SizedBox(height: 16.0),
        /// Botão para enviar o comentário.
        SizedBox(
          height: 40,
          width: 200,
          child: ElevatedButton(
            onPressed: () async {
              /// Chama a função `createComment` para criar um novo comentário.
              /// Passa o nome de usuário, o texto do comentário e a postagem como parâmetros.
              await createComment(
                widget.user.username,
                textoComentario,
                widget.postagem,
              );
              setState(() {
                /// Define `mostrarComentarios` como `true` para exibir os comentários.
                /// Altera o texto do botão para "Esconder comentários".
                if (mostrarComentarios == false) {
                  mostrarComentarios = true;
                  botaoMostrarComentarios = "Esconder comentários";
                }
              });
            },
            child: const Text("Enviar comentário",
                style: TextStyle(fontSize: 12.0)),
          ),
        ),
        /// Botão para mostrar/esconder os comentários.
        TextButton(
          onPressed: () {
            setState(() {
              /// Alterna o valor de `mostrarComentarios` e atualiza o texto do botão.
              /// Se mostrarComentarios for [true] alterna para [false] e alterna o texto para 'Mostrar comentários'
              if (mostrarComentarios == true) {
                mostrarComentarios = false;
                botaoMostrarComentarios = "Mostrar comentários";
              } 
              /// Se mostrarComentarios for [false] alterna para [true] e alterna o texto para 'Esconder comentários'
              else {
                mostrarComentarios = true;
                botaoMostrarComentarios = "Esconder comentários";
              }
            });
          },
          child: Text("${botaoMostrarComentarios}"),
        ),
        /// Lista de comentários.
        Visibility(
          ///Se mostra visivel ou não a depender do valor de [mostrarComentarios]
            visible: mostrarComentarios,
            child: SingleChildScrollView(
              child: FutureBuilder<List<CommentsPostagem>>(
                future: fetchComments(widget.postagem),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        //Decodificação em utf-8 para caracteres especiais
                        String item = utf8.decode(snapshot.data![index].text
                            .toString()
                            .codeUnits);
                        String user = snapshot.data![index].username;
                        return ListTile(title: Text("${user}:${item}"));
                      },
                    );
                  }
                  return Text('${snapshot.error}');
                },
              ),
            )),
      ],
    );
  }
}