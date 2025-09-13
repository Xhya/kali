enum FeatureTypeEnum {
  next('next');

  const FeatureTypeEnum(this.label);
  final String label;

  factory FeatureTypeEnum.fromText(String text) {
    return FeatureTypeEnum.values.firstWhere((it) => it.label == text);
  }
}
