import 'package:kali/core/models/Feature.model.dart';

final featureData = FeatureData();

class FeatureData {
  List<FeatureModel> _previousFeatures = [];
  List<FeatureModel> _features = [];

  FeatureData() {}

  void setFeatures(List<FeatureModel> features) async {
    _features = features;
  }

  List<FeatureModel> voteFeature(String featureId) {
    _previousFeatures = _features;
    final newFeatures =
        _features.map((it) {
          if (it.id == featureId) {
            it.isVoted = !it.isVoted;
          }
          return it;
        }).toList();
    return newFeatures;
  }

  List<FeatureModel> resetChange() {
    _features = _previousFeatures;
    return _features;
  }
}
