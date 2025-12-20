import 'package:flutter/material.dart';
import 'package:getcare360/features/Login/presentation/widget/network_background.dart';

class Logo extends StatelessWidget {
  final double titleScale;
  const Logo({super.key, required this.titleScale});

  @override
  Widget build(BuildContext context) {
    final base = 46.0 * titleScale;
    final fontFamily = Theme.of(context).textTheme.bodyMedium?.fontFamily;

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          fontSize: base,
          fontWeight: FontWeight.w800,
          letterSpacing: -1,
          fontFamily: fontFamily,
        ),
        children: const [
          TextSpan(
            text: "getup",
            style: TextStyle(color: Color(0xFF6B6B6B)),
          ),
          TextSpan(
            text: "a",
            style: TextStyle(color: Color(0xFF8E24AA)),
          ),
          TextSpan(
            text: "i",
            style: TextStyle(color: Color(0xFFFF9800)),
          ),
        ],
      ),
    );
  }
}

/// ✅ Optimized network background
class NetworkBackground extends StatelessWidget {
  const NetworkBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: NetworkPainter.optimized(),
      child: const SizedBox.expand(),
    );
  }
}
