import 'package:flutter/material.dart';

var errorService = ErrorService();

class ErrorService extends ChangeNotifier {
  notifyError(Object e) {
    print(e);
  }
}
