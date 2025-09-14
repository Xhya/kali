import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/core/states/subscription.state.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/widgets/CustomCard.widget.dart';
import 'package:kali/client/widgets/CustomInkwell.widget.dart';
import 'package:kali/core/services/Subscription.service.dart';

class AndroidSubscriptionsWidget extends StatefulWidget {
  const AndroidSubscriptionsWidget({super.key});

  @override
  State<AndroidSubscriptionsWidget> createState() =>
      _AndroidSubscriptionsWidgetState();
}

class _AndroidSubscriptionsWidgetState
    extends State<AndroidSubscriptionsWidget> {
  @override
  void initState() {
    Future<void> initStore() async {
      await subscriptionService.refreshSubscriptions();
    }

    initStore();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subscriptions = context.select(
      (SubscriptionState s) => s.subscriptions.value,
    );
    final selectedSubscriptionId = context.select(
      (SubscriptionState s) => s.selectedSubscriptionId.value,
    );

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          ...subscriptions.map(
            (subscription) => Padding(
              padding: EdgeInsets.only(bottom: 4),

              child: CustomInkwell(
                onTap: () {
                  subscriptionState.selectedSubscriptionId.value =
                      subscription.id;
                },
                child: CustomCard(
                  withBorder: selectedSubscriptionId == subscription.id,
                  padding: EdgeInsets.all(12),
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              subscription.title,
                              style: style.fontsize.md.merge(
                                style.text.neutral,
                              ),
                            ),
                            if (subscription.description.isNotEmpty)
                              Text(
                                subscription.description,
                                maxLines: 5,
                                style: style.fontsize.xs.merge(
                                  style.text.neutral,
                                ),
                              ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              subscription.price,
                              style: style.fontsize.sm
                                  .merge(style.text.neutral)
                                  .merge(style.fontweight.bold),
                            ),
                            // if (subscription.subamountText != null)
                            //   Text(
                            //     subscription.subamountText!,
                            //     style: style.fontsize.xs.merge(
                            //       style.text.neutralLight,
                            //     ),
                            //   ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
