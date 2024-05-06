import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

//@JsonSerializable()
/*class User {
  User(this.name, this.password, this.email, this.username);

  String name;
  String password;
  String email;
  String username;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}*/

class User {
  final String name;
  final String password;
  final String email;
  final String username;

  const User(this.name, this.password, this.email, this.username);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        password = json['password'] as String,
        email = json['email'] as String,
        username = json['username'] as String;

  Map<String, dynamic> toJson() => {
        'name': name,
        'passWord': password,
        'email': email,
        'username': username
      }; //=> throw const FormatException('Falha ao carregar dados de usuários');
}
