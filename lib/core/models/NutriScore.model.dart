import 'package:kalori/core/models/MealPeriod.enum.dart';

class NutriScore {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String mealDescription;
  final MealPeriodEnum period;
  final double proteinAmount;
  final double glucidAmount;
  final double lipidAmount;
  final double caloryAmount;

  NutriScore({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.mealDescription,
    required this.period,
    required this.proteinAmount,
    required this.glucidAmount,
    required this.lipidAmount,
    required this.caloryAmount,
  });

  factory NutriScore.fromJson(Map<String, dynamic> json) {
    return NutriScore(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['createdAt']).toLocal(),
      updatedAt: DateTime.parse(json['updatedAt']).toLocal(),
      mealDescription: json['mealDescription'] as String,
      period: MealPeriodEnum.fromText(json['period'] as String),
      lipidAmount: json['lipidAmount'] as double,
      glucidAmount: json['glucidAmount'] as double,
      proteinAmount: json['proteinAmount'] as double,
      caloryAmount: json['caloryAmount'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'mealDescription': mealDescription,
      'period': period.label,
      'lipidAmount': lipidAmount,
      'glucidAmount': glucidAmount,
      'proteinAmount': proteinAmount,
      'caloryAmount': caloryAmount,
    };
  }
}
