import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kali/client/widgets/WelcomeBottomSheet.widget.dart';
import 'package:kali/core/services/Bugsnag.service.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/services/Translation.service.dart';
import 'package:kali/environment.dart';

var errorService = ErrorService();

class ErrorService extends ChangeNotifier {
  final bugsnagService = BugsnagService();
  String? error;

  Response? currentResponseError;

  notifyError({required Object e, StackTrace? stack, bool show = true}) async {
    if (currentResponseError?.statusCode == 410) {
      navigationService.openBottomSheet(widget: WelcomeBottomSheet());
      return;
    }

    var extractedMessage;

    if (currentResponseError != null) {
      extractedMessage = _extractErrorMessage(currentResponseError!);
    }

    if (!isInProdEnv) {
      print("Error message: $extractedMessage");

      if (currentResponseError != null) {
        var responseJson = jsonDecode(currentResponseError!.body);
        print("Error details: $responseJson");
      }
    }

    if (show) {
      error =
          isInProdEnv
              ? t("error_message")
              : extractedMessage ?? t("error_message");
    }

    if (isInDevEnv || isInProdEnv) {
      await bugsnagService.notify(e: e, stack: stack);
    }

    notifyListeners();
  }

  _extractErrorMessage(Response response) {
    var responseJson = jsonDecode(response.body);
    return responseJson['message'];
  }
}
