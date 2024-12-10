import 'package:flutter/material.dart';
/// Widget que exibe uma imagem a partir de um URL local.
class ImageWidget extends StatelessWidget {
  /// Construtor para o ImageWidget.
  ///
  /// Recebe como parâmetro obrigatório o `imageUrl`, que representa o caminho da imagem
  /// relativo à pasta 'assets'.
  const ImageWidget({super.key, required this.imageUrl});

  /// O caminho da imagem, relativo à pasta 'assets'.
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    /// Constrói o caminho completo da imagem.
    String image = './assets${imageUrl}';

    /// Verifica se o caminho da imagem é válido (diferente de './assetsnull').
    if (image != './assetsnull') {
      return Center(
        /// Centraliza o widget na tela.
        child: SizedBox(
          /// Define o tamanho da imagem.
          /// Largura: 100% da largura da tela.
          /// Altura: 25% da altura da tela.
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 0.25,
          child: Image(
            /// Exibe a imagem a partir do caminho fornecido.
            image: AssetImage(image),
          ),
        ),
      );
    }

    /// Retorna um SizedBox vazio se o caminho da imagem for inválido.
    return SizedBox.shrink();
  }
}