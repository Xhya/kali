import 'package:flutter/material.dart';
import 'package:kali/client/widgets/AnimatedLoading.widget.dart';
import 'package:kali/client/widgets/FullScreenBottomSheet.widget.dart';
import 'package:kali/client/widgets/Register.widget.dart';
import 'package:kali/client/widgets/WelcomeBottomSheet.widget.dart';
import 'package:kali/core/actions/confetti.actions.dart';
import 'package:kali/core/domains/nutriScore.repository.dart';
import 'package:kali/core/services/Authentication.service.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/services/User.service.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/states/startForm.state.dart';
import 'package:kali/core/states/register.state.dart';

void onClickBottomButton(BuildContext context) async {
  startFormState.isLoading.value = true;
  try {
    if (startFormState.personalNutriScore.value != null) {
      await _onClickConfirmPersonalNutriscore();
    } else if (startFormState.isFormDone) {
      await _submitFormAndComputeNutriscore();
    } else {
      onClickNext();
    }
  } catch (e) {
    errorService.notifyError(e: e);
  } finally {
    startFormState.isLoading.value = false;
  }
}

Future<void> _submitFormAndComputeNutriscore() async {
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
  await authenticationService.initSignature();
  await computePersonalNutriScore();
  navigationService.navigateBack();
  onClickNext();
}

Future<void> _onClickConfirmPersonalNutriscore() async {
  var currentContext = navigationService.context;
  startFormState.personalNutriScore.value = null;
  navigationService.nextAction = () async {
    navigationService.context = currentContext;
    await launchConfetti();
  };
  registerState.error.value = null;
  navigationService.openBottomSheet(
    widget: WelcomeBottomSheet(
      child: RegisterWidget(
        title: "Bienvenu·e à bord 🔥",
        subtitle: "Inscris toi pour ne pas perdre tes progrès !",
      ),
    ),
  );
  navigationService.navigateTo(ScreenEnum.home);
  launchConfetti();
  await userService.refreshUser();
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
  if (startFormState.height.value != null &&
      startFormState.weight.value != null &&
      startFormState.targetWeight.value != null) {
        
    final personalNutriScore = await UserService().computePersonalNutriScore(
      PersonalNutriScoreFormData(
        userName: startFormState.userName.value,
        leitmotiv: startFormState.leitmotiv.value,
        birthdate: startFormState.birthdate.value,
        gender: startFormState.genderOption.value?.label ?? "",
        height: startFormState.height.value!,
        weight: startFormState.weight.value!,
        targetWeight: startFormState.targetWeight.value!,
        lifeActivity: startFormState.lifeOption.value?.label ?? "",
        workActivity: startFormState.workActivityOption.value?.label ?? "",
      ),
    );

    startFormState.personalNutriScore.value = personalNutriScore;
    startFormState.isLoading.value = false;
  }
}

Future<void> validatePersonalNutriScore() async {
  if (startFormState.personalNutriScore.value != null) {
    await userService.setPersonalNutriScore(
      startFormState.personalNutriScore.value!,
    );
  }
}
