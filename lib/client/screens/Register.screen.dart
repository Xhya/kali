import 'package:flutter/material.dart';
import 'package:kali/client/layout/Base.scaffold.dart';
import 'package:kali/client/widgets/Register.widget.dart';
import 'package:kali/core/utils/linearGradient.utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Container(
        decoration: BoxDecoration(gradient: linearGradient),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
          child: Column(children: [SizedBox(height: 8), RegisterWidget()]),
        ),
      ),
    );
  }
}
