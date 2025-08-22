import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/CustomInkwell.widget.dart';

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
  final SelectOption? selected;

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
          final isSelected = widget.selected?.value == it.value;
          final backgroundColor =
              isSelected
                  ? style.background.greenLight.color
                  : style.background.neutral.color;
          final borderColor =
              isSelected ? style.background.green.color! : Colors.transparent;
          final suffixIcon = isSelected ? Icon(Icons.check, size: 20) : null;
          return CustomInkwell(
            onTap: () {
              HapticFeedback.vibrate();
              widget.onChanged(it);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: borderColor, width: 2),
              ),
              child: Row(
                children: [
                  if (it.icon != null) it.icon!,
                  const SizedBox(width: 4),
                  Expanded(child: Text(it.label)),
                  if (suffixIcon != null) suffixIcon,
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
