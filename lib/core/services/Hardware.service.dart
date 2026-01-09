import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:kali/repository/hardware.repository.dart';
import 'package:kali/repository/localStorage.repository.dart';
import 'package:kali/core/models/OperatingSystem.enum.dart';
import 'package:kali/core/utils/storageKeys.utils.dart';
import 'package:package_info_plus/package_info_plus.dart';

final hardwareService = HardwareService();

class HardwareService {
  final _hardwareRepository = HardwareRepository();

  Future<String> getFormattedSignature() async {
    final signature = await localStorageRepository.read(signatureKey);
    final deviceId = await localStorageRepository.read(deviceIdKey);

    return "$deviceId:$signature";
  }

  Future<void> deleteSignatureStorage() async {
    await localStorageRepository.delete(signatureKey);
    await localStorageRepository.delete(deviceIdKey);
  }

  Future<void> deleteTokenStorage() async {
    await localStorageRepository.delete(tokenKey);
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
