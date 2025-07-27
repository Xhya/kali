class User {
  final String? id;
  final String? username;
  final String? leitmotiv;

  User({required this.id, required this.username, required this.leitmotiv});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String?,
      username: json['username'] as String?,
      leitmotiv: json['leitmotiv'] as String?,
    );
  }
}
