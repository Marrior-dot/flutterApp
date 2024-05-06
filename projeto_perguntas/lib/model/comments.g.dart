// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentsPostagem _$CommentsPostagemFromJson(Map<String, dynamic> json) =>
    CommentsPostagem(
      //User.fromJson(json['user'] as Map<String, dynamic>),
      Postagem.fromJson(json['postagem'] as Map<String, dynamic>),
      json['text'] as String,
    );

Map<String, dynamic> _$CommentsPostagemToJson(CommentsPostagem instance) =>
    <String, dynamic>{
      //'user': instance.user.toJson(),
      'postagem': instance.postagem.toJson(),
      'text': instance.text,
    };
