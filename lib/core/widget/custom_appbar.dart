import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final double height;
  final Widget? leading;
  final Color backgroundColor;
  final Color titleColor;
  final bool centerTitle;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBack = true,
    this.onBack,
    this.actions,
    this.height = kToolbarHeight,
    this.leading,
    this.backgroundColor = Colors.white,
    this.titleColor = const Color(0xFF1F1F2D),
    this.centerTitle = false,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      color: backgroundColor,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: height,
          child: Row(
            children: [
              /// Leading / Back button
              if (showBack)
                IconButton(
                  tooltip: "Back",
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                  color: titleColor,
                  onPressed: onBack ?? () => Navigator.of(context).pop(),
                )
              else if (leading != null)
                leading!
              else
                const SizedBox(width: 16),

              /// Title
              Expanded(
                child: Align(
                  alignment: centerTitle
                      ? Alignment.center
                      : Alignment.centerLeft,
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: titleColor,
                    ),
                  ),
                ),
              ),

              /// Actions
              if (actions != null) ...actions!,
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}
