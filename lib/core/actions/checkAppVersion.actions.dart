import 'package:kali/core/domains/configurations.repository.dart';
import 'package:kali/core/models/Configuration.enum.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/Hardware.service.dart';
import 'package:kali/core/states/configuration.state.dart';

Future<void> refreshAppVersion() async {
  try {
    configurationState.currentVersion.value =
        await hardwareService.getCurrentVersion();
    configurationState.currentBuild.value =
        await hardwareService.getCurrentBuild();
    configurationState.minimalVersion.value = await ConfigurationsRepository()
        .getConfig(ConfigKeyEnum.forceUpdateVersion);
    configurationState.lastVersion.value = await ConfigurationsRepository()
        .getConfig(ConfigKeyEnum.lastVersion);

    final activateSubscription = await ConfigurationsRepository().getConfig(
      ConfigKeyEnum.activateSubscription,
    );

    configurationState.subscriptionActivated.value =
        activateSubscription.toLowerCase() == "true";
  } catch (e, stack) {
    errorService.notifyError(e: e, stack: stack, show: false);
  }
}

bool isUpdateRequired() {
  try {
    final minimalVersion = configurationState.minimalVersion.value;
    final currentVersion = configurationState.currentVersion.value;

    return isVersionLower(currentVersion, minimalVersion);
  } catch (e, stack) {
    errorService.notifyError(e: e, stack: stack);
    return true;
  }
}

bool isVersionLower(String current, String min) {
  if (min.isEmpty) {
    return false;
  }

  List<int> c = current.split('.').map(int.parse).toList();
  List<int> m = min.split('.').map(int.parse).toList();
  for (int i = 0; i < m.length; i++) {
    if (c.length <= i || c[i] < m[i]) return true;
    if (c[i] > m[i]) return false;
  }
  return false;
}
