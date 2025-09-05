import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/BottomButton.widget.dart';
import 'package:kali/client/widgets/CustomIcon.widget.dart';
import 'package:kali/client/widgets/MainButton.widget.dart';
import 'package:kali/client/widgets/QuickAddMeal.widget.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/User.service.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/states/quickAddMeal.state.dart';
import 'package:kali/core/utils/computeMealPeriod.utils.dart';

Future<void> onClickAddQuickMeal() async {
  try {
    quickAddMealState.isAddingLoading.value = true;
    if (await userService.canCompute()) {
      quickAddMealState.computed.value = false;
      quickAddMealState.reset();
      quickAddMealState.chosenPeriod.value = computeMealPeriod(DateTime.now());
      navigationService.openBottomSheet(widget: QuickAddMealWidget());
    }
  } catch (e, stack) {
    errorService.notifyError(e: e, stack: stack);
  } finally {
    quickAddMealState.isAddingLoading.value = false;
  }
}

class QuickAddMealButtonWidget extends StatefulWidget {
  const QuickAddMealButtonWidget({super.key});

  @override
  State<QuickAddMealButtonWidget> createState() => _MealPeriodTagWidgetState();
}

class _MealPeriodTagWidgetState extends State<QuickAddMealButtonWidget> {
  @override
  initState() {
    super.initState();
    quickAddMealState.isAddingLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    bool isAddingLoading = context.select(
      (QuickAddMealState s) => s.isAddingLoading.value,
    );

    return MainButtonWidget(
      onClick: () {
        navigationService.context = context;
        onClickAddQuickMeal();
      },
      text: "ajouter",
      iconWidget: CustomIconWidget(
        format: CustomIconFormat.svg,
        icon: "assets/icons/fourchette.svg",
      ),
      isLoading: isAddingLoading,
    );

    return BottomButtonWidget(
      left:
          false
              ? Column(
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
              )
              : null,
      buttonText: "🍴 ajouter",
      onClick: () {
        navigationService.context = context;
        onClickAddQuickMeal();
      },
    );
  }
}
