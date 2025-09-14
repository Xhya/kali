import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/states/subscription.state.dart';

final subscriptionService = SubscriptionService();

class SubscriptionService {
  final InAppPurchase iap = InAppPurchase.instance;

  Future<void> refreshSubscriptions() async {
    final bool available = await iap.isAvailable();
    if (!available) {
      return;
    }

    const Set<String> ids = {
      'premium_monthly',
      'promotional-sept-2025-premium-monthly',
    };
    final ProductDetailsResponse response = await iap.queryProductDetails(ids);
    if (response.notFoundIDs.isNotEmpty) {
      errorService.notifyError(e: "IDs not found: ${response.notFoundIDs}");
    }

    List<ProductDetails> products = response.productDetails;

    // print(products[0]);
    // print(products[0].currencyCode);
    // print(products[0].id);
    // print(products[0].description);
    // print(products[0].price);
    // print(products[0].rawPrice);
    // print(products[0].title);
    // print(products[0].price);

    subscriptionState.subscriptions.value = products;
  }

  void buySubscription() {
    final purchaseParam = PurchaseParam(
      productDetails: subscriptionState.subscriptions.value[0],
    );
    iap.buyNonConsumable(
      purchaseParam: purchaseParam,
    ); // ou buySubscription pour Android
  }
}
