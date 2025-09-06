class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final int y;

  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(json['x'] as String, (json['y'] as int));
  }
}
