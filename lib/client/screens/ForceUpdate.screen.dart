import 'package:flutter/material.dart';
import 'package:kali/core/states/configuration.state.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/layout/Base.scaffold.dart';
import 'package:kali/core/actions/checkAppVersion.actions.dart';

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

    return BaseScaffold(
      child: Scaffold(
        backgroundColor: style.background.greenTransparent.color,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("A new version is available"),
                    Text("Please update the app to continue"),
                    Text("Votre version actuelle: $currentVersion"),
                    Text("Nouvelle version: $minimalVersion"),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
