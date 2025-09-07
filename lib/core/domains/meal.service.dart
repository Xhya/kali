import 'package:dart_date/dart_date.dart';
import 'package:kali/core/domains/meal.repository.dart';
import 'package:kali/core/models/Meal.model.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/states/meal.state.dart';

class MealService {
  final MealRepository _mealRepository = MealRepository();

  Future<void> refreshMeals() async {
    try {
      mealState.isLoadingDate.value = true;
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
    } finally {
      mealState.isLoadingDate.value = false;
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

  Future<MealModel?> computeMealNutriScore({
    required String userText,
    String? mealId,
  }) async {
    return await _mealRepository.computeMealNutriScore(
      userText: userText,
      mealId: mealId,
    );
  }

  Future<void> deleteMeal(String mealId) async {
    return await _mealRepository.deleteMeal(mealId);
  }
}
