import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/services/Payment.service.dart';
import 'package:kali/core/states/subscription.state.dart';

Future<void> openPaymentBottomSheet(String subscriptionId) async {
  try {
    final subscriptionData = await paymentService.createIntent(subscriptionId);

    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        merchantDisplayName: 'Kali Diet',
        customerId: subscriptionData.customerId,
        customerEphemeralKeySecret: subscriptionData.customerEphemeralKeySecret,
        setupIntentClientSecret: subscriptionData.setupIntentClientSecret,
        style: ThemeMode.system,
        appearance: PaymentSheetAppearance(
          colors: PaymentSheetAppearanceColors(primary: style.text.green.color),
        ),
      ),
    );

    try {
      await Stripe.instance.presentPaymentSheet();
      subscriptionState.isPaymentLoading.value = true;
      await paymentService.createSubscription(subscriptionId);
      subscriptionState.isPaymentLoading.value = false;
      subscriptionState.paymentDone.value = true;
      await Future.delayed(const Duration(milliseconds: 2500));
      navigationService.closeBottomSheet();
      await Future.delayed(const Duration(seconds: 1));
      subscriptionState.paymentDone.value = false;
    } catch (e) {
      if (e is StripeException) {
        print('Erreur Stripe: ${e.error.localizedMessage}');
      } else {
        print('Erreur: $e');
      }
    }
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
