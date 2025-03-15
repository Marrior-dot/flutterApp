import 'package:flutter/material.dart';
import 'package:projeto_perguntas/api/postagem.dart';

/// Widget para exibir e gerenciar curtidas e descurtidas em uma postagem.
class LikesDislikesWidget extends StatefulWidget {
  /// Número de curtidas da postagem.
  int likes;

  /// Número de descurtidas da postagem.
  final int dislikes;

  /// ID da postagem.
  final int postagemId;

  /// Nome de usuário do usuário atual.
  final String userName;

  /// Construtor do widget.
  ///
  /// Recebe o número inicial de curtidas [likes], descurtidas [dislikes],
  /// o ID da postagem [postagemId] e o nome de usuário [userName].
  LikesDislikesWidget({
    super.key,
    required this.likes,
    required this.dislikes,
    required this.postagemId,
    required this.userName,
  });

  @override
  LikesDislikesState createState() => LikesDislikesState();
}

class LikesDislikesState extends State<LikesDislikesWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// FutureBuilder para verificar o estado atual de curtida/descurtida do usuário.
    return FutureBuilder(
      future: checkLike(widget.userName, widget.postagemId),
      builder: (context, snapshot) {
        /// Lista contendo o estado de curtida e descurtida.
        /// sendButton[0] = true ->  Usuário pode descurtir.
        /// sendButton[0] = null -> Usuário já descurtiu.
        /// sendButton[1] = true -> Usuário pode curtir.
        /// sendButton[1] = null -> Usuário já curtiu.
        List<bool?> sendButton = snapshot.data ?? [true, true];

        /// Opacidade do ícone de curtida. 200 se disponível, 100 se não.
        int likeOpacity = sendButton[1] == true ? 200 : 100;

        /// Opacidade do ícone de descurtida. 200 se disponível, 100 se não.
        int dislikeOpacity = sendButton[0] == true ? 200 : 100;

        return SizedBox(
          width: MediaQuery.of(context).size.width * 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
                child: IconButton(
                  /// Ação executada ao pressionar o botão de descurtir.
                  onPressed: sendButton[0] == true
                      ? () async {
                          /// Atualiza o número de descurtidas no banco de dados.
                          await updateLikeDislike(
                              'dislikes', widget.postagemId, widget.dislikes);

                          /// Persiste a ação de descurtir para o usuário.
                          await persistencaLikeDislike(
                              widget.userName, widget.postagemId, false, null);

                          /// Atualiza o estado do widget.
                          setState(() {
                            //Desabilita o botão de dislike
                            sendButton[0] = null;
                            //Diminui a opacidade do ícone de dislike
                            dislikeOpacity = 100;
                          });
                        }
                      : null,
                  icon: Icon(Icons.thumb_down),
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(
                    Color.fromARGB(dislikeOpacity, 105, 105, 105),
                  )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: IconButton(
                      /// Ação executada ao pressionar o botão de curtir.
                      onPressed: sendButton[1] == true
                          ? () async {
                              /// Atualiza o número de curtidas no banco de dados.
                              await updateLikeDislike(
                                  'likes', widget.postagemId, widget.likes);

                              /// Persiste a ação de curtir para o usuário.
                              await persistencaLikeDislike(widget.userName,
                                  widget.postagemId, true, null);

                              /// Atualiza o estado do widget.
                              setState(() {
                                //Desabilitea o botão de curtir
                                sendButton[1] = null;
                                //Incrementa o número de curtidas
                                widget.likes += 1;
                                //Muda a opacidade do ícode de curtir
                                likeOpacity = 100;
                              });
                            }
                          : null,
                      icon: const Icon(Icons.thumb_up),
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all(
                        Color.fromARGB(likeOpacity, 43, 142, 255),
                      )),
                    ),
                  ),
                  //Mostra o número de curtidas da postagem
                  SizedBox(
                      height: 20,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text("${widget.likes} likes")),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
