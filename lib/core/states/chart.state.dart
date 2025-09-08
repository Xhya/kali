import 'package:flutter/material.dart';
import 'package:kali/core/models/ChartData.model.dart';

final chartState = ChartState();

class ChartState extends ChangeNotifier {
  final isRefreshLoading = ValueNotifier<bool>(false);
  final caloriesData = ValueNotifier<List<ChartData>>([]);
  final glucidsData = ValueNotifier<List<ChartData>>([]);
  final proteinsData = ValueNotifier<List<ChartData>>([]);
  final lipidsData = ValueNotifier<List<ChartData>>([]);

  ChartState() {
    isRefreshLoading.addListener(notifyListeners);
    caloriesData.addListener(notifyListeners);
    glucidsData.addListener(notifyListeners);
    proteinsData.addListener(notifyListeners);
    lipidsData.addListener(notifyListeners);
  }

  @override
  void dispose() {
    isRefreshLoading.dispose();
    caloriesData.dispose();
    glucidsData.dispose();
    proteinsData.dispose();
    lipidsData.dispose();
    super.dispose();
  }
}
