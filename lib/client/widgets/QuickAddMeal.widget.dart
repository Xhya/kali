import 'package:flutter/material.dart';
import 'package:kalori/client/states/quickAddMeal.state.dart';
import 'package:kalori/client/widgets/CustomButton.widget.dart';
import 'package:kalori/client/widgets/LoaderIcon.widget.dart';
import 'package:kalori/core/actions/nutriScore.actions.dart';
import 'package:kalori/core/domains/nutriScore.state.dart';
import 'package:kalori/core/services/Translation.service.dart';
import 'package:provider/provider.dart';

// onAddNewTodoItem() async {
//   todosState.setCreatingNewTodoItem(!todosState.creatingNewTodoItem);
// }

// validateNewItemName() async {
//   List<String> items = todosState.newItemName.split("\n");

//   todosState.setIsAddingItemLoading(true);
//   for (int i = 0; i < items.length; i++) {
//     var name = items[i];
//     ProductCategoryEnum? category = await aiService.getTodoCategory(name);
//     await todoItemService.createTodoItem(
//       name: name,
//       category: category,
//     );
//     reset();
//   }
//   todosState.setIsAddingItemLoading(true);
// }

// reset() async {
//   todosState.setCreatingNewTodoItem(false);
//   todosState.setNewItemName("");
// }

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
    String userMealText = context.watch<NutriScoreState>().userMealText.value;
    bool isInAddingMode =
        context.watch<QuickAddMealState>().isInAddingMode.value;
    bool isLoading = context.watch<QuickAddMealState>().isLoading.value;

    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: userMealText.isNotEmpty ? 8 : 16,
      ),
      child: Row(
        mainAxisAlignment:
            userMealText.isEmpty
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.end,
        children: [
          if (isInAddingMode)
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 12),
                child: TextField(
                  onChanged: (value) {
                    nutriScoreState.userMealText.value = value;
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
                                computeNutriScore(controller.text);
                              }
                            },
                            child: isLoading ? LoaderIcon() : Text(t('add')),
                          ),
                        SizedBox(width: 12),
                        GestureDetector(
                          onTap: () {
                            quickAddMealState.isInAddingMode.value = false;
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
                quickAddMealState.isInAddingMode.value = true;
              },
              buttonType: ButtonTypeEnum.filled,
            ),
        ],
      ),
    );
  }
}
