import 'package:kali/core/domains/payment.repository.dart';
import 'package:kali/core/models/CreateSubscription.model.dart';

final paymentService = PaymentService();

class PaymentService {
  final _paymentRepository = PaymentRepository();

  Future<CreateSubscriptionModel> createIntent(String subscriptionId) async {
    return await _paymentRepository.createIntent(subscriptionId);
  }

  Future<void> createSubscription(String subscriptionId) async {
    await _paymentRepository.createSubscription(subscriptionId);
  }
}
