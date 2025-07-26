import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/widgets/CustomInput.dart';
import 'package:kali/core/states/Input.state.dart';

onUpdateInputPassword(String value) {
  inputState.password.value = value;
}

class PasswordInputWidget extends StatefulWidget {
  const PasswordInputWidget({super.key});

  @override
  State<PasswordInputWidget> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInputWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String password = context.select((InputState s) => s.password.value);

    return CustomInput(
      content: password,
      onChanged: (value) {
        onUpdateInputPassword(value);
      },
      placeholder: "Password",
      suffixIcon: Icon(Icons.key_outlined),
    );
  }
}
