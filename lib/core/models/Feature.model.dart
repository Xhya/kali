import 'package:kali/core/models/FeatureType.enum.dart';

class FeatureModel {
  final String id;
  final String name;
  final String? description;
  final FeatureTypeEnum type;
  bool isVoted;

  FeatureModel({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.isVoted,
  });

  factory FeatureModel.fromJson(Map<String, dynamic> json) {
    return FeatureModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      type: FeatureTypeEnum.fromText(json['type'] as String),
      isVoted: json['isVoted'] as bool,
    );
  }
}
