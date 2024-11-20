import 'dart:convert';
import 'package:empty_widget/empty_widget.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:projeto_perguntas/api/respostas.dart';
import 'package:projeto_perguntas/views/IsRadio.dart';

class RespostasWidget extends StatelessWidget {
  const RespostasWidget(
      {super.key,
      required this.postagemid,
      required this.userid,
      required this.escolha_unica,
      required this.index});
  final int postagemid;
  final String userid;
  final bool escolha_unica;
  final int index;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchRespostas(postagemid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return OptionsListWidget<String>(
                options: snapshot.data!.map((e) => e.respostaTexto).toList(),
                isRadio: escolha_unica,
                respostaIndex: index,
                postagemId: postagemid,
                userName: userid);
          } else {
            return SizedBox.shrink();
          }
        });
  }
}
