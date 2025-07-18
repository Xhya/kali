import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/states/startForm.state.dart';
import 'package:kali/client/widgets/DateInput.widget.dart';
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
    String size = context.watch<StartFormState>().size.value;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12),
            Text(
              "Faisons un peu connaissance",
              style: style.text.neutral.merge(style.fontsize.lg),
            ),
            SizedBox(height: 16),

            CustomInput(
              content: size,
              onChanged: (String value) {},
              placeholder: "Ton nom",
              suffixIcon: Icon(Icons.monitor_weight_outlined),
            ),

            SizedBox(height: 32),

            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Ta date de naissance",
                style: style.text.neutral.merge(style.fontsize.sm),
              ),
            ),
            DateInputWidget(
              onUpdateDate: (String value) {
                // startFormState.birthdate.value = value;
              },
            ),

            SizedBox(height: 32),

            CustomInput(
              title: "Ton leitmotiv",
              content: size,
              onChanged: (String value) {},
              placeholder: "Un exemple de leitmotiv",
              suffixIcon: Icon(Icons.note_outlined),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}
