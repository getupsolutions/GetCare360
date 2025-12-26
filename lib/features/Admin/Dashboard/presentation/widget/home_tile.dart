import 'package:flutter/material.dart';

class HomeTile extends StatelessWidget {
  final Color bg;
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? titleColor;

  const HomeTile({
    required this.bg,
    required this.icon,
    required this.title,
    required this.onTap,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: onTap,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 26, color: Colors.black),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: titleColor ?? Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
