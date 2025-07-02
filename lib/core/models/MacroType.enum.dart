enum MacroTypeEnum {
  breakfast('proteins'),
  lunch('glucids'),
  snack('lipids'),
  dinner('calories');

  const MacroTypeEnum(this.label);
  final String label;

  factory MacroTypeEnum.fromText(String text) {
    return MacroTypeEnum.values.firstWhere((it) => it.label == text);
  }
}
