class NutriScore {
  String? id;
  int proteinAmount;
  int glucidAmount;
  int lipidAmount;
  int caloryAmount;

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
      lipidAmount: json['lipidAmount'] as int,
      glucidAmount: json['glucidAmount'] as int,
      proteinAmount: json['proteinAmount'] as int,
      caloryAmount: json['caloryAmount'] as int,
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

  bool isEmpty() {
    return proteinAmount == 0 &&
        glucidAmount == 0 &&
        lipidAmount == 0 &&
        caloryAmount == 0;
  }
}
