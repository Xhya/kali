// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:kali/client/layout/Base.scaffold.dart';
import 'package:kali/core/services/Navigation.service.dart';

class WebviewScreen extends StatefulWidget {
  const WebviewScreen({super.key});

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  WebViewController? mobileController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    final url = navigationService.url;
    print(url);
    if (url != null) {
      mobileController =
          WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setNavigationDelegate(
              NavigationDelegate(
                onPageStarted: (url) {
                  print("start");
                  setState(() {
                    isLoading = true;
                  });
                },
                onPageFinished: (url) {
                  print("finished");

                  setState(() {
                    isLoading = false;
                  });
                },
              ),
            )
            ..loadRequest(Uri.parse(url));
    }
  }

  @override
  void dispose() {
    mobileController?.clearCache();
    mobileController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backButton: true,
      child: Stack(
        children: [
          if (mobileController != null)
            WebViewWidget(controller: mobileController!),
          if (isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
