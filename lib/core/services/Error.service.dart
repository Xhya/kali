import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kali/client/widgets/Register.widget.dart';
import 'package:kali/client/widgets/ValidateCode.widget.dart';
import 'package:kali/client/widgets/WelcomeBottomSheet.widget.dart';
import 'package:kali/core/actions/ConsumedAllTokensWithoutPaymentError.actions.dart';
import 'package:kali/core/services/Bugsnag.service.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/services/Translation.service.dart';
import 'package:kali/environment.dart';
import 'package:kali/core/states/Ai.state.dart';
import 'package:kali/core/states/register.state.dart';

final errorService = ErrorService();

class ErrorService extends ChangeNotifier {
  final _bugsnagService = BugsnagService();
  final error = ValueNotifier<String?>(null);

  ErrorService() {
    error.addListener(notifyListeners);
  }

  @override
  void dispose() {
    error.dispose();
    super.dispose();
  }

  void setError(String message) {
    if (error.value != message) {
      error.value = message;
    }
  }

  Response? currentResponseError;

  Future<void> notifyError({
    required Object e,
    StackTrace? stack,
    bool show = true,
  }) async {
    if (currentResponseError != null) {
      final Map<String, dynamic> jsonData = json.decode(
        currentResponseError!.body,
      );

      final int? hcErrorCode = jsonData['hc_error_code'];

      if (hcErrorCode == 1010) {
        // 1010 is ConsumedAllTokensWithoutPaymentException
        consumedAllTokensWithoutPaymentError();
        return;
      } else if (hcErrorCode == 1030) {
        // 1030 is MustValideCodeException
        navigationService.openBottomSheet(
          widget: WelcomeBottomSheet(
            child: ValidateCodeWidget(
              text: "Veuillez entrez le code que vous avez reçu par email",
            ),
          ),
        );
        return;
      } else if (hcErrorCode == 1040) {
        // 1040 is MustValideEmailException
        registerState.error.value = null;
        navigationService.openBottomSheet(
          widget: WelcomeBottomSheet(
            child: RegisterWidget(
              title: "Inscris toi 🔥",
              subtitle:
                  "Tu commences à avoir pas mal de données, enregistre ton e-mail pour ne pas perdre tes progrès !",
            ),
          ),
        );
        return;
      } else if (hcErrorCode == 2000) {
        // 2000 is
        aiState.aiNotUnderstandError.value = true;
        return;
      }
    }

    var extractedMessage;

    if (currentResponseError != null) {
      extractedMessage = _extractErrorMessage(currentResponseError!);
    }

    if (!isInProdEnv) {
      print("Error message: ${extractedMessage ?? e}");

      if (currentResponseError != null) {
        var responseJson = jsonDecode(currentResponseError!.body);
        print("Error details: $responseJson");
      }
    }

    if (show) {
      setError(
        isInProdEnv
            ? t("error_message")
            : extractedMessage ?? t("error_message"),
      );
    }

    if (isInDevEnv || isInProdEnv) {
      await _bugsnagService.notify(e: e, stack: stack);
    }
  }

  dynamic _extractErrorMessage(Response response) {
    final responseJson = jsonDecode(response.body);
    return responseJson['message'];
  }

  dynamic extractCurrentErrorMessage() {
    if (currentResponseError != null) {
      return _extractErrorMessage(currentResponseError!);
    }
  }
}
