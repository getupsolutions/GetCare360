import 'package:flutter/material.dart';

/// Logo similar to "getupai" (text-based so it works everywhere)
class Logo extends StatelessWidget {
  final double titleScale;
  const Logo({required this.titleScale});

  @override
  Widget build(BuildContext context) {
    final base = 46.0 * titleScale;
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          fontSize: base,
          fontWeight: FontWeight.w800,
          letterSpacing: -1,
          fontFamily: Theme.of(context).textTheme.bodyMedium?.fontFamily,
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
