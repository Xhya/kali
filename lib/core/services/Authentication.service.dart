import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kali/core/utils/storageKeys.utils.dart';
import 'package:kali/environment.dart';
import 'package:uuid/uuid.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:kali/core/domains/authentication.repository.dart';
import 'package:kali/core/services/Error.service.dart';

final authenticationService = AuthenticationService();

class AuthenticationService {
  final authenticationRepository = AuthenticationRepository();
  final secureStorage = FlutterSecureStorage();

  bool isAuthentifiedWithSignature = false;

  init() async {
    try {
      await initDeviceId();
      await generateSignedDeviceId();
      await authenticationRepository.initUser();
      isAuthentifiedWithSignature = true;
    } catch (e, stack) {
      await errorService.notifyError(e: e, stack: stack, show: false);
    }
  }

  Future<String> generateSignedDeviceId() async {
    final deviceId = await secureStorage.read(key: deviceIdKey);

    if (deviceId == null) {
      throw Exception("Device ID not found");
    }

    final hmac = Hmac(sha256, utf8.encode(signatureSecretKey));
    final signature = hmac.convert(utf8.encode(deviceId)).toString();

    await secureStorage.write(key: signatureKey, value: signature);

    return signature;
  }

  Future<String> initDeviceId() async {
    final deviceId = Uuid().v4();
    await secureStorage.write(key: deviceIdKey, value: deviceId);
    return deviceId;
  }
}
