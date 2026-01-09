import 'dart:convert';
import 'package:kali/repository/localStorage.repository.dart';
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:kali/core/utils/storageKeys.utils.dart';
import 'package:kali/environment.dart';

final nutriScoreData = NutriScoreData();

class NutriScoreData {
  NutriScore? _nutriScore;

  NutriScoreData() {
    reset();
  }

  reset() async {
    if (!isInTestEnv) {
      _nutriScore = await getPersonalNutriScore();
    } else {
      _nutriScore = null;
    }
  }

  Future<void> _store() async {
    if (!isInTestEnv) {
      await localStorageRepository.write(
        personalNutriScoreStoreKey,
        jsonEncode(_nutriScore),
      );
    }
  }

  Future _get() async {
    //await _storage.delete(key: personalNutriScoreStoreKey);

    var str = await localStorageRepository.read(personalNutriScoreStoreKey);
    if (str == null) {
      return null;
    }
    return jsonDecode(str);
  }

  Future<NutriScore?> getPersonalNutriScore() async {
    if (!isInTestEnv) {
      final json = await _get();
      return json != null ? NutriScore.fromJson(json) : null;
    } else {
      return null;
    }
  }

  Future<void> setPersonalNutriScore(NutriScore nutriScore) async {
    if (!isInTestEnv) {
      _nutriScore = nutriScore;
      await _store();
    }
  }
}
