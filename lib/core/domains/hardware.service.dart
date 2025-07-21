import 'package:kali/core/domains/hardware.repository.dart';
import 'package:kali/core/repository.provider.dart';

class HardwareService {
  final HardwareRepository hardwareRepository = get<HardwareRepository>();

  Future<String> getCurrentVersion() async {
    return hardwareRepository.getCurrentVersion();
  }
}
