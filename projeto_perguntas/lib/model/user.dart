class User {
  final String name;
  final String password;
  final String email;
  final String username;


  const User(this.name,this.password, this.email,this.username);

  User.fromJson(Map<String, dynamic> json) 
      : name = json['name'] as String,
        password = json['password'] as String,
        email = json['email'] as String,
        username = json['username'] as String;
  Map<String, dynamic> toJson() => {
        'name': name,
        'password': password,
        'email': email,
        'username': username
      }; //=> throw const FormatException('Falha ao carregar dados de usuários');
    
}
