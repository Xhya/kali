import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/Utils/MaxCharactersCountFormatter.utils.dart';
import 'package:kali/client/widgets/CustomCard.widget.dart';
import 'package:kali/client/widgets/CustomIcon.widget.dart';
import 'package:kali/client/widgets/CustomInkwell.widget.dart';
import 'package:kali/client/widgets/CustomInput.dart';
import 'package:kali/client/widgets/Debouncer.widget.dart';
import 'package:kali/core/domains/nutriscore.service.dart';
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:kali/core/states/Ai.state.dart';
import 'package:kali/core/states/configuration.state.dart';
import 'package:kali/core/states/nutriScore.state.dart';
import 'package:kali/core/states/quickAddMeal.state.dart';

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
  final debouncer = Debouncer(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    bool aiNotUnderstandError = context.select(
      (AIState s) => s.aiNotUnderstandError.value,
    );
    List<NutriScore> searchNutriscores = context.select(
      (NutriScoreState s) => s.searchNutriscores.value,
    );

    return Stack(
      children: [
        Column(
          children: [
            Row(
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

                          debouncer.run(() async {
                            if (value.length > 3) {
                              nutriscoreService.searchNutriscore(text: value);
                            }
                          });
                        },
                        placeholder: "Quel est le menu du jour ?",
                        inputFormatters: [
                          MaxCharactersCountFormatter(
                            maxLength:
                                configurationState.maxCharacterCount.value,
                          ),
                        ],
                        minLines: 2,
                        maxLines: widget.maxLines,
                        textCapitalization: TextCapitalization.sentences,
                        errorText:
                            aiNotUnderstandError
                                ? 'Veuillez être plus précis'
                                : null,
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
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                "Pour obtenir des calculs précis, veuillez être le plus précis possible.",
                style: style.text.neutralLight.merge(style.fontsize.xxs),
              ),
            ),
          ],
        ),
        if (searchNutriscores.isNotEmpty)
          Positioned(
            top: 95,
            left: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomCard(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                  width: 350,
                  child: Column(
                    children: List.generate(searchNutriscores.length, (index) {
                      final nutriscore = searchNutriscores[index];
                      return CustomInkwell(
                        onTap: () {
                          quickAddMealState.nutriscore.value = nutriscore;
                          quickAddMealState.userMealText.value =
                              nutriscore.userText ?? "";
                          quickAddMealState.computed.value = true;
                          nutriScoreState.searchNutriscores.value = [];
                        },
                        child: Text(nutriscore.userText ?? ""),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
