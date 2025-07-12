import 'package:kali/client/Style.service.dart';
import 'package:kali/client/screens/Home.screen.dart';
import 'package:kali/client/screens/Meal.screen.dart';
import 'package:kali/client/screens/Meals.screen.dart';
import 'package:kali/client/screens/PersonalNutriScore.screen.dart';
import 'package:kali/client/screens/StartForm.screen.dart';
import 'package:kali/core/domains/nutriScore.state.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/services/connexion.service.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

class Routing extends StatefulWidget {
  const Routing({super.key});

  @override
  State<Routing> createState() => _RoutingState();
}

class _RoutingState extends State<Routing> {
  bool backButtonInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.pop(context);
    return true;
  }

  @override
  void initState() {
    super.initState();
    connexionService.listenToInternetConnexion();
    BackButtonInterceptor.add(backButtonInterceptor);
  }

  @override
  void dispose() {
    connexionService.stopListeningInternetConnexion();
    BackButtonInterceptor.remove(backButtonInterceptor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget? bottomSheet = context.watch<NavigationService>().bottomSheet;
    Widget? snackBar = context.watch<NavigationService>().snackBar;
    String? error = context.watch<ErrorService>().error;

    if (bottomSheet != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showModalBottomSheet(
          useSafeArea: true,
          isScrollControlled: true,
          context: navigationService.context!,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          builder: (BuildContext context) {
            if (navigationService.bottomSheet != null) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: navigationService.bottomSheet!,
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ).then((_) {
          navigationService.bottomSheet = null;
        });
      });
    }

    if (error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          useSafeArea: false,
          barrierDismissible: true,
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Text(error),
              ),
            );
          },
        );
      });
    }

    if (snackBar != null) {
      var snackBarWidget = SnackBar(
        backgroundColor: style.background.neutral.color,
        content: snackBar,
        duration: Duration(seconds: 2),
      );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(
          navigationService.context!,
        ).showSnackBar(snackBarWidget).closed.then((reason) {
          navigationService.snackBar = null;
        });
      });
    }

    navigationService.popNavigation ??= () {
      if (navigationService.context != null) {
        Navigator.pop(context);
      } else {
        errorService.notifyError(e: "Missing BuildContext");
      }
    };

    navigationService.pushNavigation ??= () {
      navigateTo(Widget screen) {
        // if (screen is HomeScreen) {
        //   // Pop navigation stack to prevent overstacked screens
        //   Navigator.of(context).popUntil((route) {
        //     return route.settings.name == screen.toString() ||
        //         route.settings.name == "/";
        //   });
        // }

        Navigator.push(
          context,
          PageRouteBuilder(
            settings: RouteSettings(
              name: navigationService.currentScreen.toString(),
            ),
            pageBuilder: (
              BuildContext context,
              Animation<double> animation1,
              Animation<double> animation2,
            ) {
              return screen;
            },
          ),
        );
      }

      switch (navigationService.currentScreen) {
        case ScreenEnum.home:
          navigateTo(const HomeScreen());
        case ScreenEnum.startForm:
          navigateTo(const StartFormScreen());
        case ScreenEnum.meal:
          navigateTo(const MealScreen());
        case ScreenEnum.meals:
          navigateTo(const MealsScreen());
        case ScreenEnum.personalNutriScore:
          navigateTo(const PersonalNutriScoreScreen());
      }
    };

    if (nutriScoreState.personalNutriScore.value == null) {
      return const StartFormScreen();
    } else {
      return const HomeScreen();
    }
  }
}
