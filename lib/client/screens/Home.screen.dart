import 'package:flutter/material.dart';
import 'package:kalory/client/Style.service.dart';
import 'package:kalory/client/layout/Base.scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Container(
          color: style.background.color1.color,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  Text(
                    "Go!",
                    maxLines: 1,
                    style: style.text.color1.merge(style.fontsize.md),
                  )
                ],
              ),
              Expanded(child: Text("Toto")),
            ],
          )),
    );
  }
}
