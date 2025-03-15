import 'package:projeto_perguntas/model/postagem.dart';
import 'package:json_annotation/json_annotation.dart';
part 'comments.g.dart';

// @JsonSerializable usado para codificar e decodificar e uma instância dessa classe em JSON.
@JsonSerializable(explicitToJson: true)
class CommentsPostagem {
  //Construtor
  CommentsPostagem(this.username, this.postagem, this.text);
  //Atributos
  String username;
  Postagem postagem;
  String text;

  //Utilizado para criar um objetos a partir do Json.
  factory CommentsPostagem.fromJson(Map<String, dynamic> json) =>
      _$CommentsPostagemFromJson(json);

  //Utilizado para converter um objeto para Json.
  Map<String, dynamic> toJson() => _$CommentsPostagemToJson(this);
}
