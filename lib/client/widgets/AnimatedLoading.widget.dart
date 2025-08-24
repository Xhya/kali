import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() => runApp(const AnimatedLoadingWidget());

class AnimatedLoadingWidget extends StatelessWidget {
  const AnimatedLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // ICI on définit l'écran d'accueil de l'app avec notre loader au centre
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: EmojiLoader(), // ← on affiche le loader ici
        ),
      ),
    );
  }
}

/// --- LE WIDGET DU LOADER ---
class EmojiLoader extends StatefulWidget {
  const EmojiLoader({super.key});

  @override
  State<EmojiLoader> createState() => _EmojiLoaderState();
}

class _EmojiLoaderState extends State<EmojiLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _currentIndex = 0;
  late Timer _emojiTimer;

  // Cycle fixe emoji + couleurs
  final List<String> _emojis = ["🥑", "🍚", "🥩", "⚖️"];
  final List<Color> _colors = [
    Colors.pinkAccent,
    Colors.amber,
    Colors.deepPurpleAccent,
    Colors.greenAccent,
  ];

  @override
  void initState() {
    super.initState();

    // Animation de rotation du spinner
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Changement d'emoji toutes les 0.8 s
    _emojiTimer = Timer.periodic(const Duration(milliseconds: 800), (timer) {
      if (!mounted) return;
      setState(() {
        _currentIndex = (_currentIndex + 1) % _emojis.length;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _emojiTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double size = 150;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Cercle spinner
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: _SpinnerPainter(
                  progress: _controller.value,
                  color: _colors[_currentIndex],
                ),
                size: const Size(size, size),
              );
            },
          ),

          // Emoji au centre avec petite transition
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder:
                (child, anim) => ScaleTransition(scale: anim, child: child),
            child: Text(
              _emojis[_currentIndex],
              key: ValueKey(_emojis[_currentIndex]),
              style: const TextStyle(fontSize: 50),
            ),
          ),
        ],
      ),
    );
  }
}

class _SpinnerPainter extends CustomPainter {
  final double progress; // 0 → 1 (tour complet)
  final Color color;

  _SpinnerPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 12.0;
    final radius = (size.width - strokeWidth) / 2;
    final center = Offset(size.width / 2, size.height / 2);

    // Anneau de fond
    final paintBg =
        Paint()
          ..color = Colors.black87
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke;

    // Arc animé
    final paintArc =
        Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, paintBg);

    // Arc coloré qui tourne
    final startAngle = progress * 2 * math.pi;
    const sweepAngle = math.pi * 1.2; // longueur de l’arc (ajuste si tu veux)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paintArc,
    );
  }

  @override
  bool shouldRepaint(_SpinnerPainter old) =>
      old.progress != progress || old.color != color;
}
