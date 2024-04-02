import 'dart:io';

class Postagem {
  final String arquivo;
  //final File arquivo;
  final String content;
  final int likes;
  final int dislikes;

  Postagem(this.arquivo, this.content, this.likes, this.dislikes);

  Postagem.fromJson(Map<String, dynamic> json)
      : arquivo = json['arquivo'] as String,
        //arquivo = json['arquivo'] as File,
        content = json['content'] as String,
        likes = json['likes'] as int,
        dislikes = json['dislikes'] as int;

  Map<String, dynamic> toJson() => {
        'arquivo': arquivo,
        'content': content,
        'likes': likes,
        'dislikes': dislikes,
      };
}
