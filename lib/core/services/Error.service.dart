import 'package:flutter/material.dart';
import 'package:kalori/core/services/Bugsnag.service.dart';
import 'package:kalori/core/services/Translation.service.dart';
import 'package:kalori/environment.dart';

var errorService = ErrorService();

class ErrorService extends ChangeNotifier {
  final bugsnagService = BugsnagService();
  String? error;

  notifyError({required Object e, StackTrace? stack}) async {
    if (!isInProdEnv) {
      print(e);
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
}
