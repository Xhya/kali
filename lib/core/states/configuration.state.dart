import 'package:flutter/material.dart';

final configurationState = ConfigurationState();

class ConfigurationState extends ChangeNotifier {
  final currentVersion = ValueNotifier<String>("");
  final currentBuild = ValueNotifier<String>("");
  final minimalVersion = ValueNotifier<String>("");
  final lastVersion = ValueNotifier<String>("");
  final feedbackUrl = ValueNotifier<String>("");
  final subscriptionActivated = ValueNotifier<bool>(false);
  final maxCharacterCount = ValueNotifier<int>(300);
  final needForceUpdate = ValueNotifier<bool>(false);

  ConfigurationState() {
    minimalVersion.addListener(notifyListeners);
    currentVersion.addListener(notifyListeners);
    currentBuild.addListener(notifyListeners);
    lastVersion.addListener(notifyListeners);
    subscriptionActivated.addListener(notifyListeners);
    maxCharacterCount.addListener(notifyListeners);
    needForceUpdate.addListener(notifyListeners);
  }

  @override
  void dispose() {
    minimalVersion.dispose();
    currentVersion.dispose();
    currentBuild.dispose();
    lastVersion.dispose();
    subscriptionActivated.dispose();
    maxCharacterCount.dispose();
    needForceUpdate.dispose();
    super.dispose();
  }
}
