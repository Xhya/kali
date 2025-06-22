class NutriScore {
  String? id;
  double proteinAmount;
  double glucidAmount;
  double lipidAmount;
  double caloryAmount;

  NutriScore({
    this.id,
    required this.proteinAmount,
    required this.glucidAmount,
    required this.lipidAmount,
    required this.caloryAmount,
  });

  factory NutriScore.fromJson(Map<String, dynamic> json) {
    return NutriScore(
      id: json['id'] as String,
      lipidAmount: json['lipidAmount'] as double,
      glucidAmount: json['glucidAmount'] as double,
      proteinAmount: json['proteinAmount'] as double,
      caloryAmount: json['caloryAmount'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lipidAmount': lipidAmount,
      'glucidAmount': glucidAmount,
      'proteinAmount': proteinAmount,
      'caloryAmount': caloryAmount,
    };
  }
}
