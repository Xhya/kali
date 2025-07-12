import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/core/services/Navigation.service.dart';

class BaseScaffold extends StatefulWidget {
  const BaseScaffold({super.key, required this.child});

  final Widget child;

  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: style.background.color3.color,
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              height: double.maxFinite,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Kalori",
                    style: style.text.color2
                        .merge(style.fontsize.xl)
                        .merge(style.fontweight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      navigationService.navigateTo(
                        ScreenEnum.personalNutriScore,
                      );
                    },
                    icon: Icon(
                      Icons.settings,
                      color: style.icon.color1.color,
                      size: style.fontsize.xl.fontSize,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // actions: [
          //   IconButton(
          //     icon: Icon(
          //       Icons.auto_graph_outlined,
          //       color: style.icon.primary.color,
          //     ),
          //     onPressed: () {
          //       navigationService.context = context;
          //       navigationService.screenTitle = "Résumé des objectifs";
          //       navigationService.navigateTo(ScreenEnum.objectivesSummary);
          //     },
          //   ),
          // ],
        ),
      ),
      body: Material(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width,
                maxHeight: MediaQuery.of(context).size.height,
              ),
              child: widget.child,
            );
          },
        ),
      ),
    );
  }
}
