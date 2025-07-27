import 'package:flutter/material.dart';
import 'package:kali/core/states/user.state.dart';

final editProfileState = EditProfileState();

class EditProfileState extends ChangeNotifier {
  final isLoading = ValueNotifier<bool>(false);
  get canSave {
    final hasEmptyField =
        userName.value.isEmpty ||
        leitmotiv.value.isEmpty ||
        editingCalories.value.isEmpty ||
        editingProteins.value.isEmpty ||
        editingLipids.value.isEmpty ||
        editingGlucids.value.isEmpty;

    final user = userState.user.value;

    final hasDifference =
        userName.value != user?.username ||
        leitmotiv.value != user?.leitmotiv ||
        editingCalories.value != user?.nutriscore?.caloryAmount.toString() ||
        editingProteins.value != user?.nutriscore?.proteinAmount.toString() ||
        editingLipids.value != user?.nutriscore?.lipidAmount.toString() ||
        editingGlucids.value != user?.nutriscore?.glucidAmount.toString();

    return !hasEmptyField && hasDifference;
  }

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
