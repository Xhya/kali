import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kali/core/domains/hardware.repository.dart';
import 'package:kali/core/models/OperatingSystem.enum.dart';
import 'package:kali/core/utils/storageKeys.utils.dart';
import 'package:package_info_plus/package_info_plus.dart';

final hardwareService = HardwareService();

class HardwareService {
  final _hardwareRepository = HardwareRepository();
  FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<String> getFormattedSignature() async {
    final signature = await _secureStorage.read(key: signatureKey);
    final deviceId = await _secureStorage.read(key: deviceIdKey);

    return "$deviceId:$signature";
  }

  Future<String> getCurrentVersion() async {
    return await _hardwareRepository.getCurrentVersion();
  }

  Future<String> getCurrentBuild() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.buildNumber;
  }

  Future<OperatingSystemEnum> getOperatingSystem() async {
    if (kIsWeb) {
      return OperatingSystemEnum.web;
    } else if (Platform.isAndroid) {
      return OperatingSystemEnum.android;
    } else if (Platform.isIOS) {
      return OperatingSystemEnum.ios;
    } else {
      return OperatingSystemEnum.unknown;
    }
  }

  Future<bool> getNotificationActivated() async {
    return await _hardwareRepository.getPermissionStatus(
      PermissionTypeEnum.pushNotification,
    );
  }
}
