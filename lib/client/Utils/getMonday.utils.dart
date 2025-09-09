DateTime getMonday(DateTime date) {
  // Dart, monday = 1, sunday = 7
  final int daysToSubtract = date.weekday - DateTime.monday;
  return date.subtract(Duration(days: daysToSubtract));
}
