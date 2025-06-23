import 'package:flutter/material.dart';
import 'package:kalori/core/services/Translation.service.dart';
import 'package:kalori/environment.dart';

var errorService = ErrorService();

class ErrorService extends ChangeNotifier {
  String? error;

  notifyError(Object e) {
    if (!isInProdEnv) {
      print(e);
    }

    error =
        isInProdEnv
            ? t("error_message")
            : e.toString().isNotEmpty
            ? e.toString()
            : t("error_message");

    notifyListeners();
  }
}
