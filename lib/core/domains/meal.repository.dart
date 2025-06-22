import 'package:kalori/core/domains/meal.data.dart';
import 'package:kalori/core/models/Meal.model.dart';

class MealRepository {
  Future<List<MealModel>> getMeals() async {
    return await mealData.getMeals();
  }

  Future<void> addMeal(MealModel meal) async {
    await mealData.addMeal(meal);
  }
}
