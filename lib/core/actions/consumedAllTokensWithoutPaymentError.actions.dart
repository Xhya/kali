import 'package:kali/client/widgets/Register.widget.dart';
import 'package:kali/client/widgets/Subscriptions.widget.dart';
import 'package:kali/client/widgets/WelcomeBottomSheet.widget.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/states/user.state.dart';
import 'package:kali/core/states/register.state.dart';

Future<void> consumedAllTokensWithoutPaymentError() async {
  if (userState.user.value?.emailVerifiedAt == null) {
    registerState.error.value = null;
    navigationService.openBottomSheet(
      widget: WelcomeBottomSheet(
        child: RegisterWidget(
          title: "Abonne-toi",
          subtitle: "Abonne-toi pour continuer à profiter de l'application.",
        ),
      ),
    );
  } else {
    navigationService.openBottomSheet(
      widget: WelcomeBottomSheet(
        child: SubscriptionWidget(title: "Ton essai est maintenant terminé"),
      ),
    );
  }
}
