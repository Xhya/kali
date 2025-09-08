import 'package:kali/core/domains/chart.repository.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/states/chart.state.dart';

final chartService = ChartService();

class ChartService {
  final ChartRepository _chartRepository = ChartRepository();

  Future<void> refreshEvolution() async {
    try {
      chartState.isRefreshLoading.value = true;
      final evolution = await _chartRepository.getEvolution();
      chartState.caloriesData.value = evolution.calories;
      chartState.glucidsData.value = evolution.glucids;
      chartState.proteinsData.value = evolution.proteins;
      chartState.lipidsData.value = evolution.lipids;
      chartState.weightsData.value = evolution.weights;
    } catch (e, stack) {
      errorService.notifyError(e: e, stack: stack);
    } finally {
      chartState.isRefreshLoading.value = false;
    }
  }
}
