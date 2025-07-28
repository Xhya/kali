import 'package:flutter/material.dart';
import 'package:kali/client/widgets/Register.widget.dart';
import 'package:kali/client/widgets/WelcomeBottomSheet.widget.dart';
import 'package:kali/core/domains/nutriScore.repository.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/services/User.service.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/states/startForm.state.dart';

void onClickBottomButton() async {
  startFormState.isLoading.value = true;
  try {
    if (startFormState.personalNutriScore.value != null) {
      await validatePersonalNutriScore();
      startFormState.personalNutriScore.value = null;
      navigationService.openBottomSheet(
        widget: WelcomeBottomSheet(child: RegisterWidget()),
      );
      navigationService.navigateTo(ScreenEnum.home);
    } else if (startFormState.isFormDone) {
      await computePersonalNutriScore();
      onClickNext();
    } else {
      onClickNext();
    }
  } catch (e) {
    errorService.notifyError(e: e);
  } finally {
    startFormState.isLoading.value = false;
  }
}

void onClickNext() {
  if (startFormState.currentPage.value < 5) {
    startFormState.currentPage.value = startFormState.currentPage.value + 1;
    startFormState.controller.value.animateToPage(
      startFormState.currentPage.value,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}

void onClickPrevious() {
  startFormState.personalNutriScore.value = null;

  if (startFormState.currentPage.value > 1) {
    startFormState.currentPage.value = startFormState.currentPage.value - 1;
    startFormState.controller.value.animateToPage(
      startFormState.currentPage.value,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}

Future<void> computePersonalNutriScore() async {
  startFormState.isLoading.value = true;
  final personalNutriScore = await UserService().computePersonalNutriScore(
    PersonalNutriScoreFormData(
      userName: startFormState.userName.value,
      leitmotiv: startFormState.leitmotiv.value,
      birthdate: startFormState.birthdate.value,
      gender: startFormState.genderOption.value?.label ?? "",
      height: startFormState.height.value,
      weight: startFormState.weight.value,
      targetWeight: startFormState.targetWeight.value,
      lifeActivity: startFormState.lifeOption.value?.label ?? "",
    ),
  );
  startFormState.personalNutriScore.value = personalNutriScore;
  startFormState.isLoading.value = false;
}

validatePersonalNutriScore() async {
  if (startFormState.personalNutriScore.value != null) {
    await userService.setPersonalNutriScore(
      startFormState.personalNutriScore.value!,
    );
  }
}
