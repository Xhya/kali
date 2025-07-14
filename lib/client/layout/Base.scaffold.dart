import 'package:flutter/material.dart';
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
      // topBannerState.show.value = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool hasInternetConnexion =
        context.watch<ConnexionService>().hasInternetConnexion.value;

    double headerHeight = hasInternetConnexion ? 80 : 105;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(headerHeight),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/header-photo.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    height: 80,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: style.text.reverse_neutral
                                    .merge(style.fontsize.xl)
                                    .merge(style.fontweight.bold),
                                children: <TextSpan>[
                                  TextSpan(text: "Kali"),
                                  TextSpan(
                                    text: ",",
                                    style: style.text.greenLight,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "tu racontes, je compte",
                              style: style.text.reverse_neutral.merge(
                                style.fontsize.sm,
                              ),
                            ),
                          ],
                        ),

                        IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            navigationService.navigateTo(
                              ScreenEnum.personalNutriScore,
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              style.iconBackground.color1.color,
                            ),
                          ),
                          icon: Icon(
                            Icons.settings_outlined,
                            color: style.icon.color1.color,
                            size: style.fontsize.md.fontSize,
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
      ),
      body: Material(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width,
                maxHeight: MediaQuery.of(context).size.height,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
                child: widget.child,
              ),
            );
          },
        ),
      ),
    );
  }
}
