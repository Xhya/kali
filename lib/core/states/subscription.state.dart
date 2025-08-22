import 'package:flutter/material.dart';
import 'package:kali/core/models/Subscription.model.dart';

final subscriptionState = SubscriptionState();

class SubscriptionState extends ChangeNotifier {
  final isPaymentLoading = ValueNotifier<bool>(false);
  final paymentDone = ValueNotifier<bool>(false);
  final subscriptions = ValueNotifier<List<SubscriptionModel>>([]);

  SubscriptionState() {
    subscriptions.addListener(notifyListeners);
    isPaymentLoading.addListener(notifyListeners);
    paymentDone.addListener(notifyListeners);
  }

  @override
  void dispose() {
    subscriptions.dispose();
    isPaymentLoading.dispose();
    paymentDone.dispose();
    super.dispose();
  }
}
