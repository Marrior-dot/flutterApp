import 'dart:convert';
//import 'dart:ffi';
import 'package:empty_widget/empty_widget.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget{
  const TitleWidget({super.key, required this.title});
  final String title;
  
  @override
  Widget build(BuildContext context) {
      return 
        Padding(padding:EdgeInsets.symmetric(vertical: 10.0),
          child: 
          Text(
            title,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ));
          //);

    }
}