import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:kali/client/Style.service.dart';

class ShareButtonWidget extends StatefulWidget {
  const ShareButtonWidget({super.key, required this.message});

  final String message;

  @override
  State<ShareButtonWidget> createState() => _ShareButtonWidgetState();
}

class _ShareButtonWidgetState extends State<ShareButtonWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void shareOnWhatsApp() {
    SharePlus.instance.share(ShareParams(text: widget.message));
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.all(0),
      onPressed: () {
        shareOnWhatsApp();
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          style.iconBackground.color1.color,
        ),
      ),
      icon: Icon(Icons.share),
      color: style.icon.color1.color,
      iconSize: style.fontsize.lg.fontSize,
    );
  }
}
