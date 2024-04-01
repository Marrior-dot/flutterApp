class Postagem {
  final String arquivo;
  final String content;
  final int likes;
  final int dislikes;

/*
  const Postagem({
    required this.arquivo,
    required this.content,
    required this.likes,
    required this.dislikes,
  });*/

  Postagem(this.arquivo, this.content, this.likes, this.dislikes);

  Postagem.fromJson(Map<String, dynamic> json)
      : arquivo = json['arquivo'] as String,
        content = json['content'] as String,
        likes = json['likes'] as int,
        dislikes = json['dislikes'] as int;

  Map<String, dynamic> toJson() => {
        'arquivo': arquivo,
        'content': content,
        'likes': likes,
        'dislikes': dislikes,
      };

  /*factory Postagem.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'arquivo': String arquivo,
        'content': String content,
        'likes': int likes,
        'dislikes': int dislikes,
      } =>
        Postagem(
          arquivo: arquivo,
          content: content,
          likes: likes,
          dislikes: dislikes,
        ),
      _ => throw const FormatException('Falha ao carregar postagens'),
    };
  }*/
}
