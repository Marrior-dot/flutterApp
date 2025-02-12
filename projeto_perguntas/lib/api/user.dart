import 'package:projeto_perguntas/model/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// Verifica se um usuário existe com base no nome de usuário ou email fornecido.
///
/// Recebe um nome de usuário ou email como parâmetro.
/// Retorna o código de status 200 se o usuário existir.
/// Lança uma exceção se ocorrer uma falha na requisição ou o usuário não existir (status code diferente de 200).
Future<int> checkUserExists(String? nomeEmailUsuario) async {
  final response = await http.get(
      Uri.parse('http://localhost:8000/api/users/${nomeEmailUsuario}/'));

  if (response.statusCode == 200) {
    // Se o servidor retornar uma resposta 200 OK,
    // então retorna o código de status.
    return response.statusCode;
  } else {
    // Se o servidor não retornar uma resposta 200 OK,
    // então lança uma exceção.
    throw Exception('Falha servidor');
  }
}

/// Realiza o login de um usuário.
///
/// Recebe o nome de usuário e senha como parâmetros.
/// Retorna um objeto User se o login for bem-sucedido.
/// Lança uma exceção se ocorrer uma falha na requisição, o usuário não existir ou a senha estiver incorreta.
Future<User> userLogin(String usuario, String senha) async {
  final response = await http

      .get(Uri.parse('http://localhost:8000/api/users/${usuario}/'));

  var usuarioMap = jsonDecode(response.body) as Map<String, dynamic>;
  var uuser = User.fromJson(usuarioMap);

  if (response.statusCode == 200 && uuser.password == senha) {
    // Se o servidor retornar uma resposta 200 OK e a senha estiver correta,
    // então retorna o objeto User.
    return uuser;
  } else {
    // Se o servidor não retornar uma resposta 200 OK ou a senha estiver incorreta,
    // então lança uma exceção.
    throw Exception('Falha servidor');
  }
}


/// Cria um novo usuário.
///
/// Recebe o nome de usuário, email, senha e nome como parâmetros.
/// Retorna um objeto User se o usuário for criado com sucesso.
/// Lança uma exceção se ocorrer uma falha na requisição ou o usuário não puder ser criado.
Future<User> userCreate(
    String usuario, String email, String senha, String nome) async {
  final response = await http.post(
    //Uri.parse('http://10.54.2.110:8000/api/users/'),
    Uri.parse('http://localhost:8000/api/users/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "name": nome,
      "password": senha,
      "email": email,
      "username": usuario
    }),
  );

  if (response.statusCode == 201) {
    // Se o servidor retornar uma resposta 201 CREATED,
    // então retorna o objeto User.
    return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // Se o servidor não retornar uma resposta 201 CREATED,
    // então lança uma exceção.
    throw Exception('Falha ao criar usuário.');
  }
}

/// Edita os dados de um usuário.
///
/// Recebe o nome de usuário, senha e email como parâmetros.
/// Retorna um objeto User se os dados forem atualizados com sucesso.
/// Lança uma exceção se ocorrer uma falha na requisição ou os dados não puderem ser atualizados.
Future<User> userEdit(String username, String senha, String email) async {
  // Cria um mapa com as chaves e valores a serem atualizados
  Map<String, String> corpoRequisicao = {};

  //Se a senha não estiver vazia, adiciona a chave 'password' e o valor correspondente ao mapa
  if (senha != "") {
    corpoRequisicao.addEntries([MapEntry('password', senha)]);
  }

  //Se o email não estiver vazio, adiciona a chave 'email' e o valor correspondente ao mapa
  if (email != "") {
    corpoRequisicao.addEntries([MapEntry('email', email)]);
  }
  final response = await http.patch(
    Uri.parse('http://localhost:8000/api/users/${username}/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    //variável corpoRequisicao é mandada no corpo da requisição
    body: jsonEncode(corpoRequisicao),
  );
  var usuarioMap = jsonDecode(response.body) as Map<String, dynamic>;
  var uuser = User.fromJson(usuarioMap);

  //Se o servidor retornar uma resposta 200 OK, então retorna o objeto User.
  if (response.statusCode == 200) {
    print(uuser.password);
    return uuser;
  } 
  //Se o servidor não retornar uma resposta 200 OK, então lança uma exceção.
  else {
    throw Exception('Falha ao atualizar dados de usuário');

  }
}

/// Exclui um usuário.
///
/// Recebe o nome de usuário como parâmetro.
Future<void> userDelete(String username) async {
  final response = await http.delete(
    //Uri.parse('http://10.54.2.110:8000/api/users/${username}/'),
    Uri.parse('http://localhost:8000/api/users/${username}/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  /// Retorna void se o usuário for excluído com sucesso.
  if (response.statusCode == 204) {
    return;
  } 
  /// Lança uma exceção se ocorrer uma falha na requisição ou o usuário não puder ser excluído.
  else {
    throw Exception('Falha ao deletar usuário');
  }
}