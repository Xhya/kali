import 'package:kali/client/widgets/Register.widget.dart';
import 'package:kali/client/widgets/Subscriptions.widget.dart';
import 'package:kali/client/widgets/WelcomeBottomSheet.widget.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/services/Subscription.service.dart';
import 'package:kali/core/states/Input.state.dart';
import 'package:kali/core/states/Texts.state.dart';
import 'package:kali/core/states/user.state.dart';

handleCantCompute() async {
  try {
    inputState.reset();
    if (userState.user.value?.emailVerified() != true) {
      navigationService.openBottomSheet(
        widget: WelcomeBottomSheet(
          child: RegisterWidget(
            title: "Inscris toi 🔥",
            subtitle: textsState.needPaymentText.value,
          ),
        ),
      );
    } else if (true) {
      await subscriptionService.refreshSubscriptions();
      navigationService.openBottomSheet(
        widget: WelcomeBottomSheet(child: SubscriptionWidget()),
      );
    }
  } catch (e, stack) {
    errorService.notifyError(e: e, stack: stack);
  }
}
