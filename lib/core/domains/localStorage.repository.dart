import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kali/environment.dart';

final localStorageRepository = LocalStorageRepository();

class LocalStorageRepository {
  final _secureStorage = FlutterSecureStorage();

  final dynamic _store = {};

  Future<String?> read(String key) async {
    if (isInTestEnv) {
      return _store[key];
    } else {
      return await _secureStorage.read(key: key);
    }
  }

  Future<void> write(String key, String value) async {
    if (isInTestEnv) {
      _store[key] = value;
    } else {
      await _secureStorage.write(key: key, value: value);
    }
  }

    Future<void> delete(String key) async {
    if (isInTestEnv) {
      _store[key] = null;
    } else {
      await _secureStorage.delete(key: key);
    }
  }
}
