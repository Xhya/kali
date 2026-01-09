import 'package:kali/repository/configurations.repository.dart';
import 'package:kali/core/models/Configuration.enum.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/Hardware.service.dart';
import 'package:kali/core/states/configuration.state.dart';

Future<void> initConfigurations() async {
  try {
    final configurationsRepository = ConfigurationsRepository();
    final activateSubscription = await configurationsRepository.getConfig(
      ConfigKeyEnum.activateSubscription,
    );
    configurationState.subscriptionActivated.value =
        activateSubscription.toLowerCase() == "true";
    final maxCountStr = await configurationsRepository.getConfig(
      ConfigKeyEnum.computeMaxCharactersCount,
    );
    configurationState.maxCharacterCount.value = int.parse(maxCountStr);
    configurationState.minimalVersion.value = await configurationsRepository
        .getConfig(ConfigKeyEnum.forceUpdateVersion);
    configurationState.lastVersion.value = await configurationsRepository
        .getConfig(ConfigKeyEnum.lastVersion);
    configurationState.feedbackUrl.value = await configurationsRepository
        .getConfig(ConfigKeyEnum.feedbackFormUrl);
  } catch (e, stack) {
    errorService.notifyError(e: e, stack: stack, show: false);
  }
}

Future<void> refreshAppVersion() async {
  try {
    configurationState.currentVersion.value =
        await hardwareService.getCurrentVersion();
    configurationState.currentBuild.value =
        await hardwareService.getCurrentBuild();
    configurationState.needForceUpdate.value = isUpdateRequired();
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
