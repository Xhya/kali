import 'package:kali/core/domains/nutriScore.repository.dart';
import 'package:kali/core/domains/user.repository.dart';
import 'package:kali/core/domains/userNutriscore.repository.dart';
import 'package:kali/core/models/NutriScore.model.dart';

final userService = UserService();

class UserService {
  final _userRepository = UserRepository();
  final _userNutriscoreRepository = UserNutriscoreRepository();

  Future<bool> canCompute() async {
    return await _userRepository.canCompute();
  }

  Future<NutriScore?> getPersonalNutriScore() async {
    return await _userNutriscoreRepository.getPersonalNutriScore();
  }

  Future<void> setPersonalNutriScore(NutriScore nutriScore) async {
    await _userNutriscoreRepository.setPersonalNutriScore(nutriScore.id!);
  }

  Future<NutriScore?> computePersonalNutriScore(
    PersonalNutriScoreFormData formData,
  ) async {
    return await _userNutriscoreRepository.computePersonalNutriScore(formData);
  }
}
