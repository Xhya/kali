import 'package:kalori/core/models/MealPeriod.enum.dart';
import 'package:kalori/core/models/NutriScore.model.dart';

class MealModel {
  final String id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? date;
  final String? mealDescription;
  final MealPeriodEnum? period;
  final NutriScore? nutriScore;

  MealModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.date,
    required this.mealDescription,
    required this.period,
    required this.nutriScore,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['createdAt']).toLocal(),
      updatedAt: DateTime.parse(json['updatedAt']).toLocal(),
      date: DateTime.parse(json['date']).toLocal(),
      mealDescription: json['mealDescription'] as String,
      period: MealPeriodEnum.fromText(json['period'] as String),
      nutriScore: json['nutriScore'] == null ? null : NutriScore.fromJson(json['nutriScore']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'date': date?.toIso8601String(),
      'mealDescription': mealDescription,
      'period': period?.label,
      'nutriScore': nutriScore?.toJson(),
    };
  }
}
