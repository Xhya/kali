import 'dart:io';
import 'dart:ui';
import 'package:kali/client/widgets/Refresh.widget.dart';
import 'package:kali/core/services/Translation.service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:kali/client/widgets/MainButton.widget.dart';
import 'package:kali/core/states/configuration.state.dart';
import 'package:kali/core/utils/paths.utils.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/core/actions/checkAppVersion.actions.dart';

Future<void> onClickUpdateApplicationOnStore() async {
  final String url =
      Platform.isAndroid
          ? "https://play.google.com/store/apps/details?id=com.horace.kali"
          : "https://apps.apple.com/app/6748620253";

  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  } else {
    throw "Impossible d'ouvrir le store: $url";
  }
}

class ForceUpdateScreen extends StatefulWidget {
  const ForceUpdateScreen({super.key});

  @override
  State<ForceUpdateScreen> createState() => _ForceUpdateScreenState();
}

class _ForceUpdateScreenState extends State<ForceUpdateScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      refreshAppVersion();
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentVersion = context.select(
      (ConfigurationState s) => s.currentVersion.value,
    );
    final minimalVersion = context.select(
      (ConfigurationState s) => s.minimalVersion.value,
    );

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("$imagesPath/header-photo.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: RefreshWidget(
          onRefresh: () async {
            await refreshAppVersion();
          },
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 16),
                    Image.asset('$imagesPath/logo-white-700.png', height: 32),
                    SizedBox(height: 4),
                    Text(
                      t('less_computing_more_result'),
                      style: style.text.reverse_neutral.merge(
                        style.fontsize.sm,
                      ),
                    ),
                  ],
                ),

                Column(
                  spacing: 16,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 20,
                            ),
                            alignment: Alignment.center,
                            color: Colors.white.withOpacity(0.2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Nouvelle mise à jour",
                                  textAlign: TextAlign.center,
                                  style: style.fontsize.md.merge(
                                    style.text.reverse_neutral,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Pour être au top de ses performances,",
                                  textAlign: TextAlign.center,
                                  style: style.fontsize.xs.merge(
                                    style.text.reverse_neutral,
                                  ),
                                ),
                                Text(
                                  "Kali a besoin d'être mise à jour",
                                  textAlign: TextAlign.center,
                                  style: style.fontsize.xs.merge(
                                    style.text.reverse_neutral,
                                  ),
                                ),
                                SizedBox(height: 12),
                                Text(
                                  "Version actuelle: $currentVersion",
                                  textAlign: TextAlign.center,
                                  style: style.fontsize.xs.merge(
                                    style.text.reverse_neutral,
                                  ),
                                ),
                                Text(
                                  "Version requise: $minimalVersion",
                                  textAlign: TextAlign.center,
                                  style: style.fontsize.xs.merge(
                                    style.text.reverse_neutral,
                                  ),
                                ),
                                SizedBox(height: 24),
                                MainButtonWidget(
                                  onClick: () {
                                    onClickUpdateApplicationOnStore();
                                  },
                                  text: "mettre à jour",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
