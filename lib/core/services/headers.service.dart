import 'dart:io';
import 'package:kali/repository/localStorage.repository.dart';
import 'package:kali/core/states/lang.state.dart';
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
  final signature = await localStorageRepository.read(signatureKey);
  final deviceId = await localStorageRepository.read(deviceIdKey);

  return {
    "Content-Type": "application/json",
    'Accept': 'application/json',
    'X-Device-ID': deviceId ?? "",
    'X-Device-Signature': signature ?? "",
    'Accept-Language': langState.currentLang.value.label,
  };
}

Future<Map<String, String>> headersWithToken() async {
  final customUserAgent = await getUserAgent();

  String? token = await getToken();

  if (token == null) {
    throw Exception("Missing token");
  }

  return {
    ...await getBaseHeaders(),
    'Authorization': 'Bearer $token',
    'User-Agent': customUserAgent,
  };
}

Future<Map<String, String>> headersWithMaybeToken() async {
  final customUserAgent = await getUserAgent();

  String? token = await getToken();

  return {
    ...await getBaseHeaders(),
    if (token != null) 'Authorization': 'Bearer $token',
    'User-Agent': customUserAgent,
  };
}

Future<Map<String, String>> headersWithoutToken() async {
  final customUserAgent = await getUserAgent();

  return {...await getBaseHeaders(), 'User-Agent': customUserAgent};
}

Future<bool> asToken() async {
  String? token = await getToken();
  return token != null;
}

Future<String?> getToken() async {
  return await localStorageRepository.read(tokenKey);
}

Future<void> storeToken(String token) async {
  await localStorageRepository.write(tokenKey, token);
}
