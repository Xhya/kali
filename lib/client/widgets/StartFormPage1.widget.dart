import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
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
    String userName = context.watch<StartFormState>().userName.value;
    String leitmotiv = context.watch<StartFormState>().leitmotiv.value;

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
              "Choisis ton pseudo et partage ton pourquoi. C'est ton point de départ.",
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
              suffixIcon: Icon(Icons.monitor_weight_outlined),
            ),

            SizedBox(height: 32),

            CustomInput(
              title: "Ton leitmotiv",
              content: leitmotiv,
              onChanged: (String value) {
                startFormState.leitmotiv.value = value;
              },
              placeholder:
                  "Je veux changer pour moi, pour me prouver que j'en suis capable.",
              suffixIcon: Icon(Icons.note_outlined),
              minLines: 3,
              maxLines: 4,
            ),
          ],
        ),
      ),
    );
  }
}
