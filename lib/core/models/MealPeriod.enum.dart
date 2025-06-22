enum MealPeriodEnum {
  breakfast('breakfast'),
  lunch('lunch'),
  snack('snack'),
  dinner('dinner');

  const MealPeriodEnum(this.label);
  final String label;

  factory MealPeriodEnum.fromText(String text) {
    return MealPeriodEnum.values.firstWhere((it) => it.label == text);
  }
}
