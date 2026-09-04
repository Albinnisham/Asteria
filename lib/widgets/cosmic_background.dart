import 'dart:math' as math;

import 'package:flutter/material.dart';

class CosmicBackground extends StatelessWidget {
  const CosmicBackground({required this.child, this.imageUrl, super.key});

  final Widget child;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF101D3C), Color(0xFF08152B), Color(0xFF061020)],
            ),
          ),
        ),
        if (imageUrl != null)
          Image.network(
            imageUrl!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const SizedBox.expand();
            },
          ),
        if (imageUrl != null)
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x22071125),
                  Color(0x99101A36),
                  Color(0xFF071225),
                ],
                stops: [0, 0.62, 1],
              ),
            ),
          ),
        Positioned(
          top: -150,
          right: -120,
          child: _Glow(color: const Color(0xFF7789ED).withValues(alpha: 0.14)),
        ),
        IgnorePointer(
          child: CustomPaint(painter: _StarPainter(), size: Size.infinite),
        ),
        child,
      ],
    );
  }
}

class _Glow extends StatelessWidget {
  const _Glow({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 350,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, color.withValues(alpha: 0)]),
      ),
    );
  }
}

class _StarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(1706);
    final paint = Paint();

    for (int index = 0; index < 75; index++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = 0.5 + random.nextDouble();

      paint.color = Colors.white.withValues(
        alpha: 0.2 + random.nextDouble() * 0.45,
      );

      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
