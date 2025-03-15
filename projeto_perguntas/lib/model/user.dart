class User {
  //Atributos
  final String name;
  final String password;
  final String email;
  final String username;

  //Construtor
  const User(this.name, this.password, this.email, this.username);

  //Converte um Json em objeto User
  User.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        password = json['password'] as String,
        email = json['email'] as String,
        username = json['username'] as String;
  //Converte um objeto User em Json
  Map<String, dynamic> toJson() => {
        'name': name,
        'passWord': password,
        'email': email,
        'username': username
      };
}
