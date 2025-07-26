import 'package:flutter/material.dart';
import 'package:kali/client/widgets/CustomInkwell.widget.dart';
import 'package:kali/core/services/connexion.service.dart';
import 'package:kali/core/utils/paths.utils.dart';
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

class _BaseScaffoldState extends State<BaseScaffold> {
  @override
  Widget build(BuildContext context) {
    bool hasInternetConnexion = context.select(
      (ConnexionService v) => v.hasInternetConnexion.value,
    );

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
                  image: AssetImage("$imagesPath/header-photo.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    height: 80,
                    width: double.maxFinite,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              '$imagesPath/logo-white-700.png',
                              height: 32,
                            ),
                            Text(
                              "tu racontes, je compte",
                              style: style.text.reverse_neutral.merge(
                                style.fontsize.sm,
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 5,
                          right: 0,
                          child: CustomInkwell(
                            child: Container(
                              width: 40,
                              height: 40,
                              padding: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Icon(
                                Icons.person_outline,
                                color: style.icon.color3.color,
                                size: style.fontsize.lg.fontSize,
                              ),
                            ),
                            onTap: () {
                              navigationService.navigateTo(ScreenEnum.personalNutriScore);
                            },
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
