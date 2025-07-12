import 'package:flutter/material.dart';
import 'package:kali/client/widgets/LoaderIcon.widget.dart';

class AsyncInitWidget extends StatefulWidget {
  const AsyncInitWidget({
    super.key,
    required this.child,
    this.initFunction,
    this.refreshData,
  });

  final Widget child;
  final Function? initFunction;
  final Function? refreshData;

  @override
  State<AsyncInitWidget> createState() => _AsyncInitWidgetState();
}

class _AsyncInitWidgetState extends State<AsyncInitWidget> {
  bool _init = false;

  @override
  Widget build(BuildContext context) {
    initData() async {
      if (_init == false) {
        await widget.initFunction?.call();
        setState(() => _init = true);
      }
    }

    return FutureBuilder<void>(
      future: initData(),
      builder: (context, AsyncSnapshot<void> snapshot) {
        if (_init == true) {
          if (widget.refreshData != null) {
            return RefreshIndicator(
              onRefresh: () async {
                await widget.refreshData!.call();
              },
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Container(child: widget.child),
                  )
                ],
              ),
            );
          } else {
            return widget.child;
          }
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: LoaderIcon());
          default:
            if (widget.refreshData != null) {
              return RefreshIndicator(
                onRefresh: () async {
                  await widget.refreshData!.call();
                },
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Container(child: widget.child),
                    )
                  ],
                ),
              );
            } else {
              return widget.child;
            }
        }
      },
    );
  }
}
