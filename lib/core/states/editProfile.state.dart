import 'package:flutter/material.dart';
import 'package:kali/core/states/Input.state.dart';
import 'package:kali/core/states/user.state.dart';
import 'package:kali/core/utils/String.extension.dart';

final editProfileState = EditProfileState();

class EditProfileState extends ChangeNotifier {
  final isLoading = ValueNotifier<bool>(false);
  get canSave {
    var hasEmptyField =
        userName.value.isEmpty ||
        leitmotiv.value.isEmpty ||
        editingCalories.value.isEmpty ||
        editingProteins.value.isEmpty ||
        editingLipids.value.isEmpty ||
        editingGlucids.value.isEmpty;

    final user = userState.user.value;

    if (!hasEmptyField && user?.email != null) {
      hasEmptyField =
          inputState.email.value.isEmpty ||
          !inputState.email.value.isValidEmail();
    }

    var hasDifference =
        userName.value != user?.username ||
        leitmotiv.value != user?.leitmotiv ||
        editingCalories.value != user?.nutriscore?.caloryAmount.toString() ||
        editingProteins.value != user?.nutriscore?.proteinAmount.toString() ||
        editingLipids.value != user?.nutriscore?.lipidAmount.toString() ||
        editingGlucids.value != user?.nutriscore?.glucidAmount.toString();

    if (!hasDifference && user?.email != null) {
      hasDifference = inputState.email.value != user?.email;
    }

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
    inputState.email.addListener(notifyListeners);
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
    inputState.email.dispose();
    leitmotiv.dispose();
    editingCalories.dispose();
    editingProteins.dispose();
    editingLipids.dispose();
    editingGlucids.dispose();

    super.dispose();
  }
}
