import 'package:flutter/material.dart';
import 'package:kalori/client/Style.service.dart';

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
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          backgroundColor: style.background.neutral.color,
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Container(
              height: double.maxFinite,
              color: style.background.color1.color,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
