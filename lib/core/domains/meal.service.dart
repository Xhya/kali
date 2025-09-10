import 'package:dart_date/dart_date.dart';
import 'package:kali/client/Utils/getMonday.utils.dart';
import 'package:kali/core/domains/meal.repository.dart';
import 'package:kali/core/models/Meal.model.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/states/date.state.dart';
import 'package:kali/core/states/meal.state.dart';

class MealService {
  final MealRepository _mealRepository = MealRepository();

  Future<void> refreshMeals({bool force = false}) async {
    bool refresh =
        force ||
        dateState.currentDate.value.isBefore(
          dateState.currentStartDate.value,
        ) ||
        dateState.currentDate.value.isAfter(dateState.currentEndDate);

    if (refresh) {
      try {
        mealState.isLoadingAmount.value += 1;
        dateState.currentStartDate.value = getMonday(
          dateState.currentDate.value,
        );

        mealState.weekMeals.value = await _mealRepository.getMeals(
          startDate: dateState.currentStartDate.value,
          endDate: dateState.currentEndDate,
        );
      } catch (e, stack) {
        errorService.notifyError(e: e, stack: stack);
      } finally {
        if (mealState.isLoadingAmount.value > 0) {
          mealState.isLoadingAmount.value -= 1;
        }
      }
    }

    mealState.currentDayMeals.value =
        mealState.weekMeals.value
            .where(
              (it) =>
                  it.date != null
                      ? it.date!.isSameDay(dateState.currentDate.value)
                      : false,
            )
            .toList()
            .cast<MealModel>();
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
      await refreshMeals(force: true);
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
      await refreshMeals(force: true);
    } catch (e, stack) {
      errorService.notifyError(e: e, stack: stack);
    }
  }

  Future<void> deleteMeal(String mealId) async {
    return await _mealRepository.deleteMeal(mealId);
  }
}
