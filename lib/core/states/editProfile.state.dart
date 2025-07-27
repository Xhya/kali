import 'package:flutter/material.dart';

final editProfileState = EditProfileState();

class EditProfileState extends ChangeNotifier {
  final isLoading = ValueNotifier<bool>(false);
  
  final userName = ValueNotifier<String>("");
  final leitmotiv = ValueNotifier<String>("");
  final editingCalories = ValueNotifier<String>("");
  final editingProteins = ValueNotifier<String>("");
  final editingLipids = ValueNotifier<String>("");
  final editingGlucids = ValueNotifier<String>("");

  EditProfileState() {
    isLoading.addListener(notifyListeners);

    userName.addListener(notifyListeners);
    leitmotiv.addListener(notifyListeners);
    editingCalories.addListener(notifyListeners);
    editingProteins.addListener(notifyListeners);
    editingLipids.addListener(notifyListeners);
    editingGlucids.addListener(notifyListeners);
  }

  @override
  void dispose() {
    isLoading.dispose();

    userName.dispose();
    leitmotiv.dispose();
    editingCalories.dispose();
    editingProteins.dispose();
    editingLipids.dispose();
    editingGlucids.dispose();

    super.dispose();
  }
}
