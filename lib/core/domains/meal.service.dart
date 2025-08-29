import 'package:dart_date/dart_date.dart';
import 'package:kali/core/domains/meal.repository.dart';
import 'package:kali/core/models/Meal.model.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/states/meal.state.dart';

class MealService {
  final MealRepository _mealRepository = MealRepository();

  refreshMeals() async {
    try {
      final List<MealModel> meals = await _mealRepository.getMeals();
      mealState.currentMeals.value =
          meals
              .where(
                (it) =>
                    it.date != null
                        ? it.date!.isSameDay(mealState.currentDate.value)
                        : false,
              )
              .toList()
              .cast<MealModel>();
    } catch (e, stack) {
      errorService.notifyError(e: e, stack: stack);
    }
  }

  addMeal({
    required String mealId,
    required MealPeriodEnum period,
    required DateTime? date,
  }) async {
    try {
      await _mealRepository.addMeal(mealId: mealId, period: period, date: date);
      await refreshMeals();
    } catch (e, stack) {
      errorService.notifyError(e: e, stack: stack);
    }
  }

  Future<MealModel?> computeMealNutriScore(String userText) async {
    return await _mealRepository.computeMealNutriScore(userText);
  }

  Future<void> deleteMeal(String mealId) async {
    return await _mealRepository.deleteMeal(mealId);
  }
}
