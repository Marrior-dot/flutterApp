class User {
  final String username;
  final String password;

  const User({
    required this.username,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'username': String username,
        'password': String password,
      } =>
        User(
          username: username,
          password: password,
        ),
      _ => throw const FormatException('Falha ao carregar dados de usuários'),
    };
  }
}
