import 'package:kali/core/domains/chart.repository.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/states/chart.state.dart';

final chartService = ChartService();

class ChartService {
  final ChartRepository _chartRepository = ChartRepository();

  Future<void> refreshEvolution() async {
    try {
      chartState.isRefreshLoading.value = true;
      chartState.caloriesData.value = await _chartRepository.getEvolution();
    } catch (e, stack) {
      errorService.notifyError(e: e, stack: stack);
    } finally {
      chartState.isRefreshLoading.value = false;
    }
  }
}
