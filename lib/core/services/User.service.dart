import 'package:kali/core/domains/user.repository.dart';
import 'package:kali/core/models/NutriScore.model.dart';

final userService = UserService();

class UserService {
  final userRepository = UserRepository();

  Future<bool> canCompute() async {
    return await userRepository.canCompute();
  }

  Future<NutriScore?> getPersonalNutriScore() async {
    return await userRepository.getPersonalNutriScore();
  }

  Future<void> setPersonalNutriScore(NutriScore nutriScore) async {
    await userRepository.setPersonalNutriScore(nutriScore.id!);
  }
}
