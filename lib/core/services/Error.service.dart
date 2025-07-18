import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kali/core/services/Bugsnag.service.dart';
import 'package:kali/core/services/Translation.service.dart';
import 'package:kali/environment.dart';

var errorService = ErrorService();

class ErrorService extends ChangeNotifier {
  final bugsnagService = BugsnagService();
  String? error;

  Response? currentResponseError;

  notifyError({required Object e, StackTrace? stack}) async {
    if (!isInProdEnv) {
      if (currentResponseError != null) {
        print(_extractErrorMessage(currentResponseError!));
      }
    }

    error =
        isInProdEnv
            ? t("error_message")
            : e.toString().isNotEmpty
            ? e.toString()
            : t("error_message");

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
