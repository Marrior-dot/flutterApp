class Postagem{
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
        'likes': int likes,
        'dislikes': int dislikes,
        'arquivo': String arquivo,
        'content': String content
      } =>
        Postagem(
        likes: likes,
        dislikes: dislikes,
        arquivo:  arquivo,
        content: content
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}