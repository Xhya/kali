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

var baseHeaders = {
  "Content-Type": "application/json",
  'Accept': 'application/json',
};

headersWithToken() async {
  final customUserAgent = await getUserAgent();

  String? token = await getToken();

  if (token == null) {
    throw Exception();
  }

  return {
    ...baseHeaders,
    'Authorization': 'Bearer $token',
    'User-Agent': customUserAgent,
  };
}

headersWithMaybeToken() async {
  final customUserAgent = await getUserAgent();

  String? token = await getToken();

  return {
    ...baseHeaders,
    if (token != null) 'Authorization': 'Bearer $token',
    'User-Agent': customUserAgent,
  };
}

headersWithoutToken() async {
  final customUserAgent = await getUserAgent();

  return {...baseHeaders, 'User-Agent': customUserAgent};
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
