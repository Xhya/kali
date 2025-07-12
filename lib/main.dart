import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kali/core/states/topBanner.state.dart';
import 'package:kali/core/services/Bugsnag.service.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/screens/PersonalNutriScore.screen.dart';
import 'package:kali/client/states/quickAddMeal.state.dart';
import 'package:kali/client/states/startForm.state.dart';
import 'package:kali/client/widgets/AsyncInitWidget.dart';
import 'package:kali/client/Routing.dart';
import 'package:kali/client/states/editMeal.state.dart';
import 'package:kali/core/domains/meal.state.dart';
import 'package:kali/core/domains/nutriScore.service.dart';
import 'package:kali/core/domains/nutriScore.state.dart';
import 'package:kali/core/domains/user.state.dart';
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


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => userState),
        ChangeNotifierProvider(create: (context) => navigationService),
        ChangeNotifierProvider(create: (context) => errorService),
        ChangeNotifierProvider(create: (context) => connexionService),
        ChangeNotifierProvider(create: (context) => localeService),

        ChangeNotifierProvider(create: (context) => quickAddMealState),
        ChangeNotifierProvider(create: (context) => startFormState),
        ChangeNotifierProvider(create: (context) => editMealState),
        ChangeNotifierProvider(create: (context) => topBannerState),
        ChangeNotifierProvider(
          create: (context) => personalNutriScoreEditionState,
        ),

        ChangeNotifierProvider(create: (context) => nutriScoreState),
        ChangeNotifierProvider(create: (context) => mealState),
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'kali',
      theme: ThemeData(
        fontFamily: 'Barlow',
        colorScheme: ColorScheme.fromSeed(
          seedColor: style.background.color1.color!,
        ),
      ),
      home: AsyncInitWidget(
        initFunction: () async {
          connexionService.listenToInternetConnexion();
          await refreshPersonalNutriScore();
          await TranslationService().init();
        },
        child: const Scaffold(body: Routing()),
      ),
    );
  }
}
