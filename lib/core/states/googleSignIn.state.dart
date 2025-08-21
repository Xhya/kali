import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final googleSignInState = GoogleSignInState();

class GoogleSignInState extends ChangeNotifier {
  final signInGoogle = ValueNotifier<GoogleSignIn?>(null);
  final action = ValueNotifier<String>("");
  final email = ValueNotifier<String>("");
  final token = ValueNotifier<String>("");

  GoogleSignInState() {
    action.addListener(notifyListeners);
    email.addListener(notifyListeners);
    token.addListener(notifyListeners);
  }

  @override
  void dispose() {
    action.dispose();
    email.dispose();
    token.dispose();
    super.dispose();
  }
}
