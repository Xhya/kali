import 'package:kalori/client/Style.service.dart';
import 'package:kalori/core/services/Navigation.service.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class TitleScaffold extends StatelessWidget {
  const TitleScaffold({
    super.key,
    required this.child,
    required this.title,
  });

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    var actions = context.select((NavigationService s) => s.actions);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          title,
          style: style.text.neutral
              .merge(style.fontsize.lg)
              .merge(style.fontweight.bold),
        ),
        actions: actions,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey[300]!),
            ),
          ),
        ),
      ),
      body: Material(child: child),
    );
  }
}
