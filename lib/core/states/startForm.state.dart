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

enum ResultOptionEnum {
  quick('quick'),
  normal('normal');

  const ResultOptionEnum(this.label);
  final String label;

  factory ResultOptionEnum.fromText(String text) {
    return ResultOptionEnum.values.firstWhere((it) => it.label == text);
  }
}

enum ObjectiveOptionEnum {
  loseWeight('lose_weight'),
  maintainWeight('maintain_weight'),
  gainMuscle('gain_muscle');

  const ObjectiveOptionEnum(this.label);
  final String label;

  factory ObjectiveOptionEnum.fromText(String text) {
    return ObjectiveOptionEnum.values.firstWhere((it) => it.label == text);
  }
}

enum LifeOptionEnum {
  sit('sit'),
  stand('stand'),
  active('active');

  const LifeOptionEnum(this.label);
  final String label;

  factory LifeOptionEnum.fromText(String text) {
    return LifeOptionEnum.values.firstWhere((it) => it.label == text);
  }
}

var startFormState = StartFormState();

class StartFormState extends ChangeNotifier {
  final controller = ValueNotifier<PageController>(PageController());

  final currentPage = ValueNotifier<int>(0);
  bool get isFormDone => currentPage.value == 4;

  final userName = ValueNotifier<String>("");
  final leitmotiv = ValueNotifier<String>("");

  final birthdate = ValueNotifier<String>("");
  final genderOption = ValueNotifier<SelectOption?>(null);

  final size = ValueNotifier<String>("");
  final weight = ValueNotifier<String>("");
  final targetWeight = ValueNotifier<String>("");
  final resultOption = ValueNotifier<SelectOption?>(null);

  final objectiveOption = ValueNotifier<SelectOption?>(null);

  final lifeOption = ValueNotifier<SelectOption?>(null);

  final isLoading = ValueNotifier<bool>(false);
  bool get isNextButtonDisabled {
    if (currentPage.value == 0) {
      return userName.value.trim().isEmpty || leitmotiv.value.trim().isEmpty;
    } else if (currentPage.value == 1) {
      return !birthdate.value.trim().isValidDate() ||
          genderOption.value == null;
    } else if (currentPage.value == 2) {
      return size.value.trim().isEmpty ||
          weight.value.trim().isEmpty ||
          targetWeight.value.trim().isEmpty ||
          resultOption.value == null;
    } else if (currentPage.value == 3) {
      return objectiveOption.value == null;
    } else if (currentPage.value == 4) {
      return lifeOption.value == null;
    } else {
      return false;
    }
  }

  StartFormState() {
    isLoading.addListener(notifyListeners);
    currentPage.addListener(notifyListeners);

    userName.addListener(notifyListeners);
    leitmotiv.addListener(notifyListeners);

    birthdate.addListener(notifyListeners);
    genderOption.addListener(notifyListeners);

    size.addListener(notifyListeners);
    weight.addListener(notifyListeners);
    targetWeight.addListener(notifyListeners);
    resultOption.addListener(notifyListeners);

    objectiveOption.addListener(notifyListeners);

    lifeOption.addListener(notifyListeners);
  }

  @override
  void dispose() {
    isLoading.dispose();
    currentPage.dispose();

    userName.dispose();
    leitmotiv.dispose();

    birthdate.dispose();
    genderOption.dispose();

    size.dispose();
    weight.dispose();
    targetWeight.dispose();
    resultOption.dispose();

    objectiveOption.dispose();

    lifeOption.dispose();

    super.dispose();
  }
}
