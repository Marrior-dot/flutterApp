class Postagem {
  final String arquivo;
  final String content;
  final int likes;
  final int dislikes;

  const Postagem({
    required this.arquivo,
    required this.content,
    required this.likes,
    required this.dislikes,
  });

  factory Postagem.fromJson(Map<String, dynamic> json) {
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
  }
}
