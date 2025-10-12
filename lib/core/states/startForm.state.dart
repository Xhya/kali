import 'package:flutter/material.dart';
import 'package:kali/client/widgets/CustomSelect.widget.dart';
import 'package:kali/core/models/NutriScore.model.dart';

final startFormState = StartFormState();

class StartFormState extends ChangeNotifier {
  final controller = ValueNotifier<PageController>(PageController());

  var personalNutriScore = ValueNotifier<NutriScore?>(null);

  final currentPage = ValueNotifier<int>(0);
  bool get isFormDone => currentPage.value == 3;

  final userName = ValueNotifier<String>("");
  final leitmotiv = ValueNotifier<String>("");

  // final birthdate = ValueNotifier<String>("");
  final age = ValueNotifier<int?>(null);
  final genderOption = ValueNotifier<SelectOption?>(null);

  final height = ValueNotifier<double?>(null);
  final weight = ValueNotifier<double?>(null);
  final targetWeight = ValueNotifier<double?>(null);

  final lifeOption = ValueNotifier<SelectOption?>(null);
  final workActivityOption = ValueNotifier<SelectOption?>(null);

  final isLoading = ValueNotifier<bool>(false);
  bool get isNextButtonDisabled {
    if (currentPage.value == 0) {
      return userName.value.trim().isEmpty ||
          age.value == null ||
          genderOption.value == null;
    } else if (currentPage.value == 1) {
      return height.value == null ||
          weight.value == null ||
          targetWeight.value == null;
    } else if (currentPage.value == 2) {
      return false;
    } else if (currentPage.value == 3) {
      return lifeOption.value == null || workActivityOption.value == null;
    } else {
      return false;
    }
  }

  StartFormState() {
    isLoading.addListener(notifyListeners);
    currentPage.addListener(notifyListeners);

    userName.addListener(notifyListeners);
    leitmotiv.addListener(notifyListeners);

    age.addListener(notifyListeners);
    genderOption.addListener(notifyListeners);

    height.addListener(notifyListeners);
    weight.addListener(notifyListeners);
    targetWeight.addListener(notifyListeners);

    lifeOption.addListener(notifyListeners);
    workActivityOption.addListener(notifyListeners);
  }

  @override
  void dispose() {
    isLoading.dispose();
    currentPage.dispose();

    userName.dispose();
    leitmotiv.dispose();

    age.dispose();
    genderOption.dispose();

    height.dispose();
    weight.dispose();
    targetWeight.dispose();

    lifeOption.dispose();
    workActivityOption.dispose();

    super.dispose();
  }
}
