import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kali/core/actions/checkAppVersion.actions.dart';
import 'package:kali/core/services/Authentication.service.dart';
import 'package:kali/core/services/PushNotification.service.dart';
import 'package:kali/core/services/User.service.dart';
import 'package:kali/core/states/Ai.state.dart';
import 'package:kali/core/states/Input.state.dart';
import 'package:kali/core/states/configuration.state.dart';
import 'package:kali/core/states/editProfile.state.dart';
import 'package:kali/core/states/topBanner.state.dart';
import 'package:kali/core/services/Bugsnag.service.dart';
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

  // Bugsnag Monitoring
  await bugsnagService.init();

  // User identification
  await authenticationService.init();

  // Firebase init
  if (false) {
    await PushNotificationService().refreshNotificationToken();
  }

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

        ChangeNotifierProvider(create: (context) => nutriScoreState),
        ChangeNotifierProvider(create: (context) => mealState),
        ChangeNotifierProvider(create: (context) => configurationState),
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
      home: AsyncInitWidget(
        initFunction: () async {
          try {
            await refreshAppVersion();
            await connexionService.listenToInternetConnexion();
            await TranslationService().init();
            await UserService().refreshUser();
          } catch (e) {
            errorService.notifyError(e: e, show: false);
          }
        },
        child: const Scaffold(body: Routing()),
      ),
    );
  }
}
