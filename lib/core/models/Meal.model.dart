import 'package:kali/core/models/MealPeriod.enum.dart';
import 'package:kali/core/models/NutriScore.model.dart';

class MealModel {
  final String id;
  final DateTime? date;
  final MealPeriodEnum? period;
  NutriScore? nutriscore;

  MealModel({
    required this.id,
    required this.date,
    required this.period,
    required this.nutriscore,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      id: json['id'] as String,
      date:
          json['date'] == null ? null : DateTime.parse(json['date']).toLocal(),
      period:
          json['period'] == null
              ? null
              : MealPeriodEnum.fromText(json['period'] as String),
      nutriscore:
          json['nutriscore'] == null
              ? null
              : NutriScore.fromJson(json['nutriscore']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date?.toIso8601String(),
      'period': period?.label,
      'nutriscore': nutriscore?.toJson(),
    };
  }
}
