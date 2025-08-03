import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

enum PermissionTypeEnum { pushNotification }

class HardwareRepository {
  Future<String> getCurrentVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  Future<bool> getPermissionStatus(PermissionTypeEnum permissionType) async {
    if (permissionType == PermissionTypeEnum.pushNotification) {
      return await Permission.notification.status.isGranted;
    } else {
      return false;
    }
  }
}
