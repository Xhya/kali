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

  _get() async {
    var str = await _storage.read(key: personalNutriScoreStoreKey);
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
