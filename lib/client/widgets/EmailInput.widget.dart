import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/widgets/CustomInput.dart';
import 'package:kali/core/states/Input.state.dart';

onUpdateInputEmail(String value) {
  inputState.email.value = value;
}

class EmailInputWidget extends StatefulWidget {
  const EmailInputWidget({super.key});

  @override
  State<EmailInputWidget> createState() => _EmailInputState();
}

class _EmailInputState extends State<EmailInputWidget> {
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
    String email = context.watch<InputState>().email.value;

    return CustomInput(
      content: email,
      onChanged: (value) {
        onUpdateInputEmail(value);
      },
      placeholder: "Email",
      suffixIcon: Icon(Icons.email_outlined),
    );
  }
}
