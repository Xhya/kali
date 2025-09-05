import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:kali/client/widgets/Subscriptions.widget.dart';
import 'package:kali/client/widgets/WelcomeBottomSheet.widget.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/states/configuration.state.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/CustomCard.widget.dart';

class PushNotificationPermissionWidget extends StatefulWidget {
  const PushNotificationPermissionWidget({super.key, this.padding = 0});

  final int padding;

  @override
  State<PushNotificationPermissionWidget> createState() =>
      _PushNotificationPermissionWidgetState();
}

class _PushNotificationPermissionWidgetState
    extends State<PushNotificationPermissionWidget> {
  var show = false;

  @override
  void initState() {
    super.initState();

    init() async {
      final notif = await FirebaseMessaging.instance.getNotificationSettings();
      setState(() {
        show = notif.authorizationStatus != AuthorizationStatus.authorized;
      });
    }

    init();
  }

  @override
  Widget build(BuildContext context) {
    if (show) {
      return Padding(
        padding: EdgeInsets.only(bottom: widget.padding.toDouble()),
        child: CustomCard(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          secondary: true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: style.fontsize.sm.fontSize,
                      color: style.text.neutral.color,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: "Activer les "),
                      TextSpan(
                        text: "notifications",
                        style: TextStyle(decoration: TextDecoration.underline),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () async {
                                await FirebaseMessaging.instance
                                    .requestPermission(
                                      alert: true,
                                      badge: true,
                                      sound: true,
                                    );
                              },
                      ),
                      TextSpan(text: " pour continuer dans la bonne direction"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
