import 'package:flutter/material.dart';
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:kali/core/models/User.model.dart';

var userState = UserState();

class UserState extends ChangeNotifier {
  final user = ValueNotifier<User?>(null);
  NutriScore? get personalNutriscore => user.value?.nutriscore;

  UserState() {
    user.addListener(notifyListeners);
  }

  @override
  void dispose() {
    user.dispose();
    super.dispose();
  }
}
