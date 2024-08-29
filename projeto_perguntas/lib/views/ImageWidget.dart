import 'dart:convert';
import 'dart:ffi';
import 'package:empty_widget/empty_widget.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget{
  const ImageWidget({super.key, required this.imageUrl});
  final File? imageUrl;

  @override
  Widget build(BuildContext context) {
    if(imageUrl != null){
      return Image.file(imageUrl!);
    }
    return Text("");
  }
}