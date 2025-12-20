import 'package:flutter/material.dart';
import 'package:getcare360/core/constant/app_color.dart';

class UniversalDrawerStyle {
  final double width;
  final Gradient? backgroundGradient;
  final Color? backgroundColor;
  final EdgeInsets listPadding;
  final Widget? footer;

  final Color selectedTileColor;
  final Color expandedGroupColor;
  final Color textColor;
  final Color mutedTextColor;
  final Color iconColor;

  const UniversalDrawerStyle({
    this.width = 280,
    this.backgroundGradient,
    this.backgroundColor,
    this.listPadding = const EdgeInsets.only(bottom: 16),
    this.footer,
    this.selectedTileColor = Colors.transparent,
    this.expandedGroupColor = Colors.transparent,
    this.textColor = Colors.white,
    this.mutedTextColor = Colors.white70,
    this.iconColor = Colors.white,
  });

  /// Your old drawer look (purple gradient + same opacities)
  factory UniversalDrawerStyle.purple() => UniversalDrawerStyle(
    backgroundGradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppColors.drawerBg1, AppColors.drawerBg2],
    ),
    selectedTileColor: AppColors.drawerSelectedTile,
    expandedGroupColor: AppColors.drawerExpandedGroup,
    textColor: AppColors.drawerText,
    mutedTextColor: AppColors.drawerTextMuted,
    iconColor: AppColors.drawerIcon,
  );
}

/// ------------------------------------------------------------
/// Models
/// ------------------------------------------------------------
class NavItem {
  final String title;
  final IconData? icon;
  final String routeKey; // use this to switch body content
  final List<NavItem> children;

  const NavItem({
    required this.title,
    required this.routeKey,
    this.icon,
    this.children = const [],
  });

  bool get hasChildren => children.isNotEmpty;
}

/// ------------------------------------------------------------
/// Universal Reusable Drawer / Sidebar
/// ------------------------------------------------------------
class UniversalCustomDrawer extends StatelessWidget {
  final String selectedKey;
  final ValueChanged<String> onSelect;
  final List<NavItem> items;

  /// Pass any widget you want as header (logo, org switcher, profile, etc.)
  final Widget Function(BuildContext context)? headerBuilder;

  /// Optional title/subtitle convenience (if you don’t want a custom header widget)
  final String? title;
  final String? subtitle;
  final Widget? headerTrailing;

  final UniversalDrawerStyle style;
  final bool useSafeArea;

  const UniversalCustomDrawer({
    super.key,
    required this.selectedKey,
    required this.onSelect,
    required this.items,
    this.headerBuilder,
    this.title,
    this.subtitle,
    this.headerTrailing,
    this.style = const UniversalDrawerStyle(),
    this.useSafeArea = true,
  });

  @override
  Widget build(BuildContext context) {
    final header =
        headerBuilder?.call(context) ??
        _DefaultDrawerHeader(
          title: title ?? "",
          subtitle: subtitle,
          trailing: headerTrailing,
          textColor: style.textColor,
          mutedTextColor: style.mutedTextColor,
        );

    final container = Container(
      width: style.width,
      decoration: BoxDecoration(
        gradient: style.backgroundGradient,
        color: style.backgroundGradient == null ? style.backgroundColor : null,
      ),
      child: Column(
        children: [
          header,
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              padding: style.listPadding,
              children: items
                  .map(
                    (e) => _NavNode(
                      item: e,
                      selectedKey: selectedKey,
                      onSelect: onSelect,
                      depth: 0,
                      style: style,
                    ),
                  )
                  .toList(),
            ),
          ),
          if (style.footer != null) style.footer!,
        ],
      ),
    );

    return useSafeArea ? SafeArea(child: container) : container;
  }
}

/// ------------------------------------------------------------
/// Default header (used only if headerBuilder is not provided)
/// ------------------------------------------------------------
class _DefaultDrawerHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Color textColor;
  final Color mutedTextColor;

  const _DefaultDrawerHeader({
    required this.title,
    this.subtitle,
    this.trailing,
    required this.textColor,
    required this.mutedTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: AppColors.drawerHeaderLogoBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.blur_on, color: textColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 22,
                    letterSpacing: 0.2,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: mutedTextColor, fontSize: 12),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

class _NavNode extends StatefulWidget {
  final NavItem item;
  final String selectedKey;
  final ValueChanged<String> onSelect;
  final int depth;
  final UniversalDrawerStyle style;

  const _NavNode({
    required this.item,
    required this.selectedKey,
    required this.onSelect,
    required this.depth,
    required this.style,
  });

  @override
  State<_NavNode> createState() => _NavNodeState();
}

class _NavNodeState extends State<_NavNode> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = _containsKey(widget.item, widget.selectedKey);
  }

  @override
  void didUpdateWidget(covariant _NavNode oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selectedKey != widget.selectedKey) {
      final shouldExpand = _containsKey(widget.item, widget.selectedKey);

      // Auto-open if selection moved inside this group
      if (shouldExpand && !_isExpanded) {
        // ✅ defer state change
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) setState(() => _isExpanded = true);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final style = widget.style;

    final bool isSelected = widget.selectedKey == item.routeKey;
    final EdgeInsets indent = EdgeInsets.only(
      left: 12.0 + (widget.depth * 14.0),
    );

    // ---------------- Leaf ----------------
    if (!item.hasChildren) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Material(
          color: isSelected ? style.selectedTileColor : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () => widget.onSelect(item.routeKey),
            child: Padding(
              padding: indent.add(
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              ),
              child: Row(
                children: [
                  if (item.icon != null && widget.depth == 0) ...[
                    Icon(item.icon, color: style.iconColor, size: 20),
                    const SizedBox(width: 10),
                  ] else if (widget.depth > 0) ...[
                    Icon(Icons.circle, color: style.mutedTextColor, size: 6),
                    const SizedBox(width: 10),
                  ],
                  Expanded(
                    child: Text(
                      item.title,
                      style: TextStyle(
                        color: style.textColor,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // ---------------- Group (Expandable) ----------------
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        child: Container(
          decoration: BoxDecoration(
            color: _isExpanded ? style.expandedGroupColor : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ExpansionTile(
            key: PageStorageKey(item.routeKey),
            initiallyExpanded: _isExpanded,

            // ✅ IMPORTANT: defer the update to avoid "setState during build"
            onExpansionChanged: (v) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) return;
                setState(() => _isExpanded = v);
              });
            },

            tilePadding: indent.add(const EdgeInsets.symmetric(horizontal: 10)),
            childrenPadding: const EdgeInsets.only(bottom: 6),

            trailing: Icon(
              _isExpanded ? Icons.keyboard_arrow_down : Icons.chevron_right,
              color: style.iconColor,
            ),

            title: Row(
              children: [
                if (item.icon != null && widget.depth == 0) ...[
                  Icon(item.icon, color: style.iconColor, size: 20),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: Text(
                    item.title,
                    style: TextStyle(
                      color: style.textColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),

            children: item.children
                .map(
                  (c) => _NavNode(
                    item: c,
                    selectedKey: widget.selectedKey,
                    onSelect: widget.onSelect,
                    depth: widget.depth + 1,
                    style: style,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  bool _containsKey(NavItem root, String key) {
    if (root.routeKey == key) return true;
    for (final c in root.children) {
      if (_containsKey(c, key)) return true;
    }
    return false;
  }
}
