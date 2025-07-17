import 'package:flutter/material.dart';

class StartFormPage2 extends StatefulWidget {
  const StartFormPage2({super.key});

  @override
  State<StartFormPage2> createState() => _StartFormPage2State();
}

class _StartFormPage2State extends State<StartFormPage2> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Text("Rentrons un peu dans les détails"),
    );
  }
}
