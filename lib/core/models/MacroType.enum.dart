enum MacroTypeEnum {
  proteins('proteins'),
  glucids('glucids'),
  lipids('lipids'),
  calories('calories');

  const MacroTypeEnum(this.label);
  final String label;

  factory MacroTypeEnum.fromText(String text) {
    return MacroTypeEnum.values.firstWhere((it) => it.label == text);
  }
}
