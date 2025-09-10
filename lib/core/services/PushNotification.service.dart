import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:kali/client/widgets/QuickAddMealButton.widget.dart';
import 'package:kali/core/domains/nutriscore.service.dart';
import 'package:kali/core/domains/pushNotification.repository.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/states/user.state.dart';
import 'package:kali/environment.dart';
import 'package:app_links/app_links.dart';
import 'package:kali/core/states/quickAddMeal.state.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final _pushNotificationRespository = PushNotificationRepository();

  Future<String?> _getToken() async {
    String? token = await _fcm.getToken();
    return token;
  }

  Future<void> refreshNotificationToken() async {
    if (!isInTestEnv && !kIsWeb) {
      String? token = await _getToken();

      if (token != null) {
        await _pushNotificationRespository.setNotificationToken(token);
      }
    }
  }

  final _appLinks = AppLinks();

  void initDeepLinks() {
    _appLinks.uriLinkStream.listen((uri) async {
      if (uri.path == '/home/quick-add') {
        if (userState.user.value == null) {
          errorService.setError(
            "Vous devez être connecté pour ajouter un repas.",
          );
        } else {
          final nutriscoreId = uri.queryParameters['id'] ?? "";
          await quickAddMealOnPush(nutriscoreId);
        }
      }
    });
  }

  Future<void> quickAddMealOnPush(String nutriscoreId) async {
    navigationService.navigateTo(ScreenEnum.home);

    final nutriscore = await nutriscoreService.getNutriscore(
      nutriscoreId: nutriscoreId,
    );

    await onClickAddQuickMeal();
    quickAddMealState.nutriscore.value = nutriscore;
    quickAddMealState.userMealText.value = nutriscore?.userText ?? "";
    quickAddMealState.computed.value = true;
  }
}
