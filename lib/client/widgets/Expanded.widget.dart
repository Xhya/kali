import 'package:flutter/material.dart';

class ExpandedWidget extends StatefulWidget {
  const ExpandedWidget({super.key, required this.child, this.height = 220});

  final Widget child;
  final int height;

  @override
  State<ExpandedWidget> createState() => _ExpandedWidgetState();
}

class _ExpandedWidgetState extends State<ExpandedWidget> {
  var isExpanded = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        isExpanded = true;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
        alignment: Alignment.center,
        width: isExpanded ? double.maxFinite : 0,
        height: isExpanded ? widget.height.toDouble() : 0,
        padding: EdgeInsets.symmetric(vertical: 4),
        child: widget.child,
      ),
    );
  }
}
