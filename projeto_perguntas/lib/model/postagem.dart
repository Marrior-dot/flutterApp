import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'dart:io';

//part 'postagem.g.dart';

//Classe usando JsonSerializable
/*
@JsonSerializable()
class Postagem {
  Postagem(this.id, this.arquivo, this.content, this.likes, this.dislikes);

  

  Function? ffj = fileFromJson();

  int id;
  File? arquivo;
  String content;
  int likes;
  int dislikes;

  factory Postagem.fromJson(Map<String, dynamic> json) =>
      _$PostagemFromJson(json);
  Map<String, dynamic> toJson() => _$PostagemToJson(this);

  String fileToJson() => jsonEncode(<String, File?>{"arquivo": arquivo});

  File? fileFromJson(String json) {
    Map<String, File?> jsonDecoded = jsonDecode(json);
    return jsonDecoded["arquivo"];
  }

}*/

// Classe postagem original
@JsonSerializable()
class Postagem {
  final int id;
  final File? arquivo;
  final String content;
  final int likes;
  final int dislikes;
  
  Postagem(this.id, this.arquivo, this.content, this.likes, this.dislikes);

  Postagem.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        arquivo = json['arquivo'] as File?,
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

