import 'dart:async';
import 'dart:io';

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
          clientId:
              Platform.operatingSystem == 'ios'
                  ? googleSignInClientIdIos
                  : googleSignInClientIdAndroid,
          serverClientId: googleSignInServerId,
        )
  );
}

signInWithGoogle() async {
  try {
    if (googleSignInState.signInGoogle.value!.supportsAuthenticate()) {
      GoogleSignInServerAuthorization? authServer = await googleSignInState
          .signInGoogle
          .value
          ?.authorizationClient
          .authorizeServer(<String>['openid', 'email', 'profile']);

      GoogleSignInAccount? account =
          await googleSignInState.signInGoogle.value!
              .attemptLightweightAuthentication();

      googleSignInState.email.value = account?.email ?? "";
      googleSignInState.authCode.value = authServer?.serverAuthCode ?? "";

      if (googleSignInState.authCode.value.isNotEmpty &&
          googleSignInState.email.value.isNotEmpty) {
        _loginOrRegister();
      }
    } else {
      errorService.notifyError(e: Exception("Google Sign-In not supported"));
    }
  } catch (e, stack) {
    if (e is GoogleSignInException) {
      await googleSignInState.signInGoogle.value!.signOut();
      await googleSignInState.signInGoogle.value!.disconnect();
    }
    errorService.notifyError(e: e, stack: stack);
  }
}

onRegisterWithGoogle() async {
  await authenticationService.registerWithGoogle(
    email: googleSignInState.email.value,
    authCode: googleSignInState.authCode.value,
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
    authCode: googleSignInState.authCode.value,
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
