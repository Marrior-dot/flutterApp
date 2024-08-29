import 'package:flutter/material.dart';
import 'package:projeto_perguntas/model/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui';

Future<int> checkUserExists(String? nomeEmailUsuario) async{
  final response =  await http
      .get(Uri.parse('http://localhost:8000/api/userexists/${nomeEmailUsuario}/'));
        //.get(Uri.parse('http://10.54.2.110:8000/api/userexists/${nomeEmailUsuario}/'));
 //print(response.statusCode);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return response.statusCode;
  } 
  else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Falha servidor');
  }
}


