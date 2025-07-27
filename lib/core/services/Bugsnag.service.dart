import 'package:bugsnag_flutter/bugsnag_flutter.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/environment.dart';

var bugsnagService = BugsnagService();

class BugsnagService {
  String? error;

  init() async {
    try {
      if (isInDevEnv || isInProdEnv) {
        await bugsnag.start(
          apiKey: bugsnagApiKey,
          releaseStage: bugsnagEnvironment,
        );
      }
    } catch (e, stack) {
      await errorService.notifyError(e: e, stack: stack);
    }
  }

  Future<void> notify({required Object e, StackTrace? stack}) async {
    await bugsnag.notify(e, stack);
  }
}
