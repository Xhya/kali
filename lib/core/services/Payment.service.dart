import 'package:kali/core/domains/payment.repository.dart';

final paymentService = PaymentService();

class PaymentService {
  final _paymentRepository = PaymentRepository();

  Future<String> createIntent() async {
    return await _paymentRepository.createIntent();
  }
}
