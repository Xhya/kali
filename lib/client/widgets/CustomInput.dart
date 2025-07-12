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
        TextFormField(
          controller: controller,
          onChanged: (value) {
            widget.onChanged(value);
          },
          style: style.text.color2,
          maxLines: 1,
          minLines: 1,
          inputFormatters: widget.inputFormatters,
          cursorColor: style.text.color2.color,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: style.text.color2.color!),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: style.text.color2.color!),
            ),
            labelText: widget.placeholder,
            labelStyle: style.text.color2,
            suffixText: widget.suffixText,
            suffixStyle: style.text.color2,
            suffixIcon: widget.suffixIcon,
          ),
        ),
      ],
    );
  }
}
