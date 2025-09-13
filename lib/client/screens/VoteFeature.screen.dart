// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:kali/client/widgets/LoaderIcon.widget.dart';
import 'package:kali/core/models/Feature.model.dart';
import 'package:provider/provider.dart';
import 'package:kali/core/domains/feature.service.dart';
import 'package:kali/core/states/feature.state.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:kali/client/layout/Base.scaffold.dart';

class VoteFeatureScreen extends StatefulWidget {
  const VoteFeatureScreen({super.key});

  @override
  State<VoteFeatureScreen> createState() => _VoteFeatureScreenState();
}

class _VoteFeatureScreenState extends State<VoteFeatureScreen> {
  WebViewController? mobileController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    init() async {
      await featureService.refreshFeatures();
    }

    init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<FeatureModel> features = context.select(
      (FeatureState s) => s.features.value,
    );
    bool isLoadingFeatures = context.select(
      (FeatureState s) => s.isLoadingFeatures.value,
    );

    return BaseScaffold(
      backButton: true,
      child: Column(
        children: [
          if (isLoadingFeatures) LoaderIcon(),

          if (!isLoadingFeatures)
            Expanded(
              child: ListView.separated(
                itemCount: features.length,
                separatorBuilder: (context, index) => SizedBox(height: 4),
                itemBuilder: (BuildContext context, int index) {
                  final feature = features[index];
                  return Text(feature.name);
                },
              ),
            ),
        ],
      ),
    );
  }
}
