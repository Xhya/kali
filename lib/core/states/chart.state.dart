import 'package:flutter/material.dart';
import 'package:kali/core/models/ChartData.model.dart';

final chartState = ChartState();

class ChartState extends ChangeNotifier {
  final isRefreshLoading = ValueNotifier<bool>(false);
  final caloriesData = ValueNotifier<List<ChartData>>([]);

  ChartState() {
    isRefreshLoading.addListener(notifyListeners);
    caloriesData.addListener(notifyListeners);
  }

  @override
  void dispose() {
    isRefreshLoading.dispose();
    caloriesData.dispose();
    super.dispose();
  }
}
