import 'package:flutter/material.dart';
import 'package:kali/client/widgets/AnimatedLoading.widget.dart';
import 'package:kali/client/widgets/Congratulation.widget.dart';
import 'package:kali/client/widgets/CustomInkwell.widget.dart';
import 'package:kali/core/actions/payment.actions.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/services/Subscription.service.dart';
import 'package:kali/core/states/subscription.state.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/widgets/CustomCard.widget.dart';
import 'package:kali/core/states/Input.state.dart';

class SubscriptionWidget extends StatefulWidget {
  const SubscriptionWidget({super.key});

  @override
  State<SubscriptionWidget> createState() => _SubscriptionWidgetState();
}

class _SubscriptionWidgetState extends State<SubscriptionWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      inputState.reset();
    });

    init() async {
      await subscriptionService.refreshSubscriptions();
    }

    init();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isPaymentLoading = context.select(
      (SubscriptionState s) => s.isPaymentLoading.value,
    );
    bool paymentDone = context.select(
      (SubscriptionState s) => s.paymentDone.value,
    );
    final subscriptions = context.select(
      (SubscriptionState s) => s.subscriptions.value,
    );

    return Column(
      spacing: 12,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        if (!isPaymentLoading && !paymentDone)
          ...subscriptions.map(
            (subscription) => CustomInkwell(
              onTap: () {
                navigationService.context = context;
                openPaymentBottomSheet(subscription.id);
              },
              child: CustomCard(
                padding: EdgeInsets.all(12),
                height: 80,
                width: double.maxFinite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(subscription.name!),
                        Text(subscription.description!),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(subscription.amount!),
                        Text(subscription.recurring!),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        if (isPaymentLoading && !paymentDone)
          AnimatedLoadingWidget(title: "", subtitle: ""),
        if (!isPaymentLoading && paymentDone) CongratulationWidget(),
      ],
    );
  }
}
