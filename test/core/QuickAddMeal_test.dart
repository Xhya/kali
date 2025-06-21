import 'package:flutter_test/flutter_test.dart';
import 'package:kalori/client/states/quickAddMeal.state.dart';
import 'package:kalori/client/widgets/QuickAddMeal.widget.dart';
import 'package:kalori/core/domains/nutriScore.state.dart';

void main() {
  setUp(() async {
    // todoItemData.reset();
    // await todoItemService.refreshTodoItems();
  });

  test('should turn to addingMode', () async {
    expect(quickAddMealState.isInAddingMode.value, false);
    onAddNewMeal();
    expect(quickAddMealState.isInAddingMode.value, true);
    onCloseAddNewMeal();
    expect(quickAddMealState.isInAddingMode.value, false);
    onAddNewMeal();
    expect(quickAddMealState.isInAddingMode.value, true);
    onUpdateUserMealText("Pizza");
    expect(nutriScoreState.userMealText.value, "Pizza");
    onCloseAddNewMeal();
    expect(nutriScoreState.userMealText.value.isEmpty, true);
  });

  test('can select all items', () async {
    // todosState.setNewItemName("Pain");
    // await validateNewItemName();
    // todosState.setNewItemName("Tomate");
    // await validateNewItemName();
    // todosState.setNewItemName("Oignon");
    // await validateNewItemName();

    // // Ensure there are multiple todo items
    // expect(todosState.todos.length, greaterThan(1));

    // // Call the onSelectAll function to select all items
    // todosState.onSelectAll(true);

    // // Verify all items are marked as done
    // expect(todosState.todos.every((todo) => todo.isDone == true), true);

    // // Call the onSelectAll function to deselect all items
    // todosState.onSelectAll(false);

    // // Verify all items are marked as not done
    // expect(todosState.todos.every((todo) => todo.isDone == false), true);
  });
}
