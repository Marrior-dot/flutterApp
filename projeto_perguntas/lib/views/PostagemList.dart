import 'package:flutter/material.dart';
import 'package:projeto_perguntas/main.dart';
import 'package:projeto_perguntas/model/postagem.dart';
import 'package:projeto_perguntas/model/user.dart';
import 'package:projeto_perguntas/api/postagem.dart';
import 'package:projeto_perguntas/views/ImageWidget.dart';
import 'package:projeto_perguntas/views/ContentWidget.dart';
import 'package:projeto_perguntas/views/RespostasWidget.dart';
import 'package:projeto_perguntas/views/TitleWidget.dart';
import 'package:projeto_perguntas/views/LikesDislikesWidget.dart';
import 'package:projeto_perguntas/views/ComentariosWidget.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:projeto_perguntas/views/UserSettingsWidget.dart';
import 'dart:io';
import 'dart:async';

/// Widget que exibe uma lista de postagens.
///
/// Este widget busca as postagens usando a função `getPostagemStreamController`
/// e as exibe em uma lista rolável. Cada postagem é exibida em um cartão com
/// título, imagem, conteúdo, opções de curtir/descurtir, respostas e comentários.
///
/// Atributos:
/// - `user`: O usuário atualmente logado. Este atributo é obrigatório.
class PostagemList extends StatefulWidget {
  /// O usuário atualmente logado.
  final User user;

  /// Construtor da classe PostagemList.
  ///
  /// Recebe o usuário como parâmetro obrigatório.
  const PostagemList({super.key, required this.user});

  @override
  State<PostagemList> createState() => PostagemListState();
}

class PostagemListState extends State<PostagemList> {
  /// Conexão WebSocket para receber atualizações em tempo real.
  WebSocketChannel streamSocket =
      WebSocketChannel.connect(Uri.parse('ws://localhost:8000/ws/postagem/'));

  /// Texto do comentário sendo digitado.
  String commentText = "";

  Future<void> clearAssetsDirectory() async {
    //Abrindo o diretório assets/images
    final directory = Directory('assets/images');
    if (directory.existsSync()) {
      directory.listSync().forEach((file) {
        if (file is File) {
          file.deleteSync();
        }
      });
    }
  }


  @override
  void initState() {
    super.initState();
    connectWebSocket(streamSocket);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exemplo de Busca de Dados',

      /// Rotas nomeadas para navegação.
      ///
      /// - `/configurar`: Rota para a tela de configurações do usuário.
      /// - `/login`: Rota para a tela de login.
      routes: {
        '/configurar': (context) =>
            UserSettingsWidget(user: widget.user, streamSocket: streamSocket),
        '/login': (context) => MyApp(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Exemplo de Busca de Dados'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              //Logout do usuário
              clearAssetsDirectory();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyApp()));
            },
          ),
          actions: [
            //Botão para a página de configurações do usuário.
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserSettingsWidget(
                              user: widget.user, streamSocket: streamSocket)));
                },
                icon: Icon(Icons.tune))
          ],
        ),

        /// Corpo do Scaffold.
        ///
        /// Exibe um StreamBuilder que escuta o stream de postagens.
        body: Center(
          child: StreamBuilder<List<Postagem>>(
            //Stream de postagens que se atualiza cada vez que uma postagem é adicionada.
            stream: getPostagemStreamController().stream.asBroadcastStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, index) {
                    //Postagem atual
                    Postagem postagem = snapshot.data![index];
                    //Card que exibe as informações da postagem.
                    return Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Widget para exibir título da postagem.
                            TitleWidget(title: snapshot.data![index].title),
                            //Widget para exibir imagem da postagem.
                            ImageWidget(
                                imageUrl: snapshot.data![index].arquivo),
                            //Widget para conteúdo da postagem.
                            ContentWidget(
                                content: snapshot.data![index].content),
                            //Widget para exibir likes e dislikes da postagem da postagem.
                            LikesDislikesWidget(
                                likes: snapshot.data![index].likes,
                                dislikes: snapshot.data![index].dislikes,
                                postagemId: snapshot.data![index].id,
                                userName: widget.user.username),
                            //Widget para exibir as respostas da postagem, caso haja alguma
                            RespostasWidget(
                              postagemid: snapshot.data![index].id,
                              userid: widget.user.username,
                              escolha_unica:
                                  snapshot.data![index].escolha_unica,
                            ),
                            //Widget para exibir os comentários da postagem e exibir o campo para digitar um comentário.
                            ComentariosWidget(
                                postagem: postagem, user: widget.user)
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return Text('${snapshot.error}');
            },
          ),
        ),
      ),
    );
  }
}
