import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/Utils/Input.decoration.dart';
import 'package:kali/client/widgets/CustomCard.widget.dart';
import 'package:kali/core/states/editProfile.state.dart';

class MacroElementRow extends StatefulWidget {
  const MacroElementRow({
    super.key,
    required this.icon,
    required this.text,
    this.readonly = true,
  });

  final String icon;
  final String text;
  final bool readonly;

  @override
  State<MacroElementRow> createState() => _MacroElementRowState();
}

class _MacroElementRowState extends State<MacroElementRow> {
  final _controller = TextEditingController();
  @override
  void initState() {
    _controller.text = widget.text;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              "protéines",
              textAlign: TextAlign.start,
              style: style.text.neutral.merge(style.fontsize.sm),
            ),
          ),
          Expanded(
            child: TextField(
              enabled: !widget.readonly,
              controller: _controller,
              textAlign: TextAlign.end,
              style: style.text.neutral.merge(style.fontsize.sm),
              decoration: inputDecoration,
              onChanged:
                  widget.readonly
                      ? null
                      : (value) {
                        editProfileState.editingProteins.value = value;
                      },
            ),
          ),
        ],
      ),
    );
  }
}
