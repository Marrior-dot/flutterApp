import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projeto_perguntas/model/postagem.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:minio_flutter/minio.dart';

//Variável global para o WebSocket, controla a stream de postagens que vai ser enviada ao usuário
StreamController<List<Postagem>> postagemStreamController =
    StreamController<List<Postagem>>.broadcast();

//Lista de postagens que será enviada ao usuário
List<Postagem> postagensStream = [];

//Conexão com o WebSocket, recebe uma variável do tipo WebSocketChannel
void connectWebSocket(WebSocketChannel streamSocket) async {
  await Minio.init(endPoint: "play.min.io", accessKey: "yvuhnPGjd5Jj0UxDFQnw", secretKey: "tewvjxadJ60v6PH7Mqg053RQ8Tg9yoE3WxSRH5wB");
  
  try {
    //Aguarda a conexão com o WebSocket
    await streamSocket.ready;

    //Envia uma mensagem para o servidor para obter as postagens
    streamSocket.sink.add(jsonEncode({'message': 'get_postagens'}));

    //Aguarda a resposta do servidor
    streamSocket.stream.listen((event) async {
      //Decodifica a mensagem recebida do servidor
      var postagemEvent = jsonDecode(event);

      /*Verifica se a mensagem recebida é uma lista de postagens ou uma postagem
      usada para mandar postagens no login do usuário.*/
      if (postagemEvent is List) {

        //Converte a lista de postagens recebida do servidor em uma lista de objetos Postagem
        var postagem = postagemEvent
            .map<Postagem>((json) => Postagem.fromJson(json))
            .toList();

        for (var i = 0; i < postagem.length; i++) {
          if(postagem[i].arquivo != null){
            //Salva a imagem no minio
            //print(postagem[i].arquivo);
            String arquivoFinal = postagem[i].arquivo!.replaceFirst(r'^/', '');
            final arquivo = await Minio.shared.getObject("python-test-bucket", arquivoFinal);
            print(arquivo);
            //await arquivo.pipe(File('assets/images/arquivo.png').openWrite());
            await arquivo.pipe(File('assets/${arquivoFinal}').openWrite());
            
          }
        }
        //Adiciona as postagens recebidas na lista de postagens global
        setPostagensStream(postagem);

        //Adiciona a lista de postagens na strema a ser enviada ao usuário
        postagemStreamController.add(postagem);
        //Adiciona a lista de postage
      } 
      /*Atualiza com uma postagem nova caso o servidor envie uma postagem nova*/
      else {
        //Converte a postagem recebida do servidor em um objeto Postagem
        Postagem postagem = Postagem.fromJson(postagemEvent);

        //Insere na lista de postagens a postagem recebida do servidor
        postagensStream.insert(0, postagem);

        //Adiciona a lista de postagens na strema a ser enviada ao usuário
        postagemStreamController.add(postagensStream);
      }
    });
  } on WebSocketChannelException catch (e) {
    print(e);
  }
}

//Retorna a stream de postagens
StreamController<List<Postagem>> getPostagemStreamController() {
  return postagemStreamController;
}

//Adiciona uma postagem na lista de postagens
void setPostagensStream(List<Postagem> postagem) {
  for (var element in postagem) {
    postagensStream.add(element);
  }
}

/*Future utilizado para atualizar a quantidade de likes em uma postagem, toma como argumentos uma String e 2 inteiros
o atributo 'button', pode assumir os valores de 'like' o 'dislike'*/
Future<Postagem> updateLikeDislike(
    String likeOrDislike, int id, int button) async {
  //parsing da url e requisição http em patch      
  final response = await http.patch(
    Uri.parse('http://localhost:8000/api/postagens/$id/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    //codificação dos dados para envio
    body: jsonEncode(<String, dynamic>{
      //atualiza o atributo like ou dislike
      likeOrDislike: button + 1,
    }),
  );
  //resposta do servidor
  if (response.statusCode == 200) {
    //retorno da função em um objeto do tipo Postagem
    return Postagem.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Não foi possível atualizar a quantidade de ${button}');
  }
}

//Future utilizado para salvar a persistência de likes e dislikes em uma postagem, recebe argumentos do tipo String, int, bool e bool?
Future<void> persistencaLikeDislike(
    String userName, int postagemID, bool tipoBotao, bool? habilitado) async {
  //parsing da url e requisição http em post
  final response = await http.post(
    //Uri.parse('http://10.54.2.110:8000/api/users/'),
    Uri.parse(
        'http://localhost:8000/api/postagens_persistencia/${userName}/${postagemID}/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },

    //codificação dos dados para envio
    body: jsonEncode(<String, dynamic>{
      "user": userName,
      "postagem": postagemID,
      "tipoBotao": tipoBotao,
      "habilitado": habilitado
    }),
  );
  //resposta do servidor
  if (response.statusCode == 201) {
    //retorna um void
    return;
  } else {
    throw Exception('Falha ao salvar persistência');
  }
}

/*Função para verificar se o usuário já deu like ou dislike em uma postagem, retorna uma lista de booleanos com os valores true e null
sendo true para botão não clicado e null para botão já clicado, recebe como argumentos uma String e um inteiro*/
Future<List<bool?>> checkLike(String userName, int postagemID) async{

  //Inicialmente a lista de booleanos recebe true para ambos os botões, pois ambos ainda não foram clicados
  List<bool?> listLikeDislike = [true, true];

  //parsing da url e requisição http em get
  final response = await http.get(
    //Uri.parse('http://10.54.2.110:8000/api/respostas_persistencia/${idUser}/'),
    Uri.parse(
        'http://localhost:8000/api/postagens_persistencia/${userName}/${postagemID}/'),
  );
  //resposta do servidor
  if (response.statusCode == 200){
    //decodificação da resposta do servidor em em JSON e depois conversão para uma lista de objetos
    var decodeBody = (jsonDecode(response.body) as List);
    for (var element in decodeBody) {
      //Verifica se o botão de dislike está ou não habilitado 
      if (element['tipoBotao'] == false) {
        listLikeDislike[0] = element['habilitado'];
      } 
      //Verifica se o botão de like está ou não habilitado 
      if (element['tipoBotao'] == true) {
        listLikeDislike[1] = element['habilitado'];
      }
    }
  //retorna a lista de booleanos, sendo listLikeDislike[0] para o botão de dislike e listLikeDislike[1] para o botão de like
  //caso tenha uma resposta do servidor igual a 200 
  return listLikeDislike;
  }
  else{
  //retorna a lista de booleanos como [true, true]
    return listLikeDislike;
  }}