import 'package:flutter/material.dart';
import 'package:kali/core/services/Payment.service.dart';

class StripePaymentWidget extends StatefulWidget {
  const StripePaymentWidget({super.key});

  @override
  State<StripePaymentWidget> createState() => _StripePaymentWidgetState();
}

class _StripePaymentWidgetState extends State<StripePaymentWidget> {
  @override
  void initState() {
    paymentService.createIntent();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text("TOTO");
  }
}
