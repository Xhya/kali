import 'package:kali/core/domains/configurations.repository.dart';
import 'package:kali/core/domains/hardware.service.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/states/configuration.state.dart';

Future<void> refreshAppVersion() async {
  try {
    configurationState.currentVersion.value = await HardwareService().getCurrentVersion();
    configurationState.minimalVersion.value = await ConfigurationsRepository()
        .getConfig(ConfigKeyEnum.forceUpdateVersion);
  } catch (e, stack) {
    errorService.notifyError(e: e, stack: stack);
  }
}

bool isUpdateRequired() {
  try {
    final minimalVersion = configurationState.minimalVersion.value;
    final currentVersion = configurationState.currentVersion.value;

    return _isVersionLower(currentVersion, minimalVersion);
  } catch (e, stack) {
    print(e);
    errorService.notifyError(e: e, stack: stack);
    return true;
  }
}

bool _isVersionLower(String current, String min) {
  List<int> c = current.split('.').map(int.parse).toList();
  List<int> m = min.split('.').map(int.parse).toList();
  for (int i = 0; i < m.length; i++) {
    if (c.length <= i || c[i] < m[i]) return true;
    if (c[i] > m[i]) return false;
  }
  return false;
}
