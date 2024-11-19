import 'dart:convert';
//import 'dart:ffi';
import 'package:empty_widget/empty_widget.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class ContentWidget extends StatelessWidget {
  const ContentWidget({super.key, required this.content});
  final String? content;
  
  @override
  Widget build(BuildContext context) {
    if (content != null) {
      return Padding(padding: EdgeInsets.only(bottom: 30.0),
        child: Text(
          content as String,
          style: const TextStyle(
            fontSize: 15.0
          ),
        ));
    }
    return SizedBox.shrink();
  }
}
