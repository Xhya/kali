import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/CustomInkwell.widget.dart';
import 'package:kali/core/actions/googleSignIn.actions.dart';
import 'package:kali/core/states/googleSignIn.state.dart';
import 'package:kali/core/utils/paths.utils.dart';

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({super.key, required this.action});

  final String action;

  @override
  State createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  @override
  void initState() {
    super.initState();
    googleSignInState.action.value = widget.action;
  }

  @override
  Widget build(BuildContext context) {
    return CustomInkwell(
      onTap: () {
        signInWithGoogle();
      },
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          decoration: BoxDecoration(
            color: style.background.grey.color!.withValues(alpha: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Row(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                '$imagesPath/google_logo.png',
                width: 20,
                height: 20,
                fit: BoxFit.cover,
              ),
              Text(
                "se connecter avec Google",
                textAlign: TextAlign.center,
                style: style.fontsize.sm
                    .merge(style.text.neutral)
                    .merge(style.fontweight.semibold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
