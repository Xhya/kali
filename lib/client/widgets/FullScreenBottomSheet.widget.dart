import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/core/utils/linearGradient.utils.dart';

class FullScreenBottomSheet extends StatefulWidget {
  const FullScreenBottomSheet({
    super.key,
    required this.child,
    this.canClose = true,
  });

  final Widget child;
  final bool canClose;

  @override
  State<FullScreenBottomSheet> createState() => _FullScreenBottomSheetState();
}

class _FullScreenBottomSheetState extends State<FullScreenBottomSheet> {
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
    return ClipRRect(
      child: Container(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(gradient: linearGradient),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Stack(
          children: [
            if (widget.canClose)
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
