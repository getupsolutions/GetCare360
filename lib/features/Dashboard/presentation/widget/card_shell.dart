import 'package:flutter/material.dart';

class CardShell extends StatelessWidget {
  final Widget child;
  final double padding;

  const CardShell({required this.child, required this.padding});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 10,
      shadowColor: Colors.black.withOpacity(0.25),
      borderRadius: BorderRadius.circular(6),
      child: Padding(padding: EdgeInsets.all(padding), child: child),
    );
  }
}

/// Text logo (replace with Image.asset(...) if you have the real logo)
class GetupAiLogo extends StatelessWidget {
  const GetupAiLogo();

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: RichText(
        text: const TextSpan(
          style: TextStyle(
            fontSize: 54,
            fontWeight: FontWeight.w800,
            letterSpacing: -1,
          ),
          children: [
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
      ),
    );
  }
}
