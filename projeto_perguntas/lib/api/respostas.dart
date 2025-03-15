import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projeto_perguntas/model/respostas.dart';


/// Busca uma lista de respostas de uma postagem específica.
///
/// Recebe o ID da postagem como parâmetro
/// 
Future<List<Respostas>?> fetchRespostas(int postagem) async {
  final response =
      //await http.get(Uri.parse('http://10.54.2.110:8000/api/respostas/$postagem/'));
      await http
          .get(Uri.parse('http://localhost:8000/api/respostas/$postagem/'));

/// Retorna um Future que contém uma lista de objetos `Respostas` se a requisição for bem-sucedida (código 200).
  if (response.statusCode == 200) {

    /// A variável `repostasDecode` contém a resposta decodificada do JSON para uma lista de mapas.
    var repostasDecode =
        (jsonDecode(response.body) as List).cast<Map<String, dynamic>>();
    /// A variável `respostasMap` contém a lista de objetos `Respostas` criados a partir dos mapas.
    var respostasMap = repostasDecode
        .map<Respostas>((json) => Respostas.fromJson(json))
        .toList();

    return respostasMap;
  }
  /// Lança uma exceção se a requisição falhar (código diferente de 200). 
  else {
    throw Exception('Não foi possível carregar as respostas.');
  }
}

/// Atualiza uma resposta existente.
///
/// Recebe o texto da resposta e o ID da postagem como parâmetros.
Future<Respostas> updateResposta(String? respostaTexto, int idPostagem) async {
  final response = await http.patch(
    //Uri.parse('http://10.54.2.110:8000/api/respostas/${idPostagem}/${respostaTexto}/'),
    Uri.parse(
        'http://localhost:8000/api/respostas/${idPostagem}/${respostaTexto}/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
/// Retorna um Future que contém um objeto `Respostas` se a requisição for bem-sucedida (código 200).
  if (response.statusCode == 200) {
    // Parsing do Json para um objeto Respostas
    return Respostas.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  } 
  /// Lança uma exceção se a requisição falhar (código diferente de 200).
  else {
    throw Exception('Failed to update album.');
  }
}

/// Persiste a resposta do usuário para uma postagem específica.
///
/// Recebe o nome do usuário e o ID da postagem como parâmetros.
Future<void> persistencaRespostas(String userName, int postagemID) async {
  final response = await http.post(
    //Uri.parse('http://10.54.2.110:8000/api/users/'),
    Uri.parse(
        'http://localhost:8000/api/respostas_persistencia/${userName}/${postagemID}/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },

    /// Corpo da requisição em formato JSON.
    body: jsonEncode(<String, dynamic>{
      "user": userName,
      "postagem": postagemID,
    }),
  );

  /// Retorna um Future vazio se a requisição for bem-sucedida (código 201).
  if (response.statusCode == 201) {
    return;
  } 
  /// Lança uma exceção se a requisição falhar (código diferente de 201).
  else {
    throw Exception('Falha ao salvar persistência');
  }
}

/// Verifica se uma resposta já existe para um usuário e postagem específicos.
///
/// Recebe o nome do usuário e o ID da postagem como parâmetros.
Future<bool?> checkRespostas(String userName, int postagemID) async {
  final response = await http.get(
    //Uri.parse('http://10.54.2.110:8000/api/respostas_persistencia/${idUser}/'),
    Uri.parse(
        'http://localhost:8000/api/respostas_persistencia/${userName}/${postagemID}/'),
  );
  /// Retorna um Future que contém um booleano nulo se a requisição for bem-sucedida (código 200), indicando que não há resposta.
  if (response.statusCode == 200) {
    return null;
  }
  /// Retorna true se a resposta existir.
  return true;
}
