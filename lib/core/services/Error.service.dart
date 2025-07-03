import 'package:flutter/material.dart';
import 'package:kalori/core/services/Crashlytics.service.dart';
import 'package:kalori/core/services/Translation.service.dart';
import 'package:kalori/environment.dart';

var errorService = ErrorService();

class ErrorService extends ChangeNotifier {
  final crashlyticsService = CrashlyticsService();
  String? error;

  notifyError({required Object e, StackTrace? stack}) {
    if (!isInProdEnv) {
      print(e);
    }

    error =
        isInProdEnv
            ? t("error_message")
            : e.toString().isNotEmpty
            ? e.toString()
            : t("error_message");
    if (isInProdEnv) {
      crashlyticsService.notifyError(e: e, stack: stack, reason: error);
    }

    notifyListeners();
  }
}
