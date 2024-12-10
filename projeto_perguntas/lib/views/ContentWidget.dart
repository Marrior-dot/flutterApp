import 'package:flutter/material.dart';

// Widget que exibe conteúdo textual.
class ContentWidget extends StatelessWidget {
  /// Construtor para o ContentWidget.
  ///
  /// Recebe uma chave opcional [key] para o widget e o conteúdo [content] a ser exibido.
  const ContentWidget({super.key, required this.content});
  /// O conteúdo pode ser nulo.
  final String? content;
  
  @override
  Widget build(BuildContext context) {
    // Se o conteúdo não for nulo, exibe o texto com um padding inferior.
    if (content != null) {
      return Padding(padding: EdgeInsets.only(bottom: 30.0),
        child: Text(
          content as String,
          style: const TextStyle(
            fontSize: 15.0
          ),
        ));
    }
    return SizedBox.shrink();
  }
}
