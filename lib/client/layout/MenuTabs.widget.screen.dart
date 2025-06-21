import 'package:flutter/material.dart';
import 'package:kalori/client/Style.service.dart';
import 'package:kalori/core/services/Navigation.service.dart';
import 'package:provider/provider.dart';

class MenuTabs extends StatelessWidget {
  const MenuTabs({super.key});

  @override
  Widget build(BuildContext context) {
    var navigationCurrentIndex =
        context.select((NavigationService v) => v.currentIndex);

    return NavigationBarTheme(
      data: NavigationBarThemeData(
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return style.background.primary
                .merge(style.fontsize.md)
                .merge(style.fontweight.bold);
          }
          return style.background.primary.merge(style.fontsize.md);
        }),
      ),
      child: NavigationBar(
        backgroundColor: style.background.primary.color,
        selectedIndex: navigationCurrentIndex,
        onDestinationSelected: (index) {
          navigationService.onClickMenuTab(index);
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home, color: Colors.white),
            selectedIcon: Icon(Icons.home, color: style.icon.primary.color),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.remove_red_eye, color: Colors.white),
            selectedIcon: Icon(Icons.remove_red_eye, color: style.icon.primary.color),
            label: "Jounée",
          ),
        ],
      ),
    );
  }
}
