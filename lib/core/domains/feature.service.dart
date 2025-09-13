import 'package:kali/core/domains/feature.repository.dart';
import 'package:kali/core/states/feature.state.dart';

final featureService = FeatureService();

class FeatureService {
  final FeatureRepository _featureRepository = FeatureRepository();

  Future<void> refreshFeatures() async {
    featureState.features.value = await _featureRepository.getNextFeatures();
  }

  Future<void> voteFeature(String featureId) async {
    await _featureRepository.voteNextFeature(featureId: featureId);
  }
}
