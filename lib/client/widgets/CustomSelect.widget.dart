import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/CustomInput.dart';

class SelectOption {
  final String value;
  final String label;
  final Widget? icon;

  SelectOption({required this.value, required this.label, this.icon});
}

class CustomSelectWidget extends StatefulWidget {
  const CustomSelectWidget({
    super.key,
    required this.onChanged,
    required this.options,
    required this.selected,
  });

  final Function onChanged;
  final List<SelectOption> options;
  final SelectOption selected;

  @override
  State<CustomSelectWidget> createState() => _CustomSelectWidgetState();
}

class _CustomSelectWidgetState extends State<CustomSelectWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...widget.options.map((it) {
          final isSelected = widget.selected.value == it.value;
          final backgroundColor =
              isSelected
                  ? style.background.greenLight.color
                  : style.background.neutral.color;
          final borderColor =
              isSelected ? style.background.green.color! : Colors.transparent;
          final suffixIcon = isSelected ? Icon(Icons.check, size: 20) : null;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: borderColor, width: 2),
            ),
            child: TextField(
              readOnly: true,
              controller: TextEditingController(text: it.label),
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: it.icon,
                suffixIcon: suffixIcon,
              ),
            ),
          );
        }),
      ],
    );
  }
}
