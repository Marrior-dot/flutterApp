import 'package:projeto_perguntas/model/user.dart' as Usuario;
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Usuario.User>> userLogin() async {
  final response = await http
      .get(Uri.parse('http://10.54.2.110:8000/home/userlist/'));

  print(response.body);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    var usuarioMap =
        (jsonDecode(response.body) as List).cast<Map<String, dynamic>>();
    var uuser = usuarioMap
        .map<Usuario.User>((json) => Usuario.User.fromJson(json))
        .toList();
    print(uuser);    
    return uuser;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

