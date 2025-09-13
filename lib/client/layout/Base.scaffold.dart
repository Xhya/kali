import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kali/client/widgets/CustomInkwell.widget.dart';
import 'package:kali/core/services/Translation.service.dart';
import 'package:kali/core/services/connexion.service.dart';
import 'package:kali/core/utils/paths.utils.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/MaybeConnexionMissingWidget.widget.dart';
import 'package:kali/core/services/Navigation.service.dart';

class BaseScaffold extends StatefulWidget {
  const BaseScaffold({
    super.key,
    required this.child,
    this.backButton = false,
    this.profileButton = false,
    this.resizeToAvoidBottomInset = true,
    this.onNavigateBack,
  });

  final Widget child;
  final bool backButton;
  final bool profileButton;
  final bool resizeToAvoidBottomInset;
  final Function? onNavigateBack;

  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  @override
  Widget build(BuildContext context) {
    bool hasInternetConnexion = context.select(
      (ConnexionService v) => v.hasInternetConnexion.value,
    );

    double headerHeight = hasInternetConnexion ? 72 : 72 + 25;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    height: 72,
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
                            // Text(
                            //   t('less_computing_more_result'),
                            //   style: style.text.reverse_neutral.merge(
                            //     style.fontsize.sm,
                            //   ),
                            // ),
                          ],
                        ),
                        if (widget.backButton)
                          Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            child: Center(
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
                                    Icons.arrow_back,
                                    color: style.icon.color3.color,
                                    size: style.fontsize.lg.fontSize,
                                  ),
                                ),
                                onTap: () {
                                  HapticFeedback.vibrate();
                                  widget.onNavigateBack?.call();
                                  navigationService.context = context;
                                  navigationService.navigateBack();
                                },
                              ),
                            ),
                          ),
                        if (widget.profileButton)
                          Positioned(
                            top: 0,
                            bottom: 0,
                            right: 0,
                            child: CustomInkwell(
                              child: Center(
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
                              ),
                              onTap: () {
                                HapticFeedback.vibrate();
                                navigationService.navigateTo(
                                  ScreenEnum.profile,
                                );
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
