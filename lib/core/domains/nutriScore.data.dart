import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kalori/core/models/NutriScore.model.dart';
import 'package:kalori/environment.dart';

final nutriScoreData = NutriScoreData();
final personalNutriScoreStoreKey = 'hc_personal_nutri_score';

class NutriScoreData {
  final _storage = const FlutterSecureStorage();

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

  _store() async {
    if (!isInTestEnv) {
      await _storage.write(
        key: personalNutriScoreStoreKey,
        value: jsonEncode(_nutriScore),
      );
    }
  }

  Future<NutriScore?> getPersonalNutriScore() async {
    if (!isInTestEnv) {
      var str = await _storage.read(key: personalNutriScoreStoreKey);
      if (str == null) {
        return null;
      }
      final json = jsonDecode(str);
      return NutriScore.fromJson(json);
    } else {
      return null;
    }
  }

  Future<void> setPersonalNutriScore(NutriScore nutriScore) async {
    if (!isInTestEnv) {
      _nutriScore = nutriScore;
      _store();
    }
  }
}
