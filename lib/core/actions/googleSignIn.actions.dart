import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:kali/client/widgets/ValidateCode.widget.dart';
import 'package:kali/client/widgets/WelcomeBottomSheet.widget.dart';
import 'package:kali/core/services/Authentication.service.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/states/googleSignIn.state.dart';
import 'package:kali/environment.dart';

initGoogleSignIn() async {
  googleSignInState.signInGoogle.value = GoogleSignIn.instance;

  unawaited(
    googleSignInState.signInGoogle.value!
        .initialize(
          clientId: googleSignInClientId,
          serverClientId: googleSignInServerId,
        )
        .then((_) {
          googleSignInState.signInGoogle.value!.authenticationEvents
              .listen(_handleAuthenticationEvent)
              .onError((e) {
                errorService.notifyError(e: e);
              });

          googleSignInState.signInGoogle.value!
              .attemptLightweightAuthentication();
        }),
  );
}

signInWithGoogle() async {
  try {
    if (GoogleSignIn.instance.supportsAuthenticate()) {
      await GoogleSignIn.instance.authenticate();
    } else {
      errorService.notifyError(e: Exception("Google Sign-In not supported"));
    }
  } catch (e, stack) {
    errorService.notifyError(e: e, stack: stack);
  }
}

Future<void> _handleAuthenticationEvent(
  GoogleSignInAuthenticationEvent event,
) async {
  final GoogleSignInAccount? user = switch (event) {
    GoogleSignInAuthenticationEventSignIn() => event.user,
    GoogleSignInAuthenticationEventSignOut() => null,
  };

  List<String> scopes = <String>['openid', 'email', 'profile'];

  final GoogleSignInClientAuthorization? authorization = await user
      ?.authorizationClient
      .authorizationForScopes(scopes);

  if (user != null && authorization != null) {
    googleSignInState.email.value = user.email;
    googleSignInState.token.value = authorization.accessToken;
    _loginOrRegister();
  }
}

onRegisterWithGoogle() async {
  await authenticationService.registerWithGoogle(
    email: googleSignInState.email.value,
    googleToken: googleSignInState.token.value,
  );
  navigationService.navigateBack();
  await Future.delayed(const Duration(milliseconds: 100));
  navigationService.openBottomSheet(
    widget: WelcomeBottomSheet(
      child: ValidateCodeWidget(
        text: "Veuillez entrez le code que vous avez reçu par email",
      ),
    ),
  );
}

onLoginWithGoogle() async {
  await authenticationService.loginWithGoogle(
    email: googleSignInState.email.value,
    googleToken: googleSignInState.token.value,
  );
  navigationService.navigateTo(ScreenEnum.home);
}

_loginOrRegister() async {
  try {
    if (googleSignInState.action.value == 'login') {
      await onLoginWithGoogle();
    } else if (googleSignInState.action.value == 'register') {
      await onRegisterWithGoogle();
    }
  } catch (e, stack) {
    errorService.notifyError(e: e, stack: stack);
  }
}
