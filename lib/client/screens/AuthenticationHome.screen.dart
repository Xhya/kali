import 'package:flutter/material.dart';
import 'package:kali/core/domains/user.repository.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/states/register.state.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/widgets/CustomButton.widget.dart';
import 'package:kali/client/widgets/CustomInput.dart';
import 'package:kali/client/layout/Base.scaffold.dart';

onUpdateInputEmail(String value) {
  registerState.email.value = value;
}

onUpdateInputPassword(String value) {
  registerState.password.value = value;
}

onSubmitRegisterUser() async {
  try {
    await UserRepository().register(
      email: registerState.email.value,
      password: registerState.password.value,
    );
  } catch (e, stack) {
    errorService.notifyError(e: e, stack: stack);
  }
}

class AuthenticationHomeScreen extends StatefulWidget {
  const AuthenticationHomeScreen({super.key});

  @override
  State<AuthenticationHomeScreen> createState() =>
      _AuthenticationHomeScreenState();
}

class _AuthenticationHomeScreenState extends State<AuthenticationHomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String email = context.watch<RegisterState>().email.value;
    String password = context.watch<RegisterState>().password.value;

    return BaseScaffold(
      child: Container(
        color: Colors.blue,
        child: Column(
          children: [
            SizedBox(height: 8),
            CustomInput(
              content: email,
              onChanged: (value) {
                onUpdateInputEmail(value);
              },
              placeholder: "email",
            ),
            SizedBox(height: 8),
            CustomInput(
              content: password,
              onChanged: (value) {
                onUpdateInputPassword(value);
              },
              placeholder: "password",
            ),
            SizedBox(height: 8),
            ButtonWidget(
              onPressed: () {
                onSubmitRegisterUser();
              },
              needConnection: true,
            ),
          ],
        ),
      ),
    );
  }
}
