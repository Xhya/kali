import 'package:flutter/material.dart';
import 'package:kali/core/models/Feature.model.dart';

final featureState = FeatureState();

class FeatureState extends ChangeNotifier {
  final isLoadingFeatures = ValueNotifier<bool>(false);
  final features = ValueNotifier<List<FeatureModel>>(List.empty());

  FeatureState() {
    isLoadingFeatures.addListener(notifyListeners);
    features.addListener(notifyListeners);
  }

  @override
  void dispose() {
    isLoadingFeatures.dispose();
    features.dispose();
    super.dispose();
  }
}
