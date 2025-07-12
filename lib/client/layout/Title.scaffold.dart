import 'package:kali/client/Style.service.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class TitleScaffold extends StatelessWidget {
  const TitleScaffold({super.key, required this.child, required this.title});

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    var actions = context.select((NavigationService s) => s.actions);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: style.background.color3.color,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: style.icon.color1.color,
            size: style.fontsize.xl.fontSize,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          title,
          style: style.text.color2
              .merge(style.fontsize.lg)
              .merge(style.fontweight.bold),
        ),
        actions: actions,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
          ),
        ),
      ),
      body: Material(child: child),
    );
  }
}
