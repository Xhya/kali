import 'package:kali/core/domains/hardware.repository.dart';

class HardwareRepositoryMock implements HardwareRepository {
  @override
  Future<String> getCurrentVersion() {
    return Future.value("1.0.0");
  }

}
