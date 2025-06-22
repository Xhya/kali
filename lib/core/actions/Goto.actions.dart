import 'package:kalori/core/domains/meal.state.dart';
import 'package:kalori/core/domains/nutriScore.state.dart';
import 'package:kalori/core/models/Meal.model.dart';
import 'package:kalori/core/services/Navigation.service.dart';

goToMealScreen(MealModel meal) {
  mealState.currentMeal.value = meal;
  nutriScoreState.currentNutriScore.value = meal.nutriScore;
  navigationService.navigateTo(ScreenEnum.meal);
}

goToMealsScreen() {
  navigationService.navigateTo(ScreenEnum.meals);
}
