import 'package:flutter/material.dart';

final configurationState = ConfigurationState();

class ConfigurationState extends ChangeNotifier {
  final currentVersion = ValueNotifier<String>("");
  final minimalVersion = ValueNotifier<String>("");

  ConfigurationState() {
    minimalVersion.addListener(notifyListeners);
    currentVersion.addListener(notifyListeners);
  }

  @override
  void dispose() {
    minimalVersion.dispose();
    currentVersion.dispose();
    super.dispose();
  }
}
