import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kali/client/widgets/Register.widget.dart';
import 'package:kali/client/widgets/WelcomeBottomSheet.widget.dart';
import 'package:kali/core/actions/ConsumedAllTokensWithoutPaymentError.actions.dart';
import 'package:kali/core/services/Bugsnag.service.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/services/Translation.service.dart';
import 'package:kali/core/states/user.state.dart';
import 'package:kali/environment.dart';

var errorService = ErrorService();

class ErrorService extends ChangeNotifier {
  final _bugsnagService = BugsnagService();
  String? error;

  Response? currentResponseError;

  notifyError({required Object e, StackTrace? stack, bool show = true}) async {
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
        // 1030 is ?
        if (userState.user.value?.hasValidSubscription != true) {
          final message = jsonData['message'] ?? "";
          navigationService.openBottomSheet(
            widget: WelcomeBottomSheet(
              child: RegisterWidget(title: "Inscris-toi", subtitle: message),
            ),
          );
          // TODO: afficher un message de bienvenue!
        } else {
          // TODO: afficher subscription widget
        }

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
      error =
          isInProdEnv
              ? t("error_message")
              : extractedMessage ?? t("error_message");
    }

    if (isInDevEnv || isInProdEnv) {
      await _bugsnagService.notify(e: e, stack: stack);
    }

    notifyListeners();
  }

  _extractErrorMessage(Response response) {
    final responseJson = jsonDecode(response.body);
    return responseJson['message'];
  }
}
