import 'package:flutter/material.dart';

var errorService = ErrorService();

class ErrorService extends ChangeNotifier {
  String? error;

  notifyError(Object e) {
    print(e);
    error = e.toString().isNotEmpty ? e.toString() : "Une erreur est survenue";
    notifyListeners();
  }
}
