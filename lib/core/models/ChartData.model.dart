import 'package:kali/core/models/Weight.model.dart';
import 'package:kali/core/services/Datetime.extension.dart';

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final int y;

  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(json['x'] as String, (json['y'] as int));
  }

  factory ChartData.fromWeight(WeightModel weight) {
    return ChartData(weight.date.formateDate("yyyy-MM-dd"), weight.value);
  }
}
