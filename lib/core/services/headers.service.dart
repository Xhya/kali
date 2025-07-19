import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kali/core/utils/storageKeys.utils.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<String> getUserAgent() async {
  final packageInfo = await PackageInfo.fromPlatform();
  final version = packageInfo.version;
  final build = packageInfo.buildNumber;

  final baseUserAgent = HttpClient().userAgent ?? '';
  return '$baseUserAgent AppVersion:/$version+$build';
}

Future<Map<String, String>> getBaseHeaders() async {
  final secureStorage = FlutterSecureStorage();

  final signature = await secureStorage.read(key: signatureKey);
  final deviceId = await secureStorage.read(key: deviceIdKey);

  return {
    "Content-Type": "application/json",
    'Accept': 'application/json',
    'X-Device-ID': deviceId ?? "",
    'X-Device-Signature': signature ?? "",
  };
}

headersWithToken() async {
  final customUserAgent = await getUserAgent();

  String? token = await getToken();

  if (token == null) {
    throw Exception();
  }

  return {
    ...await getBaseHeaders(),
    'Authorization': 'Bearer $token',
    'User-Agent': customUserAgent,
  };
}

headersWithMaybeToken() async {
  final customUserAgent = await getUserAgent();

  String? token = await getToken();

  return {
    ...await getBaseHeaders(),
    if (token != null) 'Authorization': 'Bearer $token',
    'User-Agent': customUserAgent,
  };
}

headersWithoutToken() async {
  final customUserAgent = await getUserAgent();

  return {...await getBaseHeaders(), 'User-Agent': customUserAgent};
}

Future<bool> asToken() async {
  String? token = await getToken();
  return token != null;
}

Future<String?> getToken() async {
  const storage = FlutterSecureStorage();
  return await storage.read(key: tokenKey);
}

Future<void> storeToken(String token) async {
  const storage = FlutterSecureStorage();
  await storage.write(key: tokenKey, value: token);
}
