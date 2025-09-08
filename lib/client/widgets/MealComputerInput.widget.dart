import 'package:flutter/material.dart';
import 'package:kali/client/Utils/MaxCharactersCountFormatter.utils.dart';
import 'package:kali/client/widgets/CustomIcon.widget.dart';
import 'package:kali/client/widgets/CustomInput.dart';
import 'package:kali/core/states/Ai.state.dart';
import 'package:kali/core/states/configuration.state.dart';
import 'package:provider/provider.dart';

class MealComputerInput extends StatefulWidget {
  const MealComputerInput({
    super.key,
    required this.mealText,
    required this.onUpdate,
    required this.onCompute,
    this.isLoading = false,
    this.disabled = false,
    this.maxLines = 2,
  });

  final String mealText;
  final Function(String) onUpdate;
  final Function() onCompute;
  final bool isLoading;
  final bool disabled;
  final int maxLines;

  @override
  State<MealComputerInput> createState() => _MealComputerInputState();
}

class _MealComputerInputState extends State<MealComputerInput> {
  @override
  Widget build(BuildContext context) {
    bool aiNotUnderstandError = context.select(
      (AIState s) => s.aiNotUnderstandError.value,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      spacing: 8,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            child: Container(
              alignment: Alignment.center,
              child: CustomInput(
                content: widget.mealText,
                onChanged: (value) {
                  widget.onUpdate(value);
                },
                placeholder: "Quel est le menu du jour ?",
                inputFormatters: [
                  MaxCharactersCountFormatter(
                    maxLength: configurationState.maxCharacterCount.value,
                  ),
                ],
                minLines: 2,
                maxLines: widget.maxLines,
                textCapitalization: TextCapitalization.sentences,
                errorText:
                    aiNotUnderstandError ? 'Veuillez être plus précis' : null,
                maxLength: configurationState.maxCharacterCount.value,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                withSpeechToText: false,
              ),
            ),
          ),
        ),

        CustomIconWidget(
          icon: "assets/icons/calculette.svg",
          format: CustomIconFormat.svg,
          type: CustomIconType.filled,
          isLoading: widget.isLoading,
          onClick: () {
            widget.onCompute();
          },
          disabled: widget.disabled,
        ),
      ],
    );
    ;
  }
}
