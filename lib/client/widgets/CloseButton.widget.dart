import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';

class CloseButtonWidget extends StatefulWidget {
  const CloseButtonWidget({super.key, required this.onClose});

  final VoidCallback onClose;

  @override
  State<CloseButtonWidget> createState() => _CloseButtonWidgetState();
}

class _CloseButtonWidgetState extends State<CloseButtonWidget> {
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
    return Container(
      height: 32,
      width: 32,
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        border: Border.all(color: style.icon.color1.color!, width: 1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        padding: EdgeInsets.all(0),
        onPressed: () {
          widget.onClose();
        },
        icon: Icon(
          Icons.close,
          color: style.icon.color1.color,
          size: style.fontsize.md.fontSize,
        ),
      ),
    );
  }
}
