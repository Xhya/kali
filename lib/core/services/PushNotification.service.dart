import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:kali/client/widgets/QuickAddMeal.widget.dart';
import 'package:kali/client/widgets/QuickAddMealButton.widget.dart';
import 'package:kali/core/domains/pushNotification.repository.dart';
import 'package:kali/core/services/Navigation.service.dart';
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
        final text = uri.queryParameters['text'] ?? "";
        quickAddMeal(text);
      }
    });
  }

  Future<void> quickAddMeal(String text) async {
    navigationService.navigateTo(ScreenEnum.home);
    await onClickAddQuickMeal();
    quickAddMealState.userMealText.value = text;
    await onComputeQuickAddMeal();
  }
}
