import 'package:flutter/material.dart';
import 'package:kali/client/widgets/CustomSelect.widget.dart';
import 'package:kali/core/utils/String.extension.dart';

enum GenderEnum {
  female('female'),
  male('male'),
  other('other');

  const GenderEnum(this.label);
  final String label;

  factory GenderEnum.fromText(String text) {
    return GenderEnum.values.firstWhere((it) => it.label == text);
  }
}

enum ResultEnum {
  quick('quick'),
  normal('normal');

  const ResultEnum(this.label);
  final String label;

  factory ResultEnum.fromText(String text) {
    return ResultEnum.values.firstWhere((it) => it.label == text);
  }
}

var startFormState = StartFormState();

class StartFormState extends ChangeNotifier {
  final controller = ValueNotifier<PageController>(PageController());

  final currentPage = ValueNotifier<int>(0);

  final userName = ValueNotifier<String>("");
  final leitmotiv = ValueNotifier<String>("");

  final birthdate = ValueNotifier<String>("");
  final genderOption = ValueNotifier<SelectOption?>(null);

  final size = ValueNotifier<String>("");
  final weight = ValueNotifier<String>("");
  final targetWeight = ValueNotifier<String>("");
  final resultOption = ValueNotifier<SelectOption?>(null);

  final age = ValueNotifier<String>("");
  final isLoading = ValueNotifier<bool>(false);
  bool get isNextButtonDisabled {
    if (currentPage.value == 0) {
      return userName.value.trim().isEmpty || leitmotiv.value.trim().isEmpty;
    } else if (currentPage.value == 1) {
      return !birthdate.value.trim().isValidDate() || genderOption.value == null;
    } else if (currentPage.value == 2) {
      return size.value.trim().isEmpty ||
          weight.value.trim().isEmpty ||
          targetWeight.value.trim().isEmpty ||
          resultOption.value == null;
    } else {
      return userName.value.isEmpty ||
          leitmotiv.value.isEmpty ||
          size.value.isEmpty ||
          weight.value.isEmpty ||
          age.value.isEmpty;
    }
  }

  final objectiveOption = ValueNotifier<SelectOption?>(null);

  StartFormState() {
    age.addListener(notifyListeners);
    isLoading.addListener(notifyListeners);
    currentPage.addListener(notifyListeners);
    objectiveOption.addListener(notifyListeners);

    userName.addListener(notifyListeners);
    leitmotiv.addListener(notifyListeners);

    birthdate.addListener(notifyListeners);
    genderOption.addListener(notifyListeners);

    size.addListener(notifyListeners);
    weight.addListener(notifyListeners);
    targetWeight.addListener(notifyListeners);
    resultOption.addListener(notifyListeners);
  }

  @override
  void dispose() {
    age.dispose();
    isLoading.dispose();
    currentPage.dispose();
    objectiveOption.dispose();
    userName.dispose();
    leitmotiv.dispose();

    birthdate.dispose();
    genderOption.dispose();

    size.dispose();
    weight.dispose();
    targetWeight.dispose();
    resultOption.dispose();

    super.dispose();
  }
}
