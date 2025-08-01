import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kali/client/widgets/Register.widget.dart';
import 'package:kali/client/widgets/WelcomeBottomSheet.widget.dart';
import 'package:kali/core/domains/configurations.repository.dart';
import 'package:kali/core/services/Bugsnag.service.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/services/Translation.service.dart';
import 'package:kali/core/states/Texts.state.dart';
import 'package:kali/environment.dart';

var errorService = ErrorService();

class ErrorService extends ChangeNotifier {
  final bugsnagService = BugsnagService();
  final _configurationsRepository = ConfigurationsRepository();
  String? error;

  Response? currentResponseError;

  init() async {
    final texts = await _configurationsRepository.getInitTexts();
    textsState.needEmailText.value = texts[1].value ?? "";
  }

  notifyError({required Object e, StackTrace? stack, bool show = true}) async {
    if (currentResponseError != null) {
      final Map<String, dynamic> jsonData = json.decode(
        currentResponseError!.body,
      );

      final int? hcErrorCode = jsonData['hc_error_code'];

      if (hcErrorCode == 1001) {
        navigationService.openBottomSheet(
          widget: WelcomeBottomSheet(
            child: RegisterWidget(
              title: "Inscris toi 🔥",
              subtitle:
                  "Valide ton e-mail pour avoir accès à 3 jours d'essai gratuit",
            ),
          ),
        );
        return;
      } else if (hcErrorCode == 1002) {
        navigationService.openBottomSheet(
          widget: WelcomeBottomSheet(
            child: RegisterWidget(
              title: "Paye 🔥",
              subtitle:
                  "Tu dois payer maintenant!",
            ),
          ),
        );
        return;
      }
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

    print(show);


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
