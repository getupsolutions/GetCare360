import 'package:flutter/material.dart';

class AppTopBar extends StatelessWidget {
  final VoidCallback? onMenuTap;
  final String userLabel;

  const AppTopBar({
    super.key,
    required this.onMenuTap,
    required this.userLabel,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    // Show less stuff on smaller screens
    final showFullscreen = w >= 520;
    final showUserChip = w >= 420; // hide chip on very small widths

    return Material(
      color: Colors.white.withOpacity(0.92),
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
        ),
        child: Row(
          children: [
            if (onMenuTap != null)
              IconButton(
                onPressed: onMenuTap,
                icon: const Icon(Icons.menu),
                tooltip: "Menu",
              ),
            const SizedBox(width: 6),

            // Brand (shrinkable)
            const _Brand(),

            const Spacer(),

            if (showFullscreen)
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.fullscreen),
                tooltip: "Fullscreen",
              ),

            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none),
              tooltip: "Notifications",
            ),

            if (showUserChip) ...[
              const SizedBox(width: 6),
              // Make the chip shrinkable + ellipsis
              Flexible(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: _UserChip(userLabel: userLabel),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Text(
          "getup",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        Text(
          "ai",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Color(0xFFDB2777),
          ),
        ),
      ],
    );
  }
}

class _UserChip extends StatelessWidget {
  final String userLabel;
  const _UserChip({required this.userLabel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 22,
            width: 22,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          // IMPORTANT: never allow unbounded width in a Row => use Flexible
          Flexible(
            child: Text(
              userLabel,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
