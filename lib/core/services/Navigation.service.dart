import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kalori/core/services/Error.service.dart';

enum ScreenEnum {
  startForm,
  home,
  meal,
  meals,
}

var navigationService = NavigationService();

class NavigationService extends ChangeNotifier {
  bool initialScreenSet = false;

  ScreenEnum currentScreen = ScreenEnum.home;
  bool userScaffoldObserved = false;
  BuildContext? context;
  Widget? bottomSheet;
  Widget? snackBar;

  String screenTitle = "";

  List<Widget> actions = [];

  int get currentIndex {
    switch (currentScreen) {
      case ScreenEnum.home:
        return 0;
      default:
        return 0;
    }
  }

  Function? pushNavigation;
  Function? popNavigation;
  Function? showDialog;

  navigateTo(ScreenEnum screen) {
    currentScreen = screen;
    pushNavigation?.call();
    notifyListeners();
  }

  navigateBack() {
    if (context != null && popNavigation != null) {
      popNavigation!.call(context);
    } else {
      errorService.notifyError("Navigation back error");
    }
  }

  onClickMenuTab(int index) {
    switch (index) {
      case 0:
        navigateTo(ScreenEnum.home);
        break;
      default:
        navigateTo(ScreenEnum.home);
    }
  }

  openBottomSheet({
    required Widget widget,
  }) {
    bottomSheet = widget;
    notifyListeners();
  }

  closeBottomSheet() {
    bottomSheet = null;
    if (context != null) {
      Navigator.pop(context!);
      context = null;
    }
    notifyListeners();
  }

  openSnackBar({
    required Widget widget,
  }) {
    snackBar = widget;
    notifyListeners();
  }

  closeSnackBar() {
    snackBar = null;
    if (context != null) {
      Navigator.pop(context!);
      context = null;
    }
    notifyListeners();
  }

  notify() {
    notifyListeners();
  }
}
