import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kali/client/Style.service.dart';

class CustomInput extends StatefulWidget {
  const CustomInput({
    super.key,
    required this.onChanged,
    this.content,
    this.placeholder,
    this.suffixText,
    this.suffixIcon,
    this.inputFormatters,
  });

  final Function onChanged;
  final String? content;
  final String? placeholder;
  final String? suffixText;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;

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
            maxLines: 1,
            minLines: 1,
            inputFormatters: widget.inputFormatters,
            cursorColor: style.text.greenDark.color,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(16),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 16,
              ),
              filled: true,
              fillColor: style.background.neutral.color,
              focusColor: style.background.green.color,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: style.text.greenDark.color!),
                borderRadius: BorderRadius.circular(16),
              ),
              labelText: widget.placeholder,
              labelStyle: style.text.greenDark,
              suffixText: widget.suffixText,
              suffixStyle: style.text.greenDark,
              suffixIcon: widget.suffixIcon,
            ),
          ),
        ),
      ],
    );
  }
}
