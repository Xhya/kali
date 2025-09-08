import 'package:flutter/material.dart';
import 'package:kali/core/models/ChartData.model.dart';

final chartState = ChartState();

class ChartState extends ChangeNotifier {
  final isRefreshLoading = ValueNotifier<bool>(false);
  final caloriesData = ValueNotifier<List<ChartData>>([]);
  final glucidsData = ValueNotifier<List<ChartData>>([]);
  final proteinsData = ValueNotifier<List<ChartData>>([]);
  final lipidsData = ValueNotifier<List<ChartData>>([]);
  final weightsData = ValueNotifier<List<ChartData>>([]);

  final showCalories = ValueNotifier<bool>(true);
  final showGlucids = ValueNotifier<bool>(false);
  final showLipids = ValueNotifier<bool>(false);
  final showProteins = ValueNotifier<bool>(false);

  ChartState() {
    isRefreshLoading.addListener(notifyListeners);
    caloriesData.addListener(notifyListeners);
    glucidsData.addListener(notifyListeners);
    proteinsData.addListener(notifyListeners);
    lipidsData.addListener(notifyListeners);
    weightsData.addListener(notifyListeners);

    showCalories.addListener(notifyListeners);
    showGlucids.addListener(notifyListeners);
    showLipids.addListener(notifyListeners);
    showProteins.addListener(notifyListeners);
  }

  @override
  void dispose() {
    isRefreshLoading.dispose();
    caloriesData.dispose();
    glucidsData.dispose();
    proteinsData.dispose();
    lipidsData.dispose();
    weightsData.dispose();

    showCalories.dispose();
    showGlucids.dispose();
    showLipids.dispose();
    showProteins.dispose();

    super.dispose();
  }
}
