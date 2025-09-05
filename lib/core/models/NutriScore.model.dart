class NutriScore {
  String? id;
  int proteinAmount;
  int glucidAmount;
  int lipidAmount;
  int caloryAmount;
  String? thinking;

  NutriScore({
    this.id,
    required this.proteinAmount,
    required this.glucidAmount,
    required this.lipidAmount,
    required this.caloryAmount,
    this.thinking,
  });

  factory NutriScore.fromJson(Map<String, dynamic> json) {
    return NutriScore(
      id: json['id'] as String,
      lipidAmount: json['lipidAmount'] as int,
      glucidAmount: json['glucidAmount'] as int,
      proteinAmount: json['proteinAmount'] as int,
      caloryAmount: json['caloryAmount'] as int,
      thinking: json['thinking'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lipidAmount': lipidAmount,
      'glucidAmount': glucidAmount,
      'proteinAmount': proteinAmount,
      'caloryAmount': caloryAmount,
      'thinking': thinking,
    };
  }

  bool isEmpty() {
    return proteinAmount == 0 &&
        glucidAmount == 0 &&
        lipidAmount == 0 &&
        caloryAmount == 0;
  }
}
