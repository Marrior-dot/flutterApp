// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentsPostagem _$CommentsPostagemFromJson(Map<String, dynamic> json) =>
    CommentsPostagem(
      json['username'] as String,
      Postagem.fromJson(json['postagem'] as Map<String, dynamic>),
      json['text'] as String,
    );

Map<String, dynamic> _$CommentsPostagemToJson(CommentsPostagem instance) =>
    <String, dynamic>{
      'username': instance.username,
      'postagem': instance.postagem.toJson(),
      'text': instance.text,
    };
