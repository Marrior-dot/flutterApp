class Respostas {
  final String respostaTexto;
  final String respostaBool;

  const Respostas({
    required this.respostaTexto,
    required this.respostaBool,
  });

  factory Respostas.fromJson(Map<String, dynamic> json) {
    return Respostas(
      respostaTexto: json['respostaTexto'] as String,
      respostaBool: json['respostaBool'] as String,
    );
  }
}
