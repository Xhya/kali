import 'package:flutter/material.dart';
import 'package:kali/core/domains/configurations.repository.dart';

final textsState = TextsState();

class TextsState extends ChangeNotifier {
  final _configurationsRepository = ConfigurationsRepository();

  final needEmailText = ValueNotifier<String>("");

  TextsState() {
    needEmailText.addListener(notifyListeners);
  }

  @override
  void dispose() {
    needEmailText.dispose();
    super.dispose();
  }

  Future<void> init() async {
    final texts = await _configurationsRepository.getInit();
    textsState.needEmailText.value = texts[1].value ?? "";
  }
}
