import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/core/states/Input.state.dart';

class ThinkingWidget extends StatefulWidget {
  const ThinkingWidget({super.key, required this.thinking});

  final String thinking;

  @override
  State<ThinkingWidget> createState() => _ThinkingWidgetState();
}

class _ThinkingWidgetState extends State<ThinkingWidget> {
  @override
  void initState() {
    super.initState();
    inputState.reset();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Détails nutritionnels"),
              content: SizedBox(
                width: double.maxFinite,
                child: Markdown(
                  data: widget.thinking,
                  onTapLink: (text, href, title) {
                    if (href != null) {
                      launchUrl(Uri.parse(href));
                    }
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Fermer"),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        padding: EdgeInsets.only(left: 4, top: 2),
        child: Text(
          "En savoir plus",
          style: style.fontsize.xs
              .merge(style.text.neutralLight)
              .merge(TextStyle(decoration: TextDecoration.underline)),
        ),
      ),
    );
  }
}
