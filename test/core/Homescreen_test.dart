import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kali/client/screens/Start.screen.dart';
import 'package:kali/client/widgets/CustomSelect.widget.dart';
import 'package:kali/core/actions/startForm.actions.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/services/Translation.service.dart';
import 'package:kali/core/states/startForm.state.dart';

void main() {
  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await TranslationService().init();
  });

  onClickNextMock() async {
    try {
      await onClickBottomButton();
      // ignore: empty_catches
    } catch (e) {}
  }

  onClickPreviousMock() {
    try {
      onClickPrevious();
      // ignore: empty_catches
    } catch (e) {}
  }

  test('Homescreen', () async {
    navigationService.navigateTo(ScreenEnum.start);
    onClickStart();
    expect(navigationService.currentScreen, ScreenEnum.startForm);
    expect(startFormState.currentPage.value, 0);

    await onClickNextMock();
    expect(startFormState.currentPage.value, 0);

    startFormState.userName.value = "mama kitchen";
    expect(startFormState.userName.value, "mama kitchen");

    final selectedOption = SelectOption(value: "woman", label: t('woman'));
    startFormState.genderOption.value = selectedOption;
    expect(startFormState.genderOption.value, selectedOption);

    await onClickNextMock();
    expect(startFormState.currentPage.value, 0);

    startFormState.birthdate.value = "01/01/2000";
    expect(startFormState.birthdate.value, "01/01/2000");

    await onClickNextMock();
    expect(startFormState.currentPage.value, 1);

    await onClickPreviousMock();
    expect(startFormState.currentPage.value, 0);

    await onClickNextMock();
    expect(startFormState.currentPage.value, 1);

    startFormState.weight.value = 70;
    startFormState.targetWeight.value = 80;
    startFormState.height.value = 170;

    await onClickNextMock();
    expect(startFormState.currentPage.value, 2);

    await onClickNextMock();
    expect(startFormState.currentPage.value, 3);

    startFormState.lifeOption.value = SelectOption(
      value: "active",
      label: "Principalement debout",
    );

    startFormState.workActivityOption.value = SelectOption(
      value: "active",
      label: "Principalement debout",
    );

    expect(startFormState.isFormDone, true);

    await onClickNextMock();
    expect(startFormState.personalNutriScore.value, isNotNull);

    await onClickNextMock();
  });
}
