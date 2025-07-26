enum OperatingSystemEnum {
  android('android'),
  ios('ios'),
  web('web'),
  unknown('unknown');

  const OperatingSystemEnum(this.label);
  final String label;

  factory OperatingSystemEnum.fromText(String text) {
    return OperatingSystemEnum.values.firstWhere((it) => it.label == text);
  }
}
