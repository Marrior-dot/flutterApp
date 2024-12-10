part of 'comments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

//Serialização para o decodificar um objeto CommentsPostagem em Json
CommentsPostagem _$CommentsPostagemFromJson(Map<String, dynamic> json) =>
    CommentsPostagem(
      json['username'] as String,
      Postagem.fromJson(json['postagem'] as Map<String, dynamic>),
      json['text'] as String,
    );

//Serialização para codificar um objeto CommentsPostagem para Json
Map<String, dynamic> _$CommentsPostagemToJson(CommentsPostagem instance) =>
    <String, dynamic>{
      'username': instance.username,
      'postagem': instance.postagem.toJson(),
      'text': instance.text,
    };
