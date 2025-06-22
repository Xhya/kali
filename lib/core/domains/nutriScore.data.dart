import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kalori/core/models/NutriScore.model.dart';
import 'package:kalori/core/models/nutriScore.fixture.dart';
import 'package:kalori/environment.dart';
import 'package:uuid/uuid.dart';

final nutriScoreData = NutriScoreData();
final nutriScoresStoreKey = 'hc_nutriScores';

class NutriScoreData {
  final _storage = const FlutterSecureStorage();
  final _uuid = Uuid();

  List<NutriScore> _nutriScores = [];

  reset() async {
    _nutriScores = [];
  }

  _store() async {
    if (!isInTestEnv) {
      await _storage.write(
        key: nutriScoresStoreKey,
        value: jsonEncode(_nutriScores),
      );
    }
  }

  Future<List<NutriScore>> getNutriScores() async {
    if (!isInTestEnv) {
      var str = await _storage.read(key: nutriScoresStoreKey);
      if (str == null) {
        return _nutriScores;
      }
      final json = jsonDecode(str);
      return (json as List).map((e) => NutriScore.fromJson(e)).toList();
    } else {
      return _nutriScores;
    }
  }

  Future<void> addNutriScore(NutriScore nutriScore) async {
    if (!isInTestEnv) {
      var str = await _storage.read(key: nutriScoresStoreKey);
      str ??= "[]";
      var json = jsonDecode(str);
      final nutriScores = json.map((e) => NutriScore.fromJson(e)).toList();
      nutriScores.add(nutriScore);
      await _store();
      return;
    } else {
      return;
    }
  }
}
