import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kali/core/services/Hardware.service.dart';
import 'package:kali/core/services/User.service.dart';
import 'package:kali/core/services/connexion.service.dart';
import 'package:kali/core/utils/storageKeys.utils.dart';
import 'package:kali/environment.dart';
import 'package:uuid/uuid.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:kali/core/domains/authentication.repository.dart';
import 'package:kali/core/services/Error.service.dart';

final authenticationService = AuthenticationService();

class AuthenticationService {
  final _authenticationRepository = AuthenticationRepository();
  final _hardwareService = HardwareService();
  final _secureStorage = FlutterSecureStorage();
  final _userService = UserService();

  bool isAuthentifiedWithSignature = false;
  bool isAuthentifiedWithToken = false;
  get isAuthentified => isAuthentifiedWithSignature || isAuthentifiedWithToken;

  init() async {
    final hasInternetConnexion = await connexionService.getHasInternetConnexion();

    if (!hasInternetConnexion) {
      return;
    }

    final token = await _secureStorage.read(key: tokenKey);
    if (token != null) {
      try {
        await _initUser();
        await _userService.refreshUser();
        isAuthentifiedWithToken = true;
      } catch (e) {
        isAuthentifiedWithToken = false;
        await hardwareService.deleteTokenStorage();
      }
    } else {
      await initSignature();
    }
  }

  initSignature() async {
    try {
      await _initDeviceId();
      await _generateSignedDeviceId();
      await _initUser();
      isAuthentifiedWithSignature = true;
    } catch (e, stack) {
      await hardwareService.deleteSignatureStorage();
      await initSignature();
      await errorService.notifyError(e: e, stack: stack, show: false);
    }
  }

  loginWithGoogle({required String email, required String authCode}) async {
    await _authenticationRepository.loginWithGoogle(
      email: email,
      authCode: authCode,
    );
  }

  registerWithGoogle({required String email, required String authCode}) async {
    await _authenticationRepository.registerWithGoogle(
      email: email,
      authCode: authCode,
    );
  }

  _initUser() async {
    await _authenticationRepository.initUser(
      formattedSignature:
          await _hardwareService
              .getFormattedSignature(), // TODO: should be in another function
      currentVersion: await _hardwareService.getCurrentVersion(),
      currentBuild: await _hardwareService.getCurrentBuild(),
      operatingSystem: await _hardwareService.getOperatingSystem(),
      notificationActivated: await _hardwareService.getNotificationActivated(),
    );
  }

  verifyAuthCode(String code) async {
    await _authenticationRepository.verifyAuthCode(code: code);
  }

  resendCode() async {
    await _authenticationRepository.resendCode();
  }

  Future<String> _generateSignedDeviceId() async {
    var signature = await _secureStorage.read(key: signatureKey);

    if (signature != null) {
      return signature;
    }

    final deviceId = await _secureStorage.read(key: deviceIdKey);

    if (deviceId == null) {
      throw Exception("Device ID not found");
    }

    final hmac = Hmac(sha256, utf8.encode(signatureSecretKey));
    signature = hmac.convert(utf8.encode(deviceId)).toString();

    await _secureStorage.write(key: signatureKey, value: signature);

    return signature;
  }

  Future<String> _initDeviceId() async {
    var deviceId = await _secureStorage.read(key: deviceIdKey);

    if (deviceId == null) {
      deviceId = Uuid().v4();
      await _secureStorage.write(key: deviceIdKey, value: deviceId);
    }

    return deviceId;
  }
}
