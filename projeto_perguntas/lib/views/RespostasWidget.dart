import 'package:flutter/material.dart';
import 'package:projeto_perguntas/api/respostas.dart';
import 'package:projeto_perguntas/views/IsRadio.dart';

/// Widget que exibe as opções de resposta para uma determinada postagem.
///
/// Este widget busca as respostas da API e as exibe em uma lista.
/// O tipo de lista (rádio ou checkbox) é determinado pelo parâmetro `escolha_unica`.
class RespostasWidget extends StatelessWidget {
  /// Construtor da classe RespostasWidget.
  ///
  /// Recebe o ID da postagem (`postagemid`), o ID do usuário (`userid`)
  /// e um booleano `escolha_unica` que indica se a escolha de respostas é única (rádio) ou múltipla (checkbox).
  const RespostasWidget({
    super.key,
    required this.postagemid,
    required this.userid,
    required this.escolha_unica,
  });

  /// ID da postagem.
  final int postagemid;

  /// ID do usuário.
  final String userid;

  /// Indica se a escolha de respostas é única (true) ou múltipla (false).
  final bool escolha_unica;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchRespostas(postagemid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            /// Widget que exibe a lista de opções de resposta.
            ///
            /// `options`: Lista de strings que representam as opções de resposta.
            /// `isRadio`: Booleano que indica se a lista deve ser de botões de rádio (true) ou caixas de seleção (false).
            /// `postagemId`: ID da postagem.
            /// `userName`: Nome de usuário.
            return OptionsListWidget<String>(
                options: snapshot.data!.map((e) => e.respostaTexto).toList(),
                isRadio: escolha_unica,
                postagemId: postagemid,
                userName: userid);
          } else {
            return SizedBox
                .shrink(); // Retorna um widget vazio se não houver dados.
          }
        });
  }
}
