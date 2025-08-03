import 'package:flutter/material.dart';

final configurationState = ConfigurationState();

class ConfigurationState extends ChangeNotifier {
  final currentVersion = ValueNotifier<String>("");
  final currentBuild = ValueNotifier<String>("");
  final minimalVersion = ValueNotifier<String>("");
  final lastVersion = ValueNotifier<String>("");

  ConfigurationState() {
    minimalVersion.addListener(notifyListeners);
    currentVersion.addListener(notifyListeners);
    currentBuild.addListener(notifyListeners);
    lastVersion.addListener(notifyListeners);
  }

  @override
  void dispose() {
    minimalVersion.dispose();
    currentVersion.dispose();
    currentBuild.dispose();
    lastVersion.dispose();
    super.dispose();
  }
}
