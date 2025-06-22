import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kalori/client/states/quickAddMeal.state.dart';
import 'package:kalori/client/states/startForm.state.dart';
import 'package:kalori/client/widgets/AsyncInitWidget.dart';
import 'package:kalori/client/Routing.dart';
import 'package:kalori/core/domains/meal.state.dart';
import 'package:kalori/core/domains/nutriScore.state.dart';
import 'package:kalori/core/domains/user.state.dart';
import 'package:kalori/core/services/Error.service.dart';
import 'package:kalori/core/services/Navigation.service.dart';
import 'package:kalori/core/services/Translation.service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize intl
  await initializeDateFormatting();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => userState),
        ChangeNotifierProvider(create: (context) => navigationService),
        ChangeNotifierProvider(create: (context) => errorService),

        ChangeNotifierProvider(create: (context) => quickAddMealState),
        ChangeNotifierProvider(create: (context) => startFormState),

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
      title: 'kalori',
      theme: ThemeData(
        fontFamily: 'Barlow',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
      ),
      home: AsyncInitWidget(
        initFunction: () async {
          await TranslationService().init();
        },
        child: const Scaffold(body: Routing()),
      ),
    );
  }
}
