import 'package:flutter/material.dart';

/// Widget que exibe um título com estilo.
///
/// Este widget recebe um título como parâmetro obrigatório e o exibe com um estilo predefinido, incluindo tamanho de fonte 20.0 e negrito.
class TitleWidget extends StatelessWidget {
  /// Construtor do TitleWidget.
  ///
  /// Recebe o título como parâmetro obrigatório.
  ///
  /// [title]: O título a ser exibido.
  const TitleWidget({super.key, required this.title});

  /// O título a ser exibido.
  final String title;

  /// Constrói o widget.
  ///
  /// Retorna um widget Padding que contém o Text com o título estilizado.
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ));
  }
}
