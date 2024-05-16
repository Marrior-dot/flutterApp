import 'package:projeto_perguntas/model/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<User> userLogin(String usuario, String senha) async {
  final response = await http
      //.get(Uri.parse('http://10.54.2.110:8000/home/userlist/'));
      .get(Uri.parse('http://localhost:8000/api/userdetail/${usuario}/'));

  var usuarioMap = jsonDecode(response.body) as Map<String, dynamic>;
  var uuser = User.fromJson(usuarioMap);

  if (response.statusCode == 200 && senha == uuser.password) {
    print(uuser.username);
    // If the server did return a 200 OK response,
    // then parse the JSON.
    //print(uuser.runtimeType);
    return uuser;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
