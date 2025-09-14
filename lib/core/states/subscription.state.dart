import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

final subscriptionState = SubscriptionState();

class SubscriptionState extends ChangeNotifier {
  final isInitPaymentLoading = ValueNotifier<bool>(false);
  final isPaymentLoading = ValueNotifier<bool>(false);
  final paymentDone = ValueNotifier<bool>(false);
  final subscriptions = ValueNotifier<List<ProductDetails>>([]);
  final selectedSubscriptionId = ValueNotifier<String?>(null);

  SubscriptionState() {
    subscriptions.addListener(notifyListeners);
    isPaymentLoading.addListener(notifyListeners);
    isInitPaymentLoading.addListener(notifyListeners);
    paymentDone.addListener(notifyListeners);
    selectedSubscriptionId.addListener(notifyListeners);
  }

  @override
  void dispose() {
    subscriptions.dispose();
    isPaymentLoading.dispose();
    isInitPaymentLoading.dispose();
    paymentDone.dispose();
    selectedSubscriptionId.dispose();
    super.dispose();
  }
}
