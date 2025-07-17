import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';

class StartFormPage3 extends StatefulWidget {
  const StartFormPage3({super.key});

  @override
  State<StartFormPage3> createState() => _StartFormPage3State();
}

class _StartFormPage3State extends State<StartFormPage3> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12),
            Text(
              "Quel est ton objectif principal ?",
              style: style.text.neutral.merge(style.fontsize.lg),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
