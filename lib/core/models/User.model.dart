import 'package:kali/core/models/NutriScore.model.dart';

class User {
  final String? id;
  final String? username;
  final String? email;
  final String? leitmotiv;
  final NutriScore? nutriscore;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.leitmotiv,
    required this.nutriscore,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      leitmotiv: json['leitmotiv'] as String?,
      nutriscore:
          json['nutriscore'] == null
              ? null
              : NutriScore.fromJson(json['nutriscore']),
    );
  }
}
