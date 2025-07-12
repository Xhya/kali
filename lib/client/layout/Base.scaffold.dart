import 'package:flutter/material.dart';
import 'package:kali/core/domains/topBanner.state.dart';
import 'package:kali/core/services/connexion.service.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/MaybeConnexionMissingWidget.widget.dart';
import 'package:kali/core/services/Navigation.service.dart';

class BaseScaffold extends StatefulWidget {
  const BaseScaffold({super.key, required this.child});

  final Widget child;

  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      topBannerState.show.value = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool hasInternetConnexion =
        context.watch<ConnexionService>().hasInternetConnexion.value;

    double headerHeight = hasInternetConnexion ? 70 : 95;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(headerHeight),
        child: AppBar(
          backgroundColor: style.background.color3.color,
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  height: 70,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Kali",
                        style: style.text.color2
                            .merge(style.fontsize.xl)
                            .merge(style.fontweight.bold),
                      ),
                      IconButton(
                        onPressed: () {
                          navigationService.navigateTo(
                            ScreenEnum.personalNutriScore,
                          );
                        },
                        icon: Icon(
                          Icons.settings,
                          color: style.icon.color1.color,
                          size: style.fontsize.xl.fontSize,
                        ),
                      ),
                    ],
                  ),
                ),
                MaybeConnexionMissingWidget(),
              ],
            ),
          ),
        ),
      ),
      body: Material(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width,
                maxHeight: MediaQuery.of(context).size.height,
              ),
              child: widget.child,
            );
          },
        ),
      ),
    );
  }
}
