import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:kali/core/domains/pushNotification.repository.dart';
import 'package:kali/environment.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final _pushNotificationRespository = PushNotificationRepository();

  Future<String?> _getToken() async {
    String? token = await _fcm.getToken();
    return token;
  }

  Future<void> refreshNotificationToken() async {
    if (!isInTestEnv && !kIsWeb && environment["USE_SIMULATOR"] != true) {
      String? token = await _getToken();

      if (token != null) {
        await _pushNotificationRespository.setNotificationToken(token);
      }
    }
  }
}
