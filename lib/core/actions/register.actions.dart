import 'package:flutter/material.dart';
import 'package:kali/client/widgets/Register.widget.dart';
import 'package:kali/client/widgets/Subscriptions.widget.dart';
import 'package:kali/client/widgets/WelcomeBottomSheet.widget.dart';
import 'package:kali/core/actions/congratulationNextAction.actions.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/states/user.state.dart';

onClickSubscribe(BuildContext context) async {
  navigationService.context = context;
  if (userState.user.value?.emailVerifiedAt == null) {
    onClickRegister(context);
  } else {
    navigationService.openBottomSheet(
      widget: WelcomeBottomSheet(child: SubscriptionWidget()),
    );
  }
}

onClickRegister(BuildContext context) async {
  navigationService.nextAction = () async {
    await congratulationNextAction(context);
  };
  navigationService.openBottomSheet(
    widget: WelcomeBottomSheet(child: RegisterWidget(title: "Inscris-toi")),
  );
}
