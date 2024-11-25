import 'package:flutter/material.dart';
import 'package:projeto_perguntas/api/comments.dart';
import 'package:projeto_perguntas/model/comments.dart';
import 'package:projeto_perguntas/model/user.dart';
import 'package:projeto_perguntas/model/postagem.dart';
import 'dart:convert' show utf8;

class ComentariosWidget extends StatefulWidget {
  final Postagem postagem;
  final User user;

  ComentariosWidget(
      {super.key,
      required this.postagem,
      required this.user
      });

  @override
  State<ComentariosWidget> createState() => ComentariosWidgetState();
}

class ComentariosWidgetState extends State<ComentariosWidget> {
  late TextEditingController comentarioController;
  bool mostrarComentarios = false;
  String botaoMostrarComentarios = "Mostrar comentários";
  String textoComentario = "";

  @override
  void initState() {
    super.initState();    
  }

  TextEditingController controllerComments() {
    return TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    comentarioController = controllerComments();
    return Column(
                              children: [
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
                                SizedBox(
                                  height: 40,
                                  width: 200,
                                  child: ElevatedButton(
                                    onPressed: ()async{
                                      await createComment(
                                          widget.user.username,
                                          textoComentario,
                                          widget.postagem,
                                        );
                                      setState(() {
                                        if (mostrarComentarios == false){
                                          mostrarComentarios = true;
                                          botaoMostrarComentarios = "Esconder comentários";
                                        }
                                      });
                                    },
                                    child: const Text("Enviar comentário",
                                        style: TextStyle(fontSize: 12.0)),
                                  ),
                                ),
                                TextButton(onPressed:(){
                                  setState(() {
                                    if (mostrarComentarios == true){
                                      mostrarComentarios = false;
                                      botaoMostrarComentarios = "Mostrar comentários";
                                    }
                                    else{
                                      mostrarComentarios = true;
                                      botaoMostrarComentarios = "Esconder comentários";
                                    }
                                  });
                                    
                                } 
                                , child: Text("${botaoMostrarComentarios}"),),
                                Visibility(
                                  visible: mostrarComentarios,
                                  child:
                                 SingleChildScrollView(
                              child: FutureBuilder<List<CommentsPostagem>>(
                                future: fetchComments(widget.postagem),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        String item = utf8.decode(snapshot
                                            .data![index].text
                                            .toString()
                                            .codeUnits);
                                        String user =
                                            snapshot.data![index].username;
                                        return ListTile(
                                            title: Text("${user}:${item}"));
                                      },
                                    );
                                  }
                                  return Text('${snapshot.error}');
                                },
                              ),
                            )
                                )
                              ]
                            );
                            

  }
}