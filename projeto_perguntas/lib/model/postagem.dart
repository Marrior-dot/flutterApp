class Postagem{
  final int id;
  //Arquivo pode ser nulo
  String? arquivo;
  //Conteudo da postagem pode ser nulo
  final String? content;
  final String title;
  final int likes;
  final int dislikes;
  final bool escolha_unica;

  //Construtor
  Postagem(this.id, this.arquivo, this.content, this.likes, this.dislikes,this.escolha_unica, this.title);

  //Serializa e converte um json em objeto Postagem
  Postagem.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        arquivo = json['arquivo'] as String?,
        title = json['title'] as String,
        content = json['content'] as String?,
        likes = json['likes'] as int,
        dislikes = json['dislikes'] as int,
        escolha_unica = json['escolha_unica'] as bool;

  //Serializa e converte um objeto Postagem em Json
  Map<String, dynamic> toJson() =>{
        'id': id,
        'arquivo': arquivo,
        'content': content,
        'title': title,
        'likes': likes,
        'dislikes': dislikes,
        'escolha_unica': escolha_unica,
      };
}
