import 'package:flutter/material.dart';
import 'package:kali/core/models/Weight.model.dart';

final weightState = WeightState();

class WeightState extends ChangeNotifier {
  final weights = ValueNotifier<List<WeightModel>>([]);
  final newWeight = ValueNotifier<int?>(null);
  final isAddingWeightLoading = ValueNotifier<bool>(false);
  final isRefreshLoading = ValueNotifier<bool>(false);

  WeightState() {
    weights.addListener(notifyListeners);
    newWeight.addListener(notifyListeners);
    isAddingWeightLoading.addListener(notifyListeners);
    isRefreshLoading.addListener(notifyListeners);
  }

  @override
  void dispose() {
    weights.dispose();
    newWeight.dispose();
    isAddingWeightLoading.dispose();
    isRefreshLoading.dispose();
    super.dispose();
  }
}
