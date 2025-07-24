import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/layout/Base.scaffold.dart';
import 'package:kali/client/widgets/Login.widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Container(
        decoration: BoxDecoration(
          color: style.background.greenTransparent.color,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
          child: Column(children: [SizedBox(height: 8), LoginWidget()]),
        ),
      ),
    );
  }
}
