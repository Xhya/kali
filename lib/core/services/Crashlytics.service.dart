import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:kalori/environment.dart';

class CrashlyticsService {
  Future<void> init() async {
    if (useSimulator != true && !kIsWeb) {
      await Firebase.initializeApp();
    }

    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  notifyError({required e, required stack, required reason}) {
    FirebaseCrashlytics.instance.recordError(e, stack, reason: reason);
  }
}
