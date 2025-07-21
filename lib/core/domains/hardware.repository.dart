import 'package:package_info_plus/package_info_plus.dart';


class HardwareRepository {
  Future<String> getCurrentVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}
