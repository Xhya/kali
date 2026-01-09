import 'package:kali/repository/weight.repository.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/states/weight.state.dart';

final weightService = WeightService();

class WeightService {
  final WeightRepository _weightRepository = WeightRepository();

  Future<void> refreshWeights() async {
    try {
      weightState.isRefreshLoading.value = true;
      weightState.weights.value = await _weightRepository.getWeights();
    } catch (e, stack) {
      errorService.notifyError(e: e, stack: stack);
    } finally {
      weightState.isRefreshLoading.value = false;
    }
  }

  Future<void> addWeight() async {
    if (weightState.newWeight.value == null) {
      return;
    }
    try {
      weightState.isAddingWeightLoading.value = true;
      weightState.weights.value = await _weightRepository.addWeight(
        weight: weightState.newWeight.value!,
      );
    } catch (e, stack) {
      errorService.notifyError(e: e, stack: stack);
    } finally {
      weightState.isAddingWeightLoading.value = false;
    }
  }
}
