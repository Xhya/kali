class NutriScore {
  final double proteinAmount;
  final double glucidAmount;
  final double lipidAmount;

  NutriScore({
    required this.proteinAmount,
    required this.glucidAmount,
    required this.lipidAmount,
  });

  factory NutriScore.fromJson(Map<String, dynamic> json) {
    return NutriScore(
      lipidAmount: json['lipidAmount'] as double,
      glucidAmount: json['glucidAmount'] as double,
      proteinAmount: json['proteinAmount'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {'lipidAmount': lipidAmount, 'glucidAmount': glucidAmount, 'proteinAmount': proteinAmount};
  }
}
