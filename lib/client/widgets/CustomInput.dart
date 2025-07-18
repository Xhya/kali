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
    this.maxLines = 1,
  });

  final Function onChanged;
  final String? content;
  final String? placeholder;
  final String? suffixText;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final String? title;
  final int maxLines;

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
            onChanged: (value) {
              widget.onChanged(value);
            },
            style: style.text.greenDark,
            maxLines: widget.maxLines,
            minLines: 1,
            inputFormatters: widget.inputFormatters,
            cursorColor: style.text.greenDark.color,
            decoration: inputDecoration.copyWith(
              hintText: widget.placeholder,
              suffixText: widget.suffixText,
              suffixIcon: widget.suffixIcon,
            ),
          ),
        ),
      ],
    );
  }
}
