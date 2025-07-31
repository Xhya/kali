import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kali/core/services/Hardware.service.dart';
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
  final _hardwareService = HardwareService();
  final secureStorage = FlutterSecureStorage();

  bool isAuthentifiedWithSignature = false;

  init() async {
    try {
      await _initDeviceId();
      await _generateSignedDeviceId();
      await authenticationRepository.initUser(
        formattedSignature: await _hardwareService.getFormattedSignature(),
        currentVersion: await _hardwareService.getCurrentVersion(),
        currentBuild: await _hardwareService.getCurrentBuild(),
        operatingSystem: await _hardwareService.getOperatingSystem(),
        notificationActivated:
            await _hardwareService.getNotificationActivated(),
      );
      isAuthentifiedWithSignature = true;
    } catch (e, stack) {
      await errorService.notifyError(e: e, stack: stack, show: false);
    }
  }

  verifyAuthCode(String code) async {
    try {
      await authenticationRepository.verifyAuthCode(
        code: code,
      );
    } catch (e, stack) {
      await errorService.notifyError(e: e, stack: stack, show: false);
    }
  }

  Future<String> _generateSignedDeviceId() async {
    var signature = await secureStorage.read(key: signatureKey);

    if (signature != null) {
      return signature;
    }

    final deviceId = await secureStorage.read(key: deviceIdKey);

    if (deviceId == null) {
      throw Exception("Device ID not found");
    }

    final hmac = Hmac(sha256, utf8.encode(signatureSecretKey));
    signature = hmac.convert(utf8.encode(deviceId)).toString();

    await secureStorage.write(key: signatureKey, value: signature);

    return signature;
  }

  Future<String> _initDeviceId() async {
    var deviceId = await secureStorage.read(key: deviceIdKey);

    if (deviceId == null) {
      deviceId = Uuid().v4();
      await secureStorage.write(key: deviceIdKey, value: deviceId);
    }

    return deviceId;
  }
}
