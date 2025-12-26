import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/admin_ui.dart';
import 'package:getcare360/core/widget/custom_appbar.dart';

class LineItem {
  final bool checked;
  final String itemNo;
  final String itemName;
  final String categoryName;
  final String nsw;
  final String vic;

  const LineItem({
    this.checked = false,
    required this.itemNo,
    required this.itemName,
    required this.categoryName,
    required this.nsw,
    required this.vic,
  });
}

class LineItemsManagementPage extends StatefulWidget {
  const LineItemsManagementPage({super.key});

  @override
  State<LineItemsManagementPage> createState() =>
      _LineItemsManagementPageState();
}

class _LineItemsManagementPageState extends State<LineItemsManagementPage> {
  final _searchCtrl = TextEditingController();
  String _query = "";
  int _tab = 0; // 0: NDIS, 1: Agency

  final List<LineItem> _items = const [
    LineItem(
      itemNo: "01_002_0107_1_1",
      itemName:
          "Assistance With Self-Care Activities - Standard - Weekday Night",
      categoryName: "Assistance with Daily Life (Includes SIL)",
      nsw: "\$78.81",
      vic: "\$78.81",
    ),
    LineItem(
      itemNo: "01_003_0107_1_1",
      itemName: "Assistance From Live-In Carer",
      categoryName: "Assistance with Daily Life (Includes SIL)",
      nsw: "\$0",
      vic: "\$0",
    ),
    LineItem(
      itemNo: "01_004_0107_1_1",
      itemName: "Assistance with Personal Domestic Activities",
      categoryName: "Assistance with Daily Life (Includes SIL)",
      nsw: "\$59.06",
      vic: "\$59.06",
    ),
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<LineItem> get _filtered {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return _items;
    return _items
        .where(
          (e) =>
              e.itemNo.toLowerCase().contains(q) ||
              e.itemName.toLowerCase().contains(q) ||
              e.categoryName.toLowerCase().contains(q),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdminUi.pageBg,
      appBar: const CustomAppBar(title: "Line Items Management"),
      body: LayoutBuilder(
        builder: (context, c) {
          final w = c.maxWidth;
          final isMobile = w < 980;
          final hp = isMobile ? 12.0 : 22.0;

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1180),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: hp,
                  vertical: isMobile ? 12 : 20,
                ),
                child: AdminCardShell(
                  child: Column(
                    children: [
                      const AdminPurpleHeader(title: "Line Items Management"),

                      // Tabs (Wrap to avoid overflow)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 10, 14, 6),
                        child: Wrap(
                          spacing: 18,
                          runSpacing: 10,
                          children: [
                            _TabBtn(
                              label: "NDIS",
                              selected: _tab == 0,
                              onTap: () => setState(() => _tab = 0),
                            ),
                            _TabBtn(
                              label: "Agency",
                              selected: _tab == 1,
                              onTap: () => setState(() => _tab = 1),
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 1),

                      // Search + actions row (responsive wrap)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
                        child: LayoutBuilder(
                          builder: (context, hc) {
                            final tight = hc.maxWidth < 520;

                            return Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    color: Color(0xFF8E8E8E),
                                  ),
                                  tooltip: "Bulk delete (UI only)",
                                ),
                                SizedBox(
                                  width: tight
                                      ? hc.maxWidth
                                      : (isMobile ? 260 : 320),
                                  height: 38,
                                  child: TextField(
                                    controller: _searchCtrl,
                                    decoration:
                                        AdminUi.input(
                                          "Search...",
                                          prefixIcon: Icons.search,
                                        ).copyWith(
                                          suffixIcon: _searchCtrl.text.isEmpty
                                              ? null
                                              : IconButton(
                                                  icon: const Icon(
                                                    Icons.close,
                                                    size: 18,
                                                  ),
                                                  onPressed: () {
                                                    _searchCtrl.clear();
                                                    setState(() => _query = "");
                                                  },
                                                ),
                                        ),
                                    onChanged: (_) => setState(() {}),
                                  ),
                                ),
                                AdminPillButton(
                                  label: "Find",
                                  bg: const Color(0xFFE91E63),
                                  onTap: () =>
                                      setState(() => _query = _searchCtrl.text),
                                ),
                                AdminPillButton(
                                  label: "Archive",
                                  bg: AdminUi.brandPurpleDark,
                                  icon: Icons.archive_outlined,
                                  onTap: () => ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                        const SnackBar(
                                          content: Text("Archive clicked"),
                                        ),
                                      ),
                                ),
                                AdminPillButton(
                                  label: "Import",
                                  bg: AdminUi.brandPurpleDark,
                                  icon: Icons.file_upload_outlined,
                                  onTap: () => ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                        const SnackBar(
                                          content: Text("Import clicked"),
                                        ),
                                      ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),

                      // Table header (desktop)
                      if (!isMobile)
                        Container(
                          height: 44,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          color: const Color(0xFFFFE7FA),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 34,
                                child: Text("#", style: _HeadStyle()),
                              ),
                              const SizedBox(width: 40),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Support Item No.",
                                  style: _HeadStyle(),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Text(
                                  "Support Item Name",
                                  style: _HeadStyle(),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Text(
                                  "Support Category Name",
                                  style: _HeadStyle(),
                                ),
                              ),
                              SizedBox(
                                width: 70,
                                child: Text("NSW", style: _HeadStyle()),
                              ),
                              SizedBox(
                                width: 70,
                                child: Text("VIC", style: _HeadStyle()),
                              ),
                              const SizedBox(width: 46),
                            ],
                          ),
                        ),

                      Expanded(
                        child: ListView.separated(
                          itemCount: _filtered.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (context, i) {
                            final item = _filtered[i];
                            return isMobile
                                ? _LineItemCard(index: i + 1, item: item)
                                : _LineItemRow(index: i + 1, item: item);
                          },
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

class _HeadStyle extends TextStyle {
  _HeadStyle()
    : super(
        fontSize: 12,
        fontWeight: FontWeight.w900,
        color: const Color(0xFF8E24AA),
      );
}

class _TabBtn extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TabBtn({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: selected
                      ? AdminUi.brandPurpleDark
                      : const Color(0xFF7A7A7A),
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 6),
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                height: 2.5,
                width: 42,
                color: selected ? AdminUi.brandPurpleDark : Colors.transparent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LineItemRow extends StatelessWidget {
  final int index;
  final LineItem item;

  const _LineItemRow({required this.index, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          SizedBox(
            width: 34,
            child: Text(
              "$index",
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
          SizedBox(width: 40, child: Checkbox(value: false, onChanged: (_) {})),
          Expanded(
            flex: 2,
            child: Text(
              item.itemNo,
              style: const TextStyle(color: Color(0xFF616161)),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              item.itemName,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              item.categoryName,
              style: const TextStyle(color: Color(0xFF616161)),
            ),
          ),
          SizedBox(width: 70, child: Text(item.nsw)),
          SizedBox(width: 70, child: Text(item.vic)),
          SizedBox(
            width: 46,
            child: IconButton(
              icon: const Icon(Icons.edit_square, size: 18),
              onPressed: () => ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Edit ${item.itemNo}"))),
            ),
          ),
        ],
      ),
    );
  }
}

class _LineItemCard extends StatelessWidget {
  final int index;
  final LineItem item;

  const _LineItemCard({required this.index, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFEDEDED)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "#$index",
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(width: 8),
                Checkbox(value: false, onChanged: (_) {}),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.edit_square, size: 18),
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Edit ${item.itemNo}")),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(item.itemNo, style: const TextStyle(color: Color(0xFF616161))),
            const SizedBox(height: 6),
            Text(
              item.itemName,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            Text(
              item.categoryName,
              style: const TextStyle(color: Color(0xFF616161)),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "NSW: ${item.nsw}",
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                Expanded(
                  child: Text(
                    "VIC: ${item.vic}",
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
