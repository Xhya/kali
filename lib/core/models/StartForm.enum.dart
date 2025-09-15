enum GenderEnum {
  female('female'),
  male('male'),
  other('other');

  const GenderEnum(this.label);
  final String label;

  factory GenderEnum.fromText(String text) {
    return GenderEnum.values.firstWhere((it) => it.label == text);
  }
}

enum ResultOptionEnum {
  quick('quick'),
  normal('normal');

  const ResultOptionEnum(this.label);
  final String label;

  factory ResultOptionEnum.fromText(String text) {
    return ResultOptionEnum.values.firstWhere((it) => it.label == text);
  }
}

enum ObjectiveOptionEnum {
  loseWeight('lose_weight'),
  maintainWeight('maintain_weight'),
  gainMuscle('gain_muscle');

  const ObjectiveOptionEnum(this.label);
  final String label;

  factory ObjectiveOptionEnum.fromText(String text) {
    return ObjectiveOptionEnum.values.firstWhere((it) => it.label == text);
  }
}

enum LifeOptionEnum {
  sit('sedentary'),
  light('light'),
  neutral('moderate'),
  stand('intense'),
  active('very_intense');

  const LifeOptionEnum(this.label);
  final String label;

  factory LifeOptionEnum.fromText(String text) {
    return LifeOptionEnum.values.firstWhere((it) => it.label == text);
  }
}
