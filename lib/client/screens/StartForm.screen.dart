import 'package:flutter/material.dart';
import 'package:kalori/client/widgets/CustomButton.widget.dart';
import 'package:kalori/client/widgets/QuickAddMeal.widget.dart';
import 'package:kalori/client/layout/Base.scaffold.dart';
import 'package:kalori/core/services/Translation.service.dart';

onUpdateSize(String value) {}

onUpdateWeight(String value) {}

onUpdateAge(String value) {}

class StartFormScreen extends StatefulWidget {
  const StartFormScreen({super.key});

  @override
  State<StartFormScreen> createState() => _StartFormScreenState();
}

class _StartFormScreenState extends State<StartFormScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              TextField(
                                onChanged: (value) {
                                  onUpdateUserMealText(value);
                                },
                                maxLines: 1,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: t("size"),
                                  suffixText: "cm",
                                ),
                              ),
                              SizedBox(height: 32),
                              TextField(
                                onChanged: (value) {
                                  onUpdateUserMealText(value);
                                },
                                maxLines: 1,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: t("weight"),
                                  suffixText: "kg",
                                ),
                              ),
                              SizedBox(height: 32),
                              TextField(
                                onChanged: (value) {
                                  onUpdateUserMealText(value);
                                },
                                maxLines: 1,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: t("age"),
                                  suffixText: "ans",
                                ),
                              ),
                              SizedBox(height: 32),
                            ],
                          ),
                        ),
                        ButtonWidget(onPressed: () {}, fullWidth: true),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
