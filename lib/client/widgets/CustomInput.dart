import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/Utils/Input.decoration.dart';

class CustomInput extends StatefulWidget {
  const CustomInput({
    super.key,
    required this.onChanged,
    this.content,
    this.placeholder,
    this.suffixText,
    this.suffixIcon,
    this.inputFormatters,
    this.title,
    this.minLines = 1,
    this.maxLines = 1,
    this.textCapitalization = TextCapitalization.none,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.readonly = false,
  });

  final Function(String)? onChanged;
  final String? content;
  final String? placeholder;
  final String? suffixText;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final String? title;
  final int minLines;
  final int maxLines;
  final TextCapitalization textCapitalization;
  final String? errorText;
  final TextInputType keyboardType;
  final bool readonly;

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.content != null) {
      controller.text = widget.content!;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.title!,
              style: style.text.neutral.merge(style.fontsize.sm),
            ),
          ),
        Container(
          decoration: BoxDecoration(
            color: style.background.neutral.color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            controller: controller,
            onChanged: widget.onChanged,
            autofocus: false,
            style: style.text.greenDark,
            minLines: widget.minLines,
            maxLines: widget.maxLines,
            inputFormatters: widget.inputFormatters,
            cursorColor: style.text.greenDark.color,
            decoration: inputDecoration.copyWith(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              hintStyle: TextStyle(color: Colors.grey),
              hintText: widget.placeholder,
              suffixText: widget.suffixText,
              suffixIcon: widget.suffixIcon,
              errorText: widget.errorText,
            ),
            textCapitalization: widget.textCapitalization,
            keyboardType: widget.keyboardType,
            readOnly: widget.readonly,
          ),
        ),
      ],
    );
  }
}
