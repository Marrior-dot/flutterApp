import 'package:projeto_perguntas/model/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<int> checkUserExists(String? nomeEmailUsuario) async{
  final response =  await http
      .get(Uri.parse('http://10.54.2.110:8000/api/users/${nomeEmailUsuario}/'));
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

Future<User> userLogin(String usuario, String senha) async {
  final response = await http
      //.get(Uri.parse('http://10.54.2.110:8000/home/userlist/'));
      //.get(Uri.parse('http://localhost:8000/api/userdetail/${usuario}/'));
      //.get(Uri.parse('http://10.54.2.110:8000/api/userdetail/${usuario}/'));
      .get(Uri.parse('http://10.54.2.110:8000/api/users/${usuario}/'));

  var usuarioMap = jsonDecode(response.body) as Map<String, dynamic>;
  var uuser = User.fromJson(usuarioMap);


  if (response.statusCode == 200 && uuser.password == senha) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return uuser;
  } 
  else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Falha servidor');
  }
}


Future<User> userCreate(
    String usuario, String email, String senha, String nome) async {
  final response = await http.post(
    Uri.parse('http://10.54.2.110:8000/api/users/'),
    //Uri.parse('http://10.54.2.110:8000/api/usercreate/'),
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
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}