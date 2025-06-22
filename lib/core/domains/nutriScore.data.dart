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

  List<NutriScore> _nutriScores = fixtureNutriScores;

  reset() async {
    _nutriScores = fixtureNutriScores;
  }

  _store() async {
    if (!isInTestEnv) {
      // await _storage.write(key: challengeStoreKey, value: jsonEncode(_challenge));
    }
  }

  Future<List<NutriScore>> getNutriScores() async {
    if (!isInTestEnv) {
      var str = await _storage.read(key: nutriScoresStoreKey);
      if (str == null) {
        return _nutriScores;
      }
      var json = jsonDecode(str);
      return json.map((e) => NutriScore.fromJson(e)).toList();
    } else {
      return _nutriScores;
    }
  }
}
