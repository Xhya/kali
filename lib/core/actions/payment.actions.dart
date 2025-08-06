import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/Payment.service.dart';

Future<void> openPaymentBottomSheet(String subscriptionId) async {
  try {
    final subscriptionData = await paymentService.createSubscription(
      subscriptionId,
    );

    await Stripe.instance.initCustomerSheet(
      customerSheetInitParams: CustomerSheetInitParams(
        merchantDisplayName: 'Kali Diet',
        customerId: subscriptionData.customerId,
        customerEphemeralKeySecret: subscriptionData.customerEphemeralKeySecret,
      ),
    );

    await Stripe.instance.presentCustomerSheet();
  } on StripeException catch (e, stack) {
    print('Erreur de paiement ❌: $e');

    final failureCode = e.error.code;
    if (failureCode == FailureCode.Canceled) {
      print("Le paiement a été annulé par l'utilisateur.");
    } else {
      errorService.notifyError(e: e, stack: stack);
    }
  } catch (e, stack) {
    print('Erreur de paiement ❌: $e');
    errorService.notifyError(e: e, stack: stack);
  }
}
