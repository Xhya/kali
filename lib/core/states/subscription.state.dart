import 'package:flutter/material.dart';
import 'package:kali/core/models/Subscription.model.dart';

final subscriptionState = SubscriptionState();

class SubscriptionState extends ChangeNotifier {
  final subscriptions = ValueNotifier<List<SubscriptionModel>>([]);

  SubscriptionState() {
    subscriptions.addListener(notifyListeners);
  }

  @override
  void dispose() {
    subscriptions.dispose();
    super.dispose();
  }
}
