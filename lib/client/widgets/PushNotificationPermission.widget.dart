import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/CloseButton.widget.dart';
import 'package:kali/client/widgets/CustomCard.widget.dart';
import 'package:kali/core/utils/storageKeys.utils.dart';
import 'package:permission_handler/permission_handler.dart';

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
  var notDetermined = true;

  @override
  void initState() {
    super.initState();

    init() async {
      final notif = await FirebaseMessaging.instance.getNotificationSettings();
      final lastDateStr = await FlutterSecureStorage().read(
        key: lastDatePushNotificationShowedKey,
      );
      final lastDate =
          lastDateStr != null ? DateTime.parse(lastDateStr).toLocal() : null;
      setState(() {
        notDetermined =
            notif.authorizationStatus == AuthorizationStatus.notDetermined;

        show =
            notDetermined &&
            (lastDate == null || lastDate.isAfter(DateTime.now()));
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
            spacing: 12,
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
                                if (!notDetermined) {
                                  openAppSettings();
                                } else {
                                  await FirebaseMessaging.instance
                                      .requestPermission(
                                        alert: true,
                                        badge: true,
                                        sound: true,
                                      );
                                }
                              },
                      ),
                      TextSpan(text: " pour continuer dans la bonne direction"),
                    ],
                  ),
                ),
              ),
              CloseButtonWidget(
                onClose: () async {
                  await FlutterSecureStorage().write(
                    key: lastDatePushNotificationShowedKey,
                    value: DateTime.now().toIso8601String(),
                  );
                  setState(() {
                    show = false;
                  });
                },
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
