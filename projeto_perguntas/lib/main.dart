import 'package:flutter/material.dart';
import 'package:projeto_perguntas/model/postagem.dart' as postagem;
import 'package:projeto_perguntas/views/LoginPage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:socket_io_client/socket_io_client.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => LoginPage();
}
