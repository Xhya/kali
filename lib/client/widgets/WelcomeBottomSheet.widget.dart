import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/core/utils/linearGradient.utils.dart';

class WelcomeBottomSheet extends StatefulWidget {
  const WelcomeBottomSheet({super.key, required this.child, this.size = 'medium'});

  final Widget child;
  final String size;

  @override
  State<WelcomeBottomSheet> createState() => _WelcomeBottomSheetState();
}

class _WelcomeBottomSheetState extends State<WelcomeBottomSheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = widget.size == 'small'
        ? 400.0
        : MediaQuery.of(context).size.height - 80;

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      child: Container(
        width: double.maxFinite,
        height: height,
        decoration: BoxDecoration(gradient: linearGradient),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  HapticFeedback.vibrate();
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close, color: style.icon.color1.color),
              ),
            ),
            widget.child,
          ],
        ),
      ),
    );
  }
}
