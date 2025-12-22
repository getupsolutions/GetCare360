import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/custom_appbar.dart';

class ChartArchive extends StatefulWidget {
  const ChartArchive({super.key});

  @override
  State<ChartArchive> createState() => _ChartArchiveState();
}

class _ChartArchiveState extends State<ChartArchive> {
  final List<SupportItem> _items = const [
    SupportItem(
      title: "Assistance with Daily Living",
   
    ),
    SupportItem(
      title: "Support 2",

    ),
    SupportItem(
      title: "Support 1",

    ),
  ];

  void _onBack() => Navigator.maybePop(context);

  void _onViewEdit(SupportItem item) {
    // Navigator.push(... view/edit)
  }

  void _onRestore(SupportItem item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Restored "${item.title}" (UI only)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final bool isMobile = w < 900;
    final bool isDesktop = w >= 1024;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F8),
      appBar: CustomAppBar(title: "Chart", centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: isMobile ? 12 : 18,
            right: isMobile ? 12 : 18,
            top: 14,
            bottom: 14,
          ),
          child: Column(
            children: [
              _PurpleHeaderBar(title: "Charts", onBack: _onBack),
              const SizedBox(height: 12),
              Expanded(
                child: Card(
                  elevation: 0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Color(0xFFE7E7EF)),
                  ),
                  child: isMobile
                      ? _MobileSupportList(
                          items: _items,
                          onViewEdit: _onViewEdit,
                          onRestore: _onRestore,
                        )
                      : _DesktopSupportTable(
                          items: _items,
                          dense: !isDesktop,
                          onViewEdit: _onViewEdit,
                          onRestore: _onRestore,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ---------------- TOP PURPLE HEADER ----------------

class _PurpleHeaderBar extends StatelessWidget {
  final String title;
  final VoidCallback onBack;

  const _PurpleHeaderBar({required this.title, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF7B1FA2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 34,
              child: ElevatedButton(
                onPressed: onBack,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xFF00BFA5),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Back",
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------------- DESKTOP TABLE ----------------

class _DesktopSupportTable extends StatelessWidget {
  final List<SupportItem> items;
  final bool dense;
  final ValueChanged<SupportItem> onViewEdit;
  final ValueChanged<SupportItem> onRestore;

  const _DesktopSupportTable({
    required this.items,
    required this.dense,
    required this.onViewEdit,
    required this.onRestore,
  });

  @override
  Widget build(BuildContext context) {
    final headerStyle = TextStyle(
      fontWeight: FontWeight.w900,
      color: Colors.black54,
      fontSize: dense ? 12.0 : 13.0,
      letterSpacing: 0.4,
    );

    final rowStyle = TextStyle(fontSize: dense ? 12.5 : 13.5);

    return LayoutBuilder(
      builder: (context, c) {
        return Scrollbar(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: c.maxWidth),
              child: SingleChildScrollView(
                child: DataTable(
                  headingTextStyle: headerStyle,
                  headingRowHeight: dense ? 44 : 50,
                  dataRowMinHeight: dense ? 54 : 60,
                  dataRowMaxHeight: dense ? 64 : 70,
                  horizontalMargin: 16,
                  columnSpacing: 22,
                  dividerThickness: 0.8,
                  columns: const [
                    DataColumn(label: Text("Title")),
                    DataColumn(label: Text("Actions")),
                  ],
                  rows: List.generate(items.length, (i) {
                    final e = items[i];
                    return DataRow(
                      cells: [
                        DataCell(Text(e.title, style: rowStyle)),
                        DataCell(
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              _ActionPill(
                                label: "View & Edit",
                                icon: Icons.edit_outlined,
                                color: const Color(0xFF4CAF50),
                                onTap: () => onViewEdit(e),
                              ),
                              _ActionPill(
                                label: "Restore",
                                icon: Icons.restore,
                                color: const Color(0xFFFF9800),
                                onTap: () => onRestore(e),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ActionPill extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionPill({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 16),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
        ),
      ),
    );
  }
}

/// ---------------- MOBILE LIST ----------------

class _MobileSupportList extends StatelessWidget {
  final List<SupportItem> items;
  final ValueChanged<SupportItem> onViewEdit;
  final ValueChanged<SupportItem> onRestore;

  const _MobileSupportList({
    required this.items,
    required this.onViewEdit,
    required this.onRestore,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const Center(child: Text("No supports found"));

    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        final e = items[i];
        final bg = i.isOdd ? const Color(0xFFF7F7FB) : Colors.white;

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE7E7EF)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                e.title,
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 10),

              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _ActionPill(
                    label: "View & Edit",
                    icon: Icons.edit_outlined,
                    color: const Color(0xFF4CAF50),
                    onTap: () => onViewEdit(e),
                  ),
                  _ActionPill(
                    label: "Restore",
                    icon: Icons.restore,
                    color: const Color(0xFFFF9800),
                    onTap: () => onRestore(e),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _kv(String k, String v, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 60,
            child: Text(
              "$k:",
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
            child: Text(v, maxLines: maxLines, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}

/// ---------------- MODEL ----------------

class SupportItem {
  final String title;

  const SupportItem({required this.title});
}
