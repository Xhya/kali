import 'package:flutter/material.dart';
import 'package:kali/client/widgets/StoreSubscriptions.widget.dart';
import 'package:kali/client/widgets/AnimatedLoading.widget.dart';
import 'package:kali/client/widgets/Benefits.widget.dart';
import 'package:kali/client/widgets/Congratulation.widget.dart';
import 'package:kali/client/widgets/MainButton.widget.dart';
import 'package:kali/core/services/Subscription.service.dart';
import 'package:kali/core/states/subscription.state.dart';
import 'package:provider/provider.dart';
import 'package:kali/core/states/Input.state.dart';
import 'package:kali/client/Style.service.dart';

class SubscriptionWidget extends StatefulWidget {
  const SubscriptionWidget({super.key, required this.title});

  final String title;

  @override
  State<SubscriptionWidget> createState() => _SubscriptionWidgetState();
}

class _SubscriptionWidgetState extends State<SubscriptionWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      inputState.reset();
    });

    // init() async {
    //   await subscriptionService.refreshSubscriptions();
    // }
    // init();

    subscriptionState.selectedSubscriptionId.value = null;
    subscriptionState.isPaymentLoading.value = false;
    subscriptionState.isInitPaymentLoading.value = false;

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
    final selectedSubscriptionId = context.select(
      (SubscriptionState s) => s.selectedSubscriptionId.value,
    );
    final isInitPaymentLoading = context.select(
      (SubscriptionState s) => s.isInitPaymentLoading.value,
    );

    if (!isPaymentLoading && !paymentDone) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 32),
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: style.fontsize.lg
                .merge(style.text.neutral)
                .merge(style.fontweight.bold),
          ),
          SizedBox(height: 4),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Pourquoi continuer l'aventure avec Kali ?",
                      textAlign: TextAlign.center,
                      style: style.fontsize.sm.merge(style.text.neutral),
                    ),
                  ),

                  SizedBox(height: 32),

                  BenefitsWidget(),

                  SizedBox(height: 32),

                  StoreSubscriptionsWidget(),
                ],
              ),
            ),
          ),

          SizedBox(height: 32),

          Center(
            child: MainButtonWidget(
              onClick: () {
                //navigationService.context = context;
                //openPaymentBottomSheet();
                subscriptionService.buySubscription();
              },
              text: "s'abonner",
              iconWidget: Icon(Icons.arrow_forward, size: 20),
              disabled: selectedSubscriptionId == null,
              isLoading: isInitPaymentLoading,
            ),
          ),
        ],
      );
    }
    if (isPaymentLoading && !paymentDone) {
      return AnimatedLoadingWidget(
        title: "Paiement en cours",
        subtitle: "Plus que quelques secondes d'attente...",
      );
    }
    if (!isPaymentLoading && paymentDone) {
      return CongratulationWidget(
        child: Text(
          "🎉 Bienvenue dans l'aventure !",
          style: TextStyle(fontSize: 24),
        ),
      );
    }

    return SizedBox.shrink();
  }
}
