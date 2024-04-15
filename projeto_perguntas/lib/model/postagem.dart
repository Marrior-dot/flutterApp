//import 'dart:io';

class Postagem {
  final int id;
  final String arquivo;
  //final File arquivo;
  final String content;
  final int likes;
  final int dislikes;

  Postagem(this.id, this.arquivo, this.content, this.likes, this.dislikes);

  Postagem.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        arquivo = json['arquivo'] as String,
        //arquivo = json['arquivo'] as File,
        content = json['content'] as String,
        likes = json['likes'] as int,
        dislikes = json['dislikes'] as int;

  Map<String, dynamic> toJson() => {
        'id': id,
        'arquivo': arquivo,
        'content': content,
        'likes': likes,
        'dislikes': dislikes,
      };
}
