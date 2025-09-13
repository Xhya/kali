import 'package:kali/core/domains/feature.repository.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/states/feature.state.dart';

final featureService = FeatureService();

class FeatureService {
  final FeatureRepository _featureRepository = FeatureRepository();

  Future<void> refreshFeatures() async {
    try {
      featureState.isLoadingFeatures.value = true;
      featureState.features.value = await _featureRepository.getNextFeatures();
    } catch (e, stack) {
      errorService.notifyError(e: e, stack: stack);
    } finally {
      featureState.isLoadingFeatures.value = false;
    }
  }
}
