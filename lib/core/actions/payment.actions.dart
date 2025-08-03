import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:kali/core/services/Payment.service.dart';

Future<void> openPaymentBottomSheet(BuildContext context) async {
  try {
    final clientSecret = await paymentService.createIntent(
      "2428ee4e-1a22-4b5c-909b-b47023ce0ff2",
    );

    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: 'Kali',
      ),
    );

    await Stripe.instance.presentPaymentSheet();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Paiement réussi 🎉")));
  } catch (e) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Erreur paiement : $e")));
    print('Erreur de paiement ❌: $e');
  }
}
