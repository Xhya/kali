import 'package:kali/repository/nutriScore.repository.dart';
import 'package:kali/repository/user.repository.dart';
import 'package:kali/repository/userNutriscore.repository.dart';
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
      final show = errorService.currentResponseError?.statusCode != 401;
      errorService.notifyError(e: e, stack: stack, show: show);
      rethrow;
    }
  }

  Future<void> deconnectUser() async {
    try {
      await _userRepository.deconnectUser();
      userState.user.value = null;
    } catch (e, stack) {
      errorService.notifyError(e: e, stack: stack);
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

  Future<void> deleteAccount() async {
    return await _userRepository.deleteAccount();
  }
}
