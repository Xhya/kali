import 'package:kali/core/domains/payment.repository.dart';
import 'package:kali/core/models/CreateSubscription.model.dart';

final paymentService = PaymentService();

class PaymentService {
  final _paymentRepository = PaymentRepository();

  Future<String> createIntent(String subscriptionId) async {
    return await _paymentRepository.createIntent(subscriptionId);
  }

  Future<CreateSubscriptionModel> createSubscription(String subscriptionId) async {
    return await _paymentRepository.createSubscription(subscriptionId);
  }
}
