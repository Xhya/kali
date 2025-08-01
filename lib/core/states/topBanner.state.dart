import 'package:flutter/material.dart';

final topBannerState = TopBannerState();

class TopBannerState extends ChangeNotifier {
  final show = ValueNotifier<bool>(false);

  TopBannerState() {
    show.addListener(notifyListeners);
  }

  @override
  void dispose() {
    show.dispose();
    super.dispose();
  }
}
