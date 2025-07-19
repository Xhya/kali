import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final tokenKey = "hc_token";
final deviceIdKey = "hc_device_id";
final signatureKey = "hc_signature";
final mealStoreKey = 'hc_meals';
final personalNutriScoreStoreKey = 'hc_personal_nutri_score';

Future<String> getFormattedSignature() async {
  final secureStorage = FlutterSecureStorage();

  final signature = await secureStorage.read(key: signatureKey);
  final deviceId = await secureStorage.read(key: deviceIdKey);

  return "$deviceId:$signature";
}
