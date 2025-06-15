import 'package:kalory/client/Style.service.dart';
import 'package:kalory/client/screens/Home.screen.dart';
import 'package:kalory/core/services/Error.service.dart';
import 'package:kalory/core/services/Navigation.service.dart';
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
    BackButtonInterceptor.add(backButtonInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(backButtonInterceptor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget? bottomSheet = context.watch<NavigationService>().bottomSheet;
    Widget? snackBar = context.watch<NavigationService>().snackBar;

    if (bottomSheet != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showModalBottomSheet(
          context: navigationService.context!,
          builder: (BuildContext context) {
            if (navigationService.bottomSheet != null) {
              return navigationService.bottomSheet!;
            } else {
              errorService.notifyError("Missing bottom sheet");
              throw Exception("Missing bottom sheet");
            }
          },
        ).then((_) {
          navigationService.bottomSheet = null;
        });
      });
    }

    if (snackBar != null) {
      var snackBarWidget = SnackBar(
        backgroundColor: style.background.neutral.color,
        content: snackBar,
        duration: Duration(seconds: 2),
      );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(navigationService.context!)
            .showSnackBar(snackBarWidget)
            .closed
            .then((reason) {
          navigationService.snackBar = null;
        });
      });
    }

    navigationService.popNavigation ??= () {
      if (navigationService.context != null) {
        Navigator.pop(context);
      } else {
        errorService.notifyError("Missing BuildContext");
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
      }
    };

    return const HomeScreen();
  }
}
