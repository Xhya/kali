enum MealPeriodEnum {
  breakfast('breakfast', 0),
  lunch('lunch', 1),
  snack('snack', 2),
  dinner('dinner', 3);

  const MealPeriodEnum(this.label, this.order);
  final String label;
  final int order;

  factory MealPeriodEnum.fromText(String text) {
    return MealPeriodEnum.values.firstWhere((it) => it.label == text);
  }
}
