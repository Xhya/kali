import 'package:flutter/material.dart';
import 'package:kali/client/widgets/Register.widget.dart';
import 'package:kali/client/widgets/WelcomeBottomSheet.widget.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/states/register.state.dart';

void showRegisterEmailBottomSheet({
  required BuildContext context,
  String? subtitle,
}) {
  navigationService.context = context;
  registerState.error.value = null;
  navigationService.openBottomSheet(
    widget: WelcomeBottomSheet(
      child: RegisterWidget(title: "Créer un compte", subtitle: subtitle),
    ),
  );
}
