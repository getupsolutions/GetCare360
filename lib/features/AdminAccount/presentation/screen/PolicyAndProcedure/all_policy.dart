import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/custom_appbar.dart';

class PolicyItem {
  final String id;
  final String title;
  final String fileLabel;

  const PolicyItem({
    required this.id,
    required this.title,
    this.fileLabel = "View File",
  });
}

class AdminAllPolicyAndProcedurePage extends StatefulWidget {
  final VoidCallback? onAddNew;
  final void Function(PolicyItem item)? onView;
  final void Function(PolicyItem item)? onEdit;
  final void Function(PolicyItem item)? onDelete;

  const AdminAllPolicyAndProcedurePage({
    super.key,
    this.onAddNew,
    this.onView,
    this.onEdit,
    this.onDelete,
  });

  @override
  State<AdminAllPolicyAndProcedurePage> createState() =>
      _AdminAllPolicyAndProcedurePageState();
}

class _AdminAllPolicyAndProcedurePageState
    extends State<AdminAllPolicyAndProcedurePage> {
  static const Color brandPurple = Color(0xFF9C27B0);
  static const Color pageBg = Color(0xFFF3F4F8);

  final _searchCtrl = TextEditingController();
  String _query = "";

  final List<PolicyItem> _items = const [
    PolicyItem(id: "1", title: "Fair Work Information Statement"),
    PolicyItem(id: "2", title: "Emergency Contact information"),
    PolicyItem(id: "3", title: "Postion Description - Support worker"),
    PolicyItem(id: "4", title: "Statement of Commitment to Child Safety"),
    PolicyItem(id: "5", title: "Feed back form"),
    PolicyItem(id: "6", title: "The Child Safe Standards"),
    PolicyItem(id: "7", title: "Staff hand book NDIS/Nursing agency"),
    PolicyItem(id: "8", title: "Incident Form"),
    PolicyItem(id: "9", title: "Vehicle Standards Information"),
    PolicyItem(id: "10", title: "Medication Incident Form"),
    PolicyItem(id: "11", title: "Child safe Policy"),
    PolicyItem(id: "12", title: "Policy & Procedure"),
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<PolicyItem> get _filtered {
    if (_query.trim().isEmpty) return _items;
    final q = _query.toLowerCase();
    return _items.where((e) => e.title.toLowerCase().contains(q)).toList();
  }

  void _find() => setState(() => _query = _searchCtrl.text);

  void _clear() {
    _searchCtrl.clear();
    setState(() => _query = "");
  }

  void _defaultAddNew() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Add New")));
  }

  void _onView(PolicyItem item) => (widget.onView ?? _noopView).call(item);
  void _onEdit(PolicyItem item) => (widget.onEdit ?? _noopEdit).call(item);
  void _onDelete(PolicyItem item) =>
      (widget.onDelete ?? _noopDelete).call(item);

  void _noopView(PolicyItem item) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("View: ${item.title}")));
  }

  void _noopEdit(PolicyItem item) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Edit: ${item.title}")));
  }

  void _noopDelete(PolicyItem item) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Delete: ${item.title}")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBg,
      appBar: const CustomAppBar(title: 'All Policy & Procedure'),
      body: LayoutBuilder(
        builder: (context, c) {
          final w = c.maxWidth;

          final isMobile = w < 760;
          final isTablet = w >= 760 && w < 1100;
          final compact = isTablet; // compact layout for tablet

          final horizontalPad = isMobile ? 12.0 : 22.0;

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1180),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPad,
                  vertical: isMobile ? 12 : 20,
                ),
                child: _CardShell(
                  child: Column(
                    children: [
                      _HeaderBar(
                        title: "Policy & Procedure",
                        actions: isMobile
                            ? _MobileActions(
                                searchCtrl: _searchCtrl,
                                onFind: _find,
                                onClear: _clear,
                                onAddNew: widget.onAddNew ?? _defaultAddNew,
                              )
                            : _DesktopActions(
                                searchCtrl: _searchCtrl,
                                onFind: _find,
                                onClear: _clear,
                                onAddNew: widget.onAddNew ?? _defaultAddNew,
                              ),
                      ),
                      if (!isMobile) _TableHeader(isCompact: compact),
                      Expanded(
                        child: isMobile
                            ? _MobileList(
                                items: _filtered,
                                onView: _onView,
                                onEdit: _onEdit,
                                onDelete: _onDelete,
                              )
                            : _DesktopTable(
                                items: _filtered,
                                compact: compact,
                                onView: _onView,
                                onEdit: _onEdit,
                                onDelete: _onDelete,
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// ---------------------------------- UI helpers ----------------------------------

class _CardShell extends StatelessWidget {
  final Widget child;
  const _CardShell({required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 2,
      shadowColor: const Color(0x11000000),
      borderRadius: BorderRadius.circular(10),
      child: ClipRRect(borderRadius: BorderRadius.circular(10), child: child),
    );
  }
}

class _HeaderBar extends StatelessWidget {
  final String title;
  final Widget actions;

  const _HeaderBar({required this.title, required this.actions});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF9C27B0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: LayoutBuilder(
        builder: (context, c) {
          final isNarrow = c.maxWidth < 900;

          if (isNarrow) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 12),
                Align(alignment: Alignment.centerRight, child: actions),
              ],
            );
          }

          return Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              Flexible(child: actions),
            ],
          );
        },
      ),
    );
  }
}

class _DesktopActions extends StatelessWidget {
  final TextEditingController searchCtrl;
  final VoidCallback onFind;
  final VoidCallback onClear;
  final VoidCallback onAddNew;

  const _DesktopActions({
    required this.searchCtrl,
    required this.onFind,
    required this.onClear,
    required this.onAddNew,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final isTight = c.maxWidth < 520;

        return Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.end,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SizedBox(
              width: isTight ? c.maxWidth : 260,
              height: 38,
              child: TextField(
                controller: searchCtrl,
                decoration: InputDecoration(
                  hintText: "Search...",
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.search, size: 18),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            _PillButton(
              label: "Find",
              bg: const Color(0xFFE91E63),
              onTap: onFind,
            ),
            _PillButton(
              label: "Clear All",
              bg: const Color(0xFF00BFA5),
              onTap: onClear,
            ),
            _PillButton(
              label: "Add New",
              bg: const Color(0xFF8E24AA),
              icon: Icons.add,
              onTap: onAddNew,
            ),
          ],
        );
      },
    );
  }
}

class _MobileActions extends StatelessWidget {
  final TextEditingController searchCtrl;
  final VoidCallback onFind;
  final VoidCallback onClear;
  final VoidCallback onAddNew;

  const _MobileActions({
    required this.searchCtrl,
    required this.onFind,
    required this.onClear,
    required this.onAddNew,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          height: 38,
          child: TextField(
            controller: searchCtrl,
            decoration: InputDecoration(
              hintText: "Search...",
              filled: true,
              fillColor: Colors.white,
              prefixIcon: const Icon(Icons.search, size: 18),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.end,
          children: [
            _PillButton(
              label: "Find",
              bg: const Color(0xFFE91E63),
              onTap: onFind,
            ),
            _PillButton(
              label: "Clear All",
              bg: const Color(0xFF00BFA5),
              onTap: onClear,
            ),
            _PillButton(
              label: "Add New",
              bg: const Color(0xFF8E24AA),
              icon: Icons.add,
              onTap: onAddNew,
            ),
          ],
        ),
      ],
    );
  }
}

class _TableHeader extends StatelessWidget {
  final bool isCompact;
  const _TableHeader({required this.isCompact});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF2F3F7),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          const Expanded(
            flex: 6,
            child: Text(
              "TITLE",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: Color(0xFF9E9E9E),
              ),
            ),
          ),
          if (!isCompact)
            const Expanded(
              flex: 2,
              child: Text(
                "FILE",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF9E9E9E),
                ),
              ),
            ),
          const Expanded(
            flex: 3,
            child: Text(
              "ACTIONS",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: Color(0xFF9E9E9E),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DesktopTable extends StatelessWidget {
  final List<PolicyItem> items;
  final bool compact;
  final void Function(PolicyItem) onView;
  final void Function(PolicyItem) onEdit;
  final void Function(PolicyItem) onDelete;

  const _DesktopTable({
    required this.items,
    required this.compact,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 10),
      itemCount: items.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, i) {
        final item = items[i];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: Text(
                  item.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3A3A3A),
                  ),
                ),
              ),
              if (!compact)
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: _PillButton(
                      label: "View File",
                      bg: const Color(0xFF00BFA5),
                      icon: Icons.remove_red_eye_outlined,
                      onTap: () => onView(item),
                    ),
                  ),
                ),
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      if (compact)
                        _PillButton(
                          label: "View File",
                          bg: const Color(0xFF00BFA5),
                          icon: Icons.remove_red_eye_outlined,
                          onTap: () => onView(item),
                        ),
                      _PillButton(
                        label: "Edit",
                        bg: const Color(0xFF66BB6A),
                        icon: Icons.edit_outlined,
                        onTap: () => onEdit(item),
                      ),
                      _PillButton(
                        label: "Delete",
                        bg: const Color(0xFFFF5A6B),
                        icon: Icons.delete_outline,
                        onTap: () => onDelete(item),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MobileList extends StatelessWidget {
  final List<PolicyItem> items;
  final void Function(PolicyItem) onView;
  final void Function(PolicyItem) onEdit;
  final void Function(PolicyItem) onDelete;

  const _MobileList({
    required this.items,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        final item = items[i];

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFD),
            border: Border.all(color: const Color(0xFFE6E6E6)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _PillButton(
                    label: "View File",
                    bg: const Color(0xFF00BFA5),
                    icon: Icons.remove_red_eye_outlined,
                    onTap: () => onView(item),
                  ),
                  _PillButton(
                    label: "Edit",
                    bg: const Color(0xFF66BB6A),
                    icon: Icons.edit_outlined,
                    onTap: () => onEdit(item),
                  ),
                  _PillButton(
                    label: "Delete",
                    bg: const Color(0xFFFF5A6B),
                    icon: Icons.delete_outline,
                    onTap: () => onDelete(item),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PillButton extends StatelessWidget {
  final String label;
  final Color bg;
  final IconData? icon;
  final VoidCallback onTap;

  const _PillButton({
    required this.label,
    required this.bg,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(6),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
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
        ),
      ),
    );
  }
}
