class User {
  final String name;
  final String surname;
  final String email;

  User({
    required this.name,
    required this.surname,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      surname: json['surname'] as String,
      email: json['email'] as String,
    );
  }
}
