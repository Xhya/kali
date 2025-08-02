import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:kali/core/domains/configurations.repository.dart';
import 'package:kali/core/models/Configuration.enum.dart';
import 'package:kali/core/models/configuration.model.dart';

final textsState = TextsState();

class TextsState extends ChangeNotifier {
  final _configurationsRepository = ConfigurationsRepository();

  final texts = ValueNotifier<List<ConfigurationModel>>([]);
  final needPaymentText = ValueNotifier<String?>(null);
  final maxCharacterCount = ValueNotifier<int>(300);

  TextsState() {
    needPaymentText.addListener(notifyListeners);
    maxCharacterCount.addListener(notifyListeners);
  }

  @override
  void dispose() {
    needPaymentText.dispose();
    maxCharacterCount.dispose();
    super.dispose();
  }

  Future<void> init() async {
    texts.value = await _configurationsRepository.getInit();
    textsState.needPaymentText.value = _extractConfig(
      ConfigKeyEnum.usedTokensWithoutPaymentText,
    );
    final maxCountStr = _extractConfig(ConfigKeyEnum.computeMaxCharactersCount);

    if (maxCountStr != null) {
      maxCharacterCount.value = int.parse(maxCountStr);
    }
  }

  String? _extractConfig(ConfigKeyEnum key) {
    return texts.value.firstWhereOrNull((it) => it.key == key)?.value;
  }
}
