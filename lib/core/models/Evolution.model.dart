import 'package:kali/core/models/ChartData.model.dart';

class EvolutionModel {
  final List<ChartData> calories;
  final List<ChartData> glucids;
  final List<ChartData> proteins;
  final List<ChartData> lipids;

  EvolutionModel({
    required this.calories,
    required this.proteins,
    required this.lipids,
    required this.glucids,
  });

  factory EvolutionModel.fromJson(Map<String, dynamic> json) {
    return EvolutionModel(
      calories:
          (json['calories'] as List)
              .map((item) => ChartData.fromJson(item))
              .toList(),
      glucids:
          (json['glucids'] as List)
              .map((item) => ChartData.fromJson(item))
              .toList(),
      proteins:
          (json['proteins'] as List)
              .map((item) => ChartData.fromJson(item))
              .toList(),
      lipids:
          (json['lipids'] as List)
              .map((item) => ChartData.fromJson(item))
              .toList(),
    );
  }
}
