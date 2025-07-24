import 'package:kali/core/domains/user.repository.dart';

final userService = UserService();

class UserService {
  final userRepository = UserRepository();

  Future<bool> canCompute() async {
    return await userRepository.canCompute();
  }
}
