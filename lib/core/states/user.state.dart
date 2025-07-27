import 'package:flutter/material.dart';
import 'package:kali/core/models/User.model.dart';

var userState = UserState();

class UserState extends ChangeNotifier {
  final user = ValueNotifier<User?>(null);

  UserState() {
    user.addListener(notifyListeners);
  }

  @override
  void dispose() {
    user.dispose();
    super.dispose();
  }
}
