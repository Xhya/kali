import 'package:kali/core/models/Configuration.enum.dart';

class ConfigurationModel {
  final String id;
  final ConfigKeyEnum? key;
  final String? value;

  ConfigurationModel({
    required this.id,
    required this.key,
    required this.value,
  });

  factory ConfigurationModel.fromJson(Map<String, dynamic> json) {
    return ConfigurationModel(
      id: json['id'] as String,
      key: json['key'] != null ? ConfigKeyEnum.fromText(json['key']) : null,
      value: json['value'] != null ? json['value'] as String : null,
    );
  }
}
