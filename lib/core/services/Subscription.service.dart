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

    const Set<String> ids = {'premium_monthly', 'premium_annually'};
    final ProductDetailsResponse response = await iap.queryProductDetails(ids);
    if (response.notFoundIDs.isNotEmpty) {
      print("IDs not found: ${response.notFoundIDs}");
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
