import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kalori/client/states/quickAddMeal.state.dart';
import 'package:kalori/client/widgets/CustomButton.widget.dart';
import 'package:kalori/client/widgets/LoaderIcon.widget.dart';
import 'package:kalori/core/actions/nutriScore.actions.dart';
import 'package:kalori/core/services/Translation.service.dart';

onAddNewMeal() {
  quickAddMealState.isInAddingMode.value = true;
}

onCloseAddNewMeal() {
  quickAddMealState.isInAddingMode.value = false;
  quickAddMealState.userMealText.value = "";
}

onUpdateUserMealText(String value) {
  quickAddMealState.userMealText.value = value;
}

class QuickAddMealWidget extends StatefulWidget {
  const QuickAddMealWidget({super.key});

  @override
  State<QuickAddMealWidget> createState() => _QuickAddMealWidgetState();
}

class _QuickAddMealWidgetState extends State<QuickAddMealWidget> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String userMealText = context.watch<QuickAddMealState>().userMealText.value;
    bool isInAddingMode =
        context.watch<QuickAddMealState>().isInAddingMode.value;
    bool isLoading = context.watch<QuickAddMealState>().isLoading.value;

    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: userMealText.isNotEmpty ? 16 : 16,
      ),
      child: Row(
        mainAxisAlignment:
            userMealText.isNotEmpty
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.end,
        children: [
          if (isInAddingMode)
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 12),
                child: TextField(
                  controller: controller,
                  onChanged: (value) {
                    onUpdateUserMealText(value);
                  },
                  textCapitalization: TextCapitalization.sentences,
                  minLines: 1,
                  maxLines: 6,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: t('describe_your_meal'),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (userMealText.isNotEmpty)
                          GestureDetector(
                            onTap: () {
                              if (isInAddingMode) {
                                onAddMeal(controller.text);
                              }
                            },
                            child: isLoading ? LoaderIcon() : Text(t('add')),
                          ),
                        SizedBox(width: 12),
                        GestureDetector(
                          onTap: () {
                            onCloseAddNewMeal();
                          },
                          child: Icon(Icons.close),
                        ),
                        SizedBox(width: 12),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          if (!isInAddingMode)
            ButtonWidget(
              text: "+",
              onPressed: () async {
                onAddNewMeal();
              },
              buttonType: ButtonTypeEnum.filled,
            ),
        ],
      ),
    );
  }
}
