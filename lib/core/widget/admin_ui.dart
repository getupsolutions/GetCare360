import 'package:flutter/material.dart';

class AdminUi {
  static const Color brandPurple = Color(0xFF9C27B0);
  static const Color brandPurpleDark = Color(0xFF8E24AA);
  static const Color pageBg = Color(0xFFF3F4F8);

  static InputDecoration input(String hint, {IconData? prefixIcon}) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 18) : null,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFFE6E6E6)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFFE6E6E6)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: brandPurpleDark, width: 1.2),
      ),
    );
  }
}

class AdminCardShell extends StatelessWidget {
  final Widget child;
  const AdminCardShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(borderRadius: BorderRadius.circular(10), child: child),
    );
  }
}

class AdminPurpleHeader extends StatelessWidget {
  final String title;
  final Widget? right;

  const AdminPurpleHeader({super.key, required this.title, this.right});

  static const Color _brandPurple = Color(0xFF9C27B0);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _brandPurple,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: LayoutBuilder(
        builder: (context, c) {
          final narrow = c.maxWidth < 720;

          // ✅ If no right widget, just show title
          if (right == null) {
            return Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
              overflow: TextOverflow.ellipsis,
            );
          }

          // ✅ Narrow screen: stack (prevents Row overflow)
          if (narrow) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Align(alignment: Alignment.centerRight, child: right!),
              ],
            );
          }

          // ✅ Wide screen: row layout
          return Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 12),

              // ✅ CRITICAL: Flexible prevents overflow
              Flexible(
                child: Align(alignment: Alignment.centerRight, child: right!),
              ),
            ],
          );
        },
      ),
    );
  }
}

class AdminPillButton extends StatelessWidget {
  final String label;
  final Color bg;
  final IconData? icon;
  final VoidCallback onTap;
  final EdgeInsets padding;

  const AdminPillButton({
    super.key,
    required this.label,
    required this.bg,
    required this.onTap,
    this.icon,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16, color: Colors.white),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 12.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AdminSectionLabel extends StatelessWidget {
  final String text;
  const AdminSectionLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          color: Color(0xFF5A5A5A),
        ),
      ),
    );
  }
}
