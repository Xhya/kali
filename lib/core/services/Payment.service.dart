import 'package:kali/core/domains/payment.repository.dart';

final paymentService = PaymentService();

class PaymentService {
  final _paymentRepository = PaymentRepository();

  Future<String> createIntent(String subscriptionId) async {
    return await _paymentRepository.createIntent(subscriptionId);
  }
}
