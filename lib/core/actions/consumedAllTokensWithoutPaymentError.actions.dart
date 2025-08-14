import 'package:kali/client/widgets/Register.widget.dart';
import 'package:kali/client/widgets/Subscriptions.widget.dart';
import 'package:kali/client/widgets/WelcomeBottomSheet.widget.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/states/user.state.dart';

consumedAllTokensWithoutPaymentError() async {
  if (userState.user.value?.email == null) {
    navigationService.openBottomSheet(
      widget: WelcomeBottomSheet(
        child: RegisterWidget(
          title: "Paye 🔥",
          subtitle: "Tu dois payer maintenant!",
        ),
      ),
    );
  } else {
    navigationService.openBottomSheet(
      widget: WelcomeBottomSheet(child: SubscriptionWidget()),
    );
  }
}
