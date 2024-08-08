class Respostas {
  final String respostaTexto;
  final int respondido;

  const Respostas({
    required this.respostaTexto,
    required this.respondido,
  });

  factory Respostas.fromJson(Map<String, dynamic> json) {
    return Respostas(
      respostaTexto: json['respostaTexto'] as String,
      respondido: json['respondido'] as int,
    );
  }
}
