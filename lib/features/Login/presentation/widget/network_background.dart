import 'package:flutter/material.dart';
import 'dart:math';

class NetworkPainter extends CustomPainter {
  NetworkPainter._();

  // ✅ cache points per-size-key so we don’t regenerate on each paint
  static final Map<int, List<Offset>> _pointsCache = {};

  // tweak these values for density
  static const int _minPoints = 18;
  static const int _maxPoints = 60;
  static const double _dotRadius = 3.3;
  static const int _neighbors = 3;

  // fixed seed => stable background
  static const int _seed = 42;

  factory NetworkPainter.optimized() => NetworkPainter._();

  @override
  void paint(Canvas canvas, Size size) {
    // background
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = const Color(0xFFF8FAFF),
    );

    if (size.isEmpty) return;

    final key = _sizeKey(size);
    final points = _pointsCache[key] ??= _generatePoints(size);

    final linePaint = Paint()
      ..color = const Color(0xFFDFE7F5)
      ..strokeWidth = 1;

    final dotPaint = Paint()..color = const Color(0xFFDFE7F5);

    final maxDist = min(size.width, size.height) * 0.45;
    final maxDist2 = maxDist * maxDist;

    // ✅ connect each point to k nearest neighbors WITHOUT sorting all points
    for (int i = 0; i < points.length; i++) {
      final p = points[i];

      // keep k best (nearest) candidates
      final best = <_Neighbor>[];

      for (int j = 0; j < points.length; j++) {
        if (i == j) continue;

        final q = points[j];
        final dx = q.dx - p.dx;
        final dy = q.dy - p.dy;
        final d2 = dx * dx + dy * dy;

        // skip very far lines quickly
        if (d2 > maxDist2) continue;

        if (best.length < _neighbors) {
          best.add(_Neighbor(q, d2));
          if (best.length == _neighbors) {
            best.sort((a, b) => a.d2.compareTo(b.d2));
          }
        } else if (d2 < best.last.d2) {
          best[best.length - 1] = _Neighbor(q, d2);
          best.sort((a, b) => a.d2.compareTo(b.d2));
        }
      }

      for (final n in best) {
        canvas.drawLine(p, n.p, linePaint);
      }
    }

    // dots
    for (final p in points) {
      canvas.drawCircle(p, _dotRadius, dotPaint);
    }
  }

  static int _sizeKey(Size s) {
    // round to reduce cache fragmentation
    final w = s.width.round();
    final h = s.height.round();
    return (w << 16) ^ h;
  }

  static List<Offset> _generatePoints(Size size) {
    final rng = Random(_seed);

    final area = size.width * size.height;
    final count = (area / 45000)
        .clamp(_minPoints.toDouble(), _maxPoints.toDouble())
        .toInt();

    final points = List<Offset>.generate(
      count,
      (_) =>
          Offset(rng.nextDouble() * size.width, rng.nextDouble() * size.height),
      growable: false,
    );

    return points;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _Neighbor {
  final Offset p;
  final double d2;
  const _Neighbor(this.p, this.d2);
}
