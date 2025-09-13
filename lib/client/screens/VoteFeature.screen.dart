// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/Congratulation.widget.dart';
import 'package:kali/client/widgets/CustomCard.widget.dart';
import 'package:kali/client/widgets/LoaderIcon.widget.dart';
import 'package:kali/client/widgets/WelcomeBottomSheet.widget.dart';
import 'package:kali/core/models/Feature.model.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:provider/provider.dart';
import 'package:kali/core/domains/feature.service.dart';
import 'package:kali/core/states/feature.state.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:kali/client/layout/Base.scaffold.dart';

Future<void> onClickVote(String featureId, bool isVoted) async {
  try {
    await featureService.voteFeature(featureId);
    if (!isVoted) {
      navigationService.openBottomSheet(
        widget: WelcomeBottomSheet(
          child: CongratulationWidget(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "🎉 Merci pour ton vote ! 🎉",
                  style: style.fontsize.lg.merge(style.fontweight.bold),
                ),
                Text(
                  "Nous prendrons en compte ton avis pour nos futurs développements !",
                  style: style.fontsize.md,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }
  } catch (e, stack) {
    errorService.notifyError(e: e, stack: stack);
  }
}

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
      try {
        featureState.isLoadingFeatures.value = true;
        await featureService.refreshFeatures();
      } catch (e, stack) {
        errorService.notifyError(e: e, stack: stack);
      } finally {
        featureState.isLoadingFeatures.value = false;
      }
    }

    init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<FeatureModel> features = context.watch<FeatureState>().features.value;
    bool isLoadingFeatures = context.select(
      (FeatureState s) => s.isLoadingFeatures.value,
    );

    return BaseScaffold(
      backButton: true,
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            if (isLoadingFeatures)
              Container(
                height: 200,
                alignment: Alignment.center,
                child: LoaderIcon(),
              ),

            if (!isLoadingFeatures)
              Expanded(
                child: ListView.separated(
                  itemCount: features.length,
                  separatorBuilder: (context, index) => SizedBox(height: 4),
                  itemBuilder: (BuildContext context, int index) {
                    final feature = features[index];
                    final icon =
                        feature.isVoted
                            ? Icon(Icons.favorite, color: Colors.red)
                            : Icon(Icons.favorite_border);

                    return CustomCard(
                      padding: EdgeInsets.only(left: 16, bottom: 12),
                      child: Column(
                        spacing: 8,
                        children: [
                          Row(
                            spacing: 16,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 12),
                                  child: Text(
                                    feature.name,
                                    style: style.fontsize.md.merge(
                                      style.fontweight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 8, top: 4),
                                child: IconButton(
                                  onPressed: () {
                                    onClickVote(feature.id, feature.isVoted);
                                  },
                                  icon: icon,
                                ),
                              ),
                            ],
                          ),

                          if (feature.description != null)
                            Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: Text(
                                feature.description!,
                                style: style.fontsize.sm,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
