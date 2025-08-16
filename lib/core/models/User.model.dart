import 'package:kali/core/models/NutriScore.model.dart';

class User {
  final String? id;
  final String? username;
  final String? email;
  final DateTime? emailVerifiedAt;
  final String? leitmotiv;
  final NutriScore? nutriscore;
  final bool hasValidSubscription;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.emailVerifiedAt,
    required this.leitmotiv,
    required this.nutriscore,
    required this.hasValidSubscription,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      emailVerifiedAt:
          json['emailVerifiedAt'] != null
              ? DateTime.parse(json['emailVerifiedAt']).toLocal()
              : null,
      leitmotiv: json['leitmotiv'] as String?,
      nutriscore:
          json['nutriscore'] == null
              ? null
              : NutriScore.fromJson(json['nutriscore']),
      hasValidSubscription: json['hasValidSubscription'] as bool? ?? false,
    );
  }

  emailVerified() {
    return email != null && email!.isNotEmpty && emailVerifiedAt != null;
  }
}
