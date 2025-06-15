import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kalory/client/widgets/AsyncInitWidget.dart';
import 'package:kalory/client/Routing.dart';
import 'package:kalory/core/domains/user.state.dart';
import 'package:kalory/core/services/Navigation.service.dart';
import 'package:kalory/core/services/Translation.service.dart';
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
      title: 'Kalory',
      theme: ThemeData(fontFamily: 'Barlow'),
      home: AsyncInitWidget(
        initFunction: () async {
          await TranslationService().init();
          // await userService.refreshUser();
        },
        child: const Scaffold(body: Routing()),
      ),
    );
  }
}
