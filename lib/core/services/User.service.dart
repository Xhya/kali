import 'package:kali/core/domains/nutriScore.repository.dart';
import 'package:kali/core/domains/user.repository.dart';
import 'package:kali/core/domains/userNutriscore.repository.dart';
import 'package:kali/core/models/EditUser.formdata.dart';
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:kali/core/models/User.model.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/states/user.state.dart';

final userService = UserService();

class UserService {
  final _userRepository = UserRepository();
  final _userNutriscoreRepository = UserNutriscoreRepository();

  Future<void> refreshUser() async {
    try {
      User? user = await _userRepository.refreshUser();
      userState.user.value = user;
    } catch (e, stack) {
      errorService.notifyError(e: e, stack: stack, show: false);
    }
  }

  Future<bool> canCompute() async {
    return await _userRepository.canCompute();
  }

  Future<void> setPersonalNutriScore(NutriScore nutriScore) async {
    await _userNutriscoreRepository.setPersonalNutriScore(nutriScore.id!);
  }

  Future<NutriScore?> computePersonalNutriScore(
    PersonalNutriScoreFormData formData,
  ) async {
    return await _userNutriscoreRepository.computePersonalNutriScore(formData);
  }

  Future<User> saveProfile(EditUserFormData formData) async {
    return await _userRepository.saveProfile(formData);
  }
}
