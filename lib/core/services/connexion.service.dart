import 'dart:async';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final connexionService = ConnexionService();

class ConnexionService extends ChangeNotifier {
  StreamSubscription<InternetStatus>? subscription;

  final hasInternetConnexion = ValueNotifier<bool>(true);

  ConnexionService() {
    hasInternetConnexion.addListener(notifyListeners);
  }

  @override
  void dispose() {
    hasInternetConnexion.dispose();
    super.dispose();
  }

  getHasInternetConnexion() async {
    return await InternetConnection().hasInternetAccess;
  }

  listenToInternetConnexion() {
    subscription = InternetConnection().onStatusChange.listen((
      InternetStatus status,
    ) {
      switch (status) {
        case InternetStatus.connected:
          hasInternetConnexion.value = true;
          break;
        case InternetStatus.disconnected:
          hasInternetConnexion.value = false;
          break;
      }
    });
  }

  stopListeningInternetConnexion() {
    subscription?.cancel();
  }
}
