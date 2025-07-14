import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/states/quickAddMeal.state.dart';
import 'package:kali/client/widgets/CustomInkwell.widget.dart';
import 'package:kali/client/widgets/MainButton.widget.dart';
import 'package:kali/client/widgets/QuickAddMeal.widget.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/services/Translation.service.dart';
import 'package:kali/core/utils/computeMealPeriod.utils.dart';

onClickAddQuickMeal() {
  quickAddMealState.reset();
  quickAddMealState.chosenPeriod.value = computeMealPeriod(DateTime.now());
  navigationService.openBottomSheet(widget: QuickAddMealWidget());
}

class QuickAddMealButtonWidget extends StatefulWidget {
  const QuickAddMealButtonWidget({super.key});

  @override
  State<QuickAddMealButtonWidget> createState() => _MealPeriodTagWidgetState();
}

class _MealPeriodTagWidgetState extends State<QuickAddMealButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: style.background.grey.color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("🥳", style: TextStyle(fontSize: 24)),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: style.fontsize.xs.fontSize,
                        color: style.text.neutral.color,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: "Déjà "),
                        TextSpan(
                          text: "11 jours consécutifs",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Text("De suivi de repas", style: style.fontsize.xs),
                ],
              ),
              MainButtonWidget(
                onClick: () {
                  navigationService.context = context;
                  onClickAddQuickMeal();
                },
                iconWidget: Text("🍴"),
                text: "ajouter",
              ),
            ],
          ),
        ),
      ),
    );

    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CustomInkwell(
        onTap: () {
          navigationService.context = context;
          onClickAddQuickMeal();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(color: style.border.color.color1.color!),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: style.background.color2.color,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 12,
            children: [
              Icon(
                Icons.add,
                color: style.icon.color1.color,
                size: style.fontsize.lg.fontSize,
              ),
              Text(
                t("add_a_meal"),
                style: style.text.color2.merge(style.fontsize.md),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
