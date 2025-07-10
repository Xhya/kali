import 'package:bugsnag_flutter/bugsnag_flutter.dart';
import 'package:kalori/environment.dart';

var bugsnagService = BugsnagService();

class BugsnagService {
  String? error;

  init() async {
    await bugsnag.start(
      apiKey: bugsnagApiKey,
      releaseStage: bugsnagEnvironment
    );
  }

  Future<void> notify({required Object e, StackTrace? stack}) async {
    await bugsnag.notify(e, stack);
  }
}
