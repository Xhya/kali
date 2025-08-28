import 'package:flutter/material.dart';

final configurationState = ConfigurationState();

class ConfigurationState extends ChangeNotifier {
  final currentVersion = ValueNotifier<String>("");
  final currentBuild = ValueNotifier<String>("");
  final minimalVersion = ValueNotifier<String>("");
  final lastVersion = ValueNotifier<String>("");
  final subscriptionActivated = ValueNotifier<bool>(false);

  ConfigurationState() {
    minimalVersion.addListener(notifyListeners);
    currentVersion.addListener(notifyListeners);
    currentBuild.addListener(notifyListeners);
    lastVersion.addListener(notifyListeners);
    subscriptionActivated.addListener(notifyListeners);
  }

  @override
  void dispose() {
    minimalVersion.dispose();
    currentVersion.dispose();
    currentBuild.dispose();
    lastVersion.dispose();
    subscriptionActivated.dispose();
    super.dispose();
  }
}
