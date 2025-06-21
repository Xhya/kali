import 'package:flutter/material.dart';
import 'package:kalori/core/models/NutriScore.model.dart';
import 'package:provider/provider.dart';
import 'package:kalori/client/Style.service.dart';
import 'package:kalori/client/layout/Base.scaffold.dart';
import 'package:kalori/client/widgets/CustomButton.widget.dart';
import 'package:kalori/core/actions/nutriScore.actions.dart';
import 'package:kalori/core/domains/nutriScore.state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    NutriScore? nutriScore = context.watch<NutriScoreState>().nutriScore;

    return BaseScaffold(
      child: Container(
        color: style.background.color1.color,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your username',
              ),
            ),
            ButtonWidget(
              onPressed: () async {
                print(_controller.text);
                await computeNutriScore(_controller.text);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (nutriScore?.proteinAmount != null)
                  Column(
                    children: [
                      Text("Protéines"),
                      Text(nutriScore!.proteinAmount.toString()),
                    ],
                  ),
                if (nutriScore?.lipidAmount != null)
                  Column(
                    children: [
                      Text("Lipides"),
                      Text(nutriScore!.lipidAmount.toString()),
                    ],
                  ),
                if (nutriScore?.glucidAmount != null)
                  Column(
                    children: [
                      Text("Glucides"),
                      Text(nutriScore!.glucidAmount.toString()),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
