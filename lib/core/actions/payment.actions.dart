import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/Payment.service.dart';

Future<void> openPaymentBottomSheet(String subcriptionId) async {
  try {
    final clientSecret = await paymentService.createIntent(subcriptionId);

    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: 'Kali',
      ),
    );

    await Stripe.instance.presentPaymentSheet();
  } on StripeException catch (e, stack) {
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
