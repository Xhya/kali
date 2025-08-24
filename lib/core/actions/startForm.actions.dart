import 'package:flutter/material.dart';
import 'package:kali/client/widgets/AnimatedLoading.widget.dart';
import 'package:kali/client/widgets/FullScreenBottomSheet.widget.dart';
import 'package:kali/client/widgets/Register.widget.dart';
import 'package:kali/client/widgets/WelcomeBottomSheet.widget.dart';
import 'package:kali/core/actions/confetti.actions.dart';
import 'package:kali/core/domains/nutriScore.repository.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/services/User.service.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/states/startForm.state.dart';

void onClickBottomButton() async {
  startFormState.isLoading.value = true;
  try {
    if (startFormState.personalNutriScore.value != null) {
      startFormState.personalNutriScore.value = null;
      await userService.refreshUser();
      navigationService.openBottomSheet(
        widget: WelcomeBottomSheet(
          child: RegisterWidget(
            title: "Bienvenu·e à bord 🔥",
            subtitle:
                "Inscris toi pour avoir accès à 3 jours d'essai gratuit !",
          ),
        ),
      );
      navigationService.navigateTo(ScreenEnum.home);
      launchConfetti();
    } else if (startFormState.isFormDone) {
      navigationService.openBottomSheet(
        widget: FullScreenBottomSheet(
          canClose: false,
          child: Center(
            child: AnimatedLoadingWidget(
              title: "Kali fait ses comptes.. ⚖️",
              subtitle:
                  "D'après toutes les informations que tu viens de me donner, je réfléchis au meilleur des plans",
            ),
          ),
        ),
      );
      await computePersonalNutriScore();
      navigationService.navigateBack();
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
  if (startFormState.currentPage.value == 0) {
    navigationService.navigateBack();
    return;
  }

  startFormState.personalNutriScore.value = null;

  if (startFormState.currentPage.value >= 1) {
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
