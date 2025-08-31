import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kali/core/actions/checkAppVersion.actions.dart';
import 'package:kali/core/actions/googleSignIn.actions.dart';
import 'package:kali/core/services/Authentication.service.dart';
import 'package:kali/core/services/PushNotification.service.dart';
import 'package:kali/core/services/User.service.dart';
import 'package:kali/core/states/Ai.state.dart';
import 'package:kali/core/states/Input.state.dart';
import 'package:kali/core/states/Texts.state.dart';
import 'package:kali/core/states/configuration.state.dart';
import 'package:kali/core/states/editProfile.state.dart';
import 'package:kali/core/states/googleSignIn.state.dart';
import 'package:kali/core/states/register.state.dart';
import 'package:kali/core/states/subscription.state.dart';
import 'package:kali/core/states/topBanner.state.dart';
import 'package:kali/core/services/Bugsnag.service.dart';
import 'package:kali/environment.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/core/states/quickAddMeal.state.dart';
import 'package:kali/core/states/startForm.state.dart';
import 'package:kali/client/widgets/AsyncInitWidget.dart';
import 'package:kali/client/Routing.dart';
import 'package:kali/core/states/editMeal.state.dart';
import 'package:kali/core/states/meal.state.dart';
import 'package:kali/core/states/nutriScore.state.dart';
import 'package:kali/core/states/user.state.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/Locale.service.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/services/Translation.service.dart';
import 'package:kali/core/services/connexion.service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize intl
  await initializeDateFormatting();

  // Translation
  await TranslationService().init();

  // Bugsnag Monitoring
  await bugsnagService.init();

  // User identification
  await authenticationService.init();

  Stripe.publishableKey = STRIPE_PUBLIC_KEY;
  await Stripe.instance.applySettings();

  // Firebase init
  if (!useSimulator && !kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();

    if (Firebase.apps.isEmpty) {
      try {
        var apiKey =
            Platform.isAndroid
                ? environment["FIREBASE_MESSAGING_API_KEY"] as String
                : environment["FIREBASE_MESSAGING_IOS_API_KEY"] as String;

        var appId =
            Platform.isAndroid
                ? environment["FIREBASE_MESSAGING_APP_ID"] as String
                : environment["FIREBASE_MESSAGING_GOOGLE_APP_ID"] as String;

        await Firebase.initializeApp(
          options: FirebaseOptions(
            apiKey: apiKey,
            appId: appId,
            messagingSenderId:
                environment["FIREBASE_MESSAGING_SENDER_ID"] as String,
            projectId: environment["FIREBASE_MESSAGING_PROJECT_ID"] as String,
          ),
        );
      } catch (e, stackTrace) {
        errorService.notifyError(e: e, stack: stackTrace);
      }
    }
  }

  await initGoogleSignIn();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => userState),
        ChangeNotifierProvider(create: (context) => navigationService),
        ChangeNotifierProvider(create: (context) => errorService),
        ChangeNotifierProvider(create: (context) => connexionService),
        ChangeNotifierProvider(create: (context) => localeService),
        ChangeNotifierProvider(create: (context) => aiState),

        ChangeNotifierProvider(create: (context) => quickAddMealState),
        ChangeNotifierProvider(create: (context) => startFormState),
        ChangeNotifierProvider(create: (context) => editMealState),
        ChangeNotifierProvider(create: (context) => editProfileState),
        ChangeNotifierProvider(create: (context) => topBannerState),
        ChangeNotifierProvider(create: (context) => inputState),
        ChangeNotifierProvider(create: (context) => registerState),
        ChangeNotifierProvider(create: (context) => textsState),
        ChangeNotifierProvider(create: (context) => googleSignInState),

        ChangeNotifierProvider(create: (context) => nutriScoreState),
        ChangeNotifierProvider(create: (context) => mealState),
        ChangeNotifierProvider(create: (context) => configurationState),
        ChangeNotifierProvider(create: (context) => subscriptionState),
      ],
      child: const App(),
    ),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    connexionService.listenToInternetConnexion();
  }

  @override
  void dispose() {
    connexionService.stopListeningInternetConnexion();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'kali',
      theme: ThemeData(
        fontFamily: 'BeVietnamPro',
        colorScheme: ColorScheme.fromSeed(
          seedColor: style.background.green.color!,
        ),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('fr', 'FR')],
      home: AsyncInitWidget(
        initFunction: () async {
          try {
            await refreshAppVersion();
            await initConfigurations();
            await connexionService.listenToInternetConnexion();
            await UserService().refreshUser();
            await PushNotificationService().refreshNotificationToken();
          } catch (e) {
            errorService.notifyError(e: e, show: false);
          }
        },
        child: const Scaffold(body: Routing()),
      ),
    );
  }
}
