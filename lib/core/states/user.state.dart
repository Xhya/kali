import 'package:flutter/material.dart';
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:kali/core/models/User.model.dart';

final userState = UserState();

class UserState extends ChangeNotifier {
  final isDeconnectLoading = ValueNotifier<bool>(false);
  final user = ValueNotifier<User?>(null);
  NutriScore? get personalNutriscore => user.value?.nutriscore;

  UserState() {
    user.addListener(notifyListeners);
    isDeconnectLoading.addListener(notifyListeners);
  }

  @override
  void dispose() {
    user.dispose();
    isDeconnectLoading.dispose();
    super.dispose();
  }
}
