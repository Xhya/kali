import 'package:kali/core/states/meal.state.dart';
import 'package:kali/core/states/nutriScore.state.dart';
import 'package:kali/core/models/Meal.model.dart';
import 'package:kali/core/services/Navigation.service.dart';

goToMealScreen(MealModel meal) {
  mealState.currentMeal.value = meal;
  nutriScoreState.currentNutriScore.value = meal.nutriScore;
  navigationService.navigateTo(ScreenEnum.meal);
}

goToMealsScreen() {
  navigationService.navigateTo(ScreenEnum.meals);
}

goToRegisterScreen() {
  navigationService.navigateTo(ScreenEnum.register);
}
