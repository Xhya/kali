import 'package:intl/intl.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  bool isValidDate() {
    final dateRegex = RegExp(
      r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/(\d{4})$',
    );
    return dateRegex.hasMatch(this);
  }

  DateTime? getDate() {
    final dateRegex = RegExp(
      r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/(\d{4})$',
    );

    if (dateRegex.hasMatch(this)) {
      return DateFormat('dd/MM/yyyy').parse(this);
    } else {
      return null;
    }
  }

  bool isValidEmail() {
    final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    return emailRegex.hasMatch(this);
  }
}
