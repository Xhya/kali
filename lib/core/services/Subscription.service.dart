import 'package:kali/core/domains/subscription.repository.dart';
import 'package:kali/core/states/subscription.state.dart';

final subscriptionService = SubscriptionService();

class SubscriptionService {
  final _subscriptionRepository = SubscriptionRepository();

  Future<void> refreshSubscriptions() async {
    subscriptionState.subscriptions.value = await _subscriptionRepository.getAll();
  }
}
