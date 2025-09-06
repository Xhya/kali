import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kali/core/services/Error.service.dart';

enum ScreenEnum {
  register,
  login,
  start,
  startForm,
  home,
  meal,
  meals,
  profile,
  editProfile,
  personalNutriscore,
  evolution,
}

var navigationService = NavigationService();

class NavigationService extends ChangeNotifier {
  NavigationService() {
    bottomSheet.addListener(notifyListeners);
    snackBar.addListener(notifyListeners);
  }

  @override
  void dispose() {
    bottomSheet.dispose();
    snackBar.dispose();
    super.dispose();
  }

  bool initialScreenSet = false;

  ScreenEnum currentScreen = ScreenEnum.startForm;
  bool userScaffoldObserved = false;
  BuildContext? context;
  final bottomSheet = ValueNotifier<Widget?>(null);
  final snackBar = ValueNotifier<Widget?>(null);
  Function? nextAction;

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

  void navigateTo(ScreenEnum screen) {
    currentScreen = screen;
    pushNavigation?.call();
    notifyListeners();
  }

  void navigateBack() {
    if (context != null && popNavigation != null) {
      popNavigation?.call();
    } else {
      errorService.notifyError(e: Exception("Navigation back error"));
    }
  }

  void onClickMenuTab(int index) {
    switch (index) {
      case 0:
        navigateTo(ScreenEnum.home);
        break;
      default:
        navigateTo(ScreenEnum.home);
    }
  }

  void openBottomSheet({required Widget widget}) {
    if (bottomSheet.value == null) {
      bottomSheet.value = widget;
      notifyListeners();
    }
  }

  void closeBottomSheet() {
    bottomSheet.value = null;
    if (context != null) {
      Navigator.pop(context!);
      context = null;
    }
    notifyListeners();
  }

  void openSnackBar({required Widget widget}) {
    snackBar.value = widget;
    notifyListeners();
  }

  void closeSnackBar() {
    snackBar.value = null;
    if (context != null) {
      Navigator.pop(context!);
      context = null;
    }
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }
}
