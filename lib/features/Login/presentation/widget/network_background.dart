import 'dart:math';

import 'package:flutter/material.dart';

/// Light network background (dots + connecting lines)
class NetworkBackground extends StatelessWidget {
  const NetworkBackground();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: NetworkPainter(),
      child: const SizedBox.expand(),
    );
  }
}

class NetworkPainter extends CustomPainter {
  final Random _rng = Random(42);

  @override
  void paint(Canvas canvas, Size size) {
    // Background tint
    final bg = Paint()..color = const Color(0xFFF8FAFF);
    canvas.drawRect(Offset.zero & size, bg);

    // Generate responsive points based on area
    final area = size.width * size.height;
    final count = (area / 45000).clamp(18, 60).toInt();

    final points = <Offset>[];
    for (int i = 0; i < count; i++) {
      points.add(
        Offset(_rng.nextDouble() * size.width, _rng.nextDouble() * size.height),
      );
    }

    final linePaint = Paint()
      ..color = const Color(0xFFDFE7F5)
      ..strokeWidth = 1;

    final dotPaint = Paint()..color = const Color(0xFFDFE7F5);

    // Connect each point to a few nearest neighbors
    for (int i = 0; i < points.length; i++) {
      final p = points[i];
      final neighbors =
          points.map((q) => MapEntry(q, (q - p).distance)).toList()
            ..sort((a, b) => a.value.compareTo(b.value));

      // connect to 2-3 closest (skip itself at index 0)
      final links = min(3, neighbors.length - 1);
      for (int k = 1; k <= links; k++) {
        final q = neighbors[k].key;
        final d = neighbors[k].value;

        // only draw reasonable distances to avoid clutter
        if (d < min(size.width, size.height) * 0.45) {
          canvas.drawLine(p, q, linePaint);
        }
      }
    }

    // Draw dots
    for (final p in points) {
      canvas.drawCircle(p, 3.5, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
