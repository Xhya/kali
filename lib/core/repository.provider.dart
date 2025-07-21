import 'package:kali/core/domains/hardware.repository.dart';
import 'package:kali/core/domains/hardware.repository.mock.dart';
import 'package:kali/environment.dart';

get<T>() {
  final getMock = isInTestEnv;

  if (!getMock) {
    switch (T) {
      case HardwareRepository _:
        return HardwareRepository();
    }
  } else {
    switch (T) {
      case HardwareRepository _:
        return HardwareRepositoryMock();
    }
  }
}
