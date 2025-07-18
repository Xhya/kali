import 'package:flutter/material.dart';
import 'package:kali/client/Utils/DateInputFormatter.utils.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/Utils/Input.decoration.dart';

class DateInputWidget extends StatefulWidget {
  const DateInputWidget({super.key, required this.onUpdateDate});

  final Function onUpdateDate;

  @override
  State<DateInputWidget> createState() => _DateInputWidgetState();
}

class _DateInputWidgetState extends State<DateInputWidget> {
  String? birthdateErrorText;

  void updateBirthDate(String newValue) {
    try {
      final dateRegex = RegExp(
        r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/(\d{4})$',
      );
      if (newValue.length > 7 && !dateRegex.hasMatch(newValue)) {
        setState(() {
          birthdateErrorText = "Format invalide (jj/mm/yyyy)";
        });
        return;
      } else {
        setState(() {
          birthdateErrorText = null;
        });
      }

      final splitted = newValue.split("/");

      if (splitted.isNotEmpty) {
        final firstTwoDigits = splitted[0];
        if (int.parse(firstTwoDigits) < 1 || int.parse(firstTwoDigits) > 31) {
          setState(() {
            birthdateErrorText = "Les jours doivent etre entre 01 et 31";
          });
        }
      }

      if (splitted.length > 1) {
        final secondTwoDigits = splitted[1];
        if (int.parse(secondTwoDigits) < 1 || int.parse(secondTwoDigits) > 12) {
          setState(() {
            birthdateErrorText = "Les mois doivent etre entre 01 et 12";
          });
        }
      }

      if (splitted.length > 2) {
        final thirdTwoDigits = splitted[2];
        if (int.parse(thirdTwoDigits) < 1900 ||
            int.parse(thirdTwoDigits) > DateTime.now().year) {
          setState(() {
            birthdateErrorText =
                "Les années doivent etre entre 1900 et ${DateTime.now().year}";
          });
        }
      }

      widget.onUpdateDate(newValue);
      // ignore: empty_catches
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: style.background.neutral.color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        onChanged: (value) => updateBirthDate(value),
        autofocus: true,
        inputFormatters: [DateTextFormatter()],
        decoration: inputDecoration.copyWith(
          errorText: birthdateErrorText,
          hintText: "jj/mm/aaaa",
          suffixIcon: Icon(Icons.calendar_today),
        ),
        keyboardType: TextInputType.datetime,
      ),
    );
  }
}
