class WeightModel {
  final String id;
  final double value;
  final DateTime date;

  WeightModel({required this.id, required this.value, required this.date});

  factory WeightModel.fromJson(Map<String, dynamic> json) {
    return WeightModel(
      id: json['id'] as String,
      value: double.parse(json['weight']),
      date: DateTime.parse(json['date']).toLocal(),
    );
  }
}
