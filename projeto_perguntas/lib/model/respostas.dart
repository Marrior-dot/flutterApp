class Respostas {
  //Atributos
  final String respostaTexto;
  final int respondido;
  final int postagem;

  //Construtor
  Respostas(this.respostaTexto, this.respondido, this.postagem);

  //Serializa e transforma um objeto Json em objeto Respostas
  Respostas.fromJson(Map<String, dynamic> json)
    : respostaTexto = json['respostaTexto'] as String,
      respondido = json['respondido'] as int,
      postagem = json['postagem'] as int;

  //Serializa e transforma um Respostas em objeto Json
  Map<String, dynamic> toJson() => {
        'respostaTexto': respostaTexto,
        'respondido': respondido,
        'postagem': postagem,
      };

}
