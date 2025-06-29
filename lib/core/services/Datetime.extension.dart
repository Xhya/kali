import 'package:intl/intl.dart';
import 'package:kalori/core/services/Locale.service.dart';

extension DateTimeExtension on DateTime {
  String formateDate(String pattern) {
    var locale = "en";

    switch (localeService.currentLocaleEnum) {
      case LocaleEnum.fr:
        locale = "FR_fr";
      case LocaleEnum.en:
        locale = "en";
    }

    return DateFormat(pattern, locale).format(this);
  }
}
