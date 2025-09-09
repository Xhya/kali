import 'package:dart_date/dart_date.dart';
import 'package:kali/core/domains/meal.repository.dart';
import 'package:kali/core/models/Meal.model.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/states/date.state.dart';
import 'package:kali/core/states/meal.state.dart';

class MealService {
  final MealRepository _mealRepository = MealRepository();

  Future<void> refreshMeals() async {
    try {
      mealState.isLoadingDate.value = true;
      mealState.allMeals.value = await _mealRepository.getMeals();
      mealState.currentMeals.value =
          mealState.allMeals.value
              .where(
                (it) =>
                    it.date != null
                        ? it.date!.isSameDay(dateState.currentDate.value)
                        : false,
              )
              .toList()
              .cast<MealModel>();
    } catch (e, stack) {
      errorService.notifyError(e: e, stack: stack);
    } finally {
      mealState.isLoadingDate.value = false;
    }
  }

  Future<void> createMeal({
    required MealPeriodEnum period,
    required DateTime date,
    required String nutriscoreId,
  }) async {
    try {
      await _mealRepository.createMeal(
        period: period,
        date: date,
        nutriscoreId: nutriscoreId,
      );
      await refreshMeals();
    } catch (e, stack) {
      errorService.notifyError(e: e, stack: stack);
    }
  }

  Future<void> updateMeal({
    required String mealId,
    MealPeriodEnum? period,
    DateTime? date,
    String? userText,
    String? nutriscoreId,
  }) async {
    try {
      await _mealRepository.updateMeal(
        mealId: mealId,
        period: period,
        date: date,
        userText: userText,
        nutriscoreId: nutriscoreId,
      );
      await refreshMeals();
    } catch (e, stack) {
      errorService.notifyError(e: e, stack: stack);
    }
  }

  Future<void> deleteMeal(String mealId) async {
    return await _mealRepository.deleteMeal(mealId);
  }
}
