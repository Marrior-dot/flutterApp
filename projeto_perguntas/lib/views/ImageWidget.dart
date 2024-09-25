import 'dart:convert';
import 'dart:ffi';
import 'package:empty_widget/empty_widget.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget{
  const ImageWidget({super.key, required this.imagePath});
  final String? imagePath;
  //final File? imagePath;

  @override
  Widget build(BuildContext context) {
    if(imagePath != null || imagePath != ""){
      String image = "assets${imagePath}"; 
      //print(image);
      return Image(image: AssetImage(image));
    }
    return EmptyWidget();
  }
}