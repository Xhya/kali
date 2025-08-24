import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/Utils/Input.decoration.dart';
import 'package:kali/client/Utils/OnlyNumbersFormatter.utils.dart';
import 'package:kali/client/widgets/CustomCard.widget.dart';

class MacroElementRow extends StatefulWidget {
  const MacroElementRow({
    super.key,
    required this.icon,
    required this.text,
    required this.amount,
    this.onUpdate,
  });

  final String icon;
  final String text;
  final String amount;
  final Function(String)? onUpdate;

  @override
  State<MacroElementRow> createState() => _MacroElementRowState();
}

class _MacroElementRowState extends State<MacroElementRow> {
  final _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = widget.amount;
    return CustomCard(
      padding: EdgeInsets.all(16),
      child: Row(
        spacing: 12,
        children: [
          Text(
            widget.icon,
            textAlign: TextAlign.start,
            style: style.text.green
                .merge(style.fontsize.md)
                .merge(style.fontweight.bold),
          ),

          Expanded(
            child: Text(
              widget.text,
              textAlign: TextAlign.start,
              style: style.text.neutral.merge(style.fontsize.sm),
            ),
          ),
          Expanded(
            child: TextField(
              enabled: widget.onUpdate != null,
              controller: _controller,
              textAlign: TextAlign.end,
              style: style.text.neutral.merge(style.fontsize.sm),
              decoration: inputDecoration,
              onChanged: widget.onUpdate,
              inputFormatters: [onlyNumbersFormatter()],
            ),
          ),
        ],
      ),
    );
  }
}
