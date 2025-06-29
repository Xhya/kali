import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final connexionService = ConnexionService();

class ConnexionService extends ChangeNotifier {
  static final ConnexionService _singleton = ConnexionService._internal();

  factory ConnexionService() {
    return _singleton;
  }

  ConnexionService._internal();

  // ignore: prefer_typing_uninitialized_variables
  var subscription;

  bool hasInternetConnexion = true;

  getHasInternetConnexion() async {
    return await InternetConnection().hasInternetAccess;
  }

  listenToInternetConnexion() {
    subscription = InternetConnection().onStatusChange.listen((
      InternetStatus status,
    ) {
      switch (status) {
        case InternetStatus.connected:
          hasInternetConnexion = true;
          notifyListeners();
          break;
        case InternetStatus.disconnected:
          hasInternetConnexion = false;
          notifyListeners();
          break;
      }
    });
  }

  stopListeningInternetConnexion() {
    subscription.cancel();
  }
}
