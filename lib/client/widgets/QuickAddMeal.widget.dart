import 'package:flutter/material.dart';
import 'package:kalori/client/Style.service.dart';
import 'package:kalori/core/services/Navigation.service.dart';
import 'package:provider/provider.dart';
import 'package:kalori/client/states/quickAddMeal.state.dart';
import 'package:kalori/client/widgets/LoaderIcon.widget.dart';
import 'package:kalori/core/actions/nutriScore.actions.dart';
import 'package:kalori/core/services/Translation.service.dart';

onClickCloseQuickAddMode() {
  navigationService.closeBottomSheet();
  quickAddMealState.userMealText.value = "";
}

onInputUpdateUserMealText(String value) {
  quickAddMealState.userMealText.value = value;
}

onClickAddMeal() {
  onAddMeal();
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
    bool isLoading = context.watch<QuickAddMealState>().isLoading.value;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 12),
              child: TextField(
                controller: controller,
                onChanged: (value) {
                  onInputUpdateUserMealText(value);
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
                            onClickAddMeal();
                          },
                          child:
                              isLoading
                                  ? LoaderIcon()
                                  : Text(
                                    t('add'),
                                    style: style.fontsize.sm.merge(
                                      style.text.color1,
                                    ),
                                  ),
                        ),
                      SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          onClickCloseQuickAddMode();
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
        ],
      ),
    );
  }
}
