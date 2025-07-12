import 'package:flutter/material.dart';
import 'package:kali/core/domains/topBanner.state.dart';
import 'package:provider/provider.dart';

class TopBannerWidget extends StatefulWidget {
  const TopBannerWidget({super.key, required this.child});

  final Widget child;

  @override
  State<TopBannerWidget> createState() => _TopBannerWidgetState();
}

class _TopBannerWidgetState extends State<TopBannerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isPhone = false;
  bool isTablet = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isPhone = MediaQuery.of(context).size.width <= 768;
        isTablet = MediaQuery.of(context).size.width > 425;
      });
    });
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final showTopBanner = context.select((TopBannerState s) => s.show.value);

    close() async {
      await _controller.reverse();
    }

    if (!showTopBanner && _animation.isCompleted) {
      close();
    }

    return SizeTransition(
      sizeFactor: _animation,
      axis: Axis.vertical,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
