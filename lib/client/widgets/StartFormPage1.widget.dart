import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/core/actions/startForm.actions.dart';
import 'package:kali/core/states/startForm.state.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/widgets/CustomInput.dart';

class StartFormPage1 extends StatefulWidget {
  const StartFormPage1({super.key});

  @override
  State<StartFormPage1> createState() => _StartFormPage1State();
}

class _StartFormPage1State extends State<StartFormPage1> {
  @override
  Widget build(BuildContext context) {
    String userName = context.select((StartFormState s) => s.userName.value);
    String leitmotiv = context.select((StartFormState s) => s.leitmotiv.value);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12),
            Text(
              "Faisons connaissance 👋🏼",
              style: style.text.neutral.merge(style.fontsize.lg),
            ),
            SizedBox(height: 4),
            Text(
              "Choisis ton pseudo et ton pourquoi. Il sera ton moteur au quotidien, ton guide quand tu en auras besoin.",
              style: style.text.neutral.merge(style.fontsize.xs),
            ),

            SizedBox(height: 44),

            CustomInput(
              title: "Ton nom d'utilisateur",
              content: userName,
              onChanged: (String value) {
                startFormState.userName.value = value;
              },
              placeholder: "Mama kitchen",
              suffixIcon: Icon(Icons.person),
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
            ),

            SizedBox(height: 32),

            CustomInput(
              title: "Ton leitmotiv",
              content: leitmotiv,
              onChanged: (String value) {
                startFormState.leitmotiv.value = value;
              },
              placeholder: "Je veux me prouver...",
              suffixIcon: Icon(Icons.edit),
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
              onSubmitted: (String value) {
                onClickNext();
              },
            ),
            SizedBox(height: 400),
          ],
        ),
      ),
    );
  }
}
