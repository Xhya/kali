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
    navigationService.nextAction = () async {
      await subscribeAction(context);
    };
    registerAction(context);
  } else {
    subscribeAction(context);
  }
}

registerAction(BuildContext context) async {
  navigationService.openBottomSheet(
    widget: WelcomeBottomSheet(child: RegisterWidget(title: "Inscris-toi")),
  );
}

subscribeAction(BuildContext context) async {
  navigationService.context = context;
  navigationService.nextAction = () async {
    await congratulationNextAction(context);
  };
  navigationService.openBottomSheet(
    widget: WelcomeBottomSheet(
      child: SubscriptionWidget(title: "Abonne-toi et rejoins l'aventure"),
    ),
  );
}
