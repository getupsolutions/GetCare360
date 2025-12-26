import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/admin_ui.dart';
import 'package:getcare360/core/widget/custom_appbar.dart';

class DirectorItem {
  final String id;
  final String fullName;
  final String signatureLabel;

  const DirectorItem({
    required this.id,
    required this.fullName,
    required this.signatureLabel,
  });
}

class AllDirectorPage extends StatefulWidget {
  final VoidCallback? onAddNew;
  final void Function(DirectorItem item)? onEdit;
  final void Function(DirectorItem item)? onDelete;

  const AllDirectorPage({super.key, this.onAddNew, this.onEdit, this.onDelete});

  @override
  State<AllDirectorPage> createState() => _AllDirectorPageState();
}

class _AllDirectorPageState extends State<AllDirectorPage> {
  final _searchCtrl = TextEditingController();
  String _query = "";

  final List<DirectorItem> _items = const [
    DirectorItem(
      id: "1",
      fullName: "Cicilia A Ragunathan",
      signatureLabel: "Cicilia",
    ),
    DirectorItem(id: "2", fullName: "Shine Jose", signatureLabel: "Shine"),
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<DirectorItem> get _filtered {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return _items;
    return _items.where((e) => e.fullName.toLowerCase().contains(q)).toList();
  }

  void _find() => setState(() => _query = _searchCtrl.text);

  void _clear() {
    _searchCtrl.clear();
    setState(() => _query = "");
  }

  void _addNew() {
    (widget.onAddNew ??
            () => ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Add New Director"))))
        .call();
  }

  void _edit(DirectorItem item) {
    if (widget.onEdit != null) {
      widget.onEdit!(item);
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Edit ${item.fullName}")));
  }

  void _delete(DirectorItem item) {
    if (widget.onDelete != null) {
      widget.onDelete!(item);
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Delete ${item.fullName}")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdminUi.pageBg,
      appBar: const CustomAppBar(title: "Directors"),
      body: LayoutBuilder(
        builder: (context, c) {
          final w = c.maxWidth;

          // breakpoints
          final isMobile = w < 760;
          final isTablet = w >= 760 && w < 1100;
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
                      AdminPurpleHeader(
                        title: "Directors",
                        right: LayoutBuilder(
                          builder: (context, hc) {
                            final tight = hc.maxWidth < 520;

                            return Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              alignment: WrapAlignment.end,
                              children: [
                                SizedBox(
                                  width: tight
                                      ? hc.maxWidth
                                      : (isMobile ? 220 : 280),
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
                                                  onPressed: _clear,
                                                ),
                                        ),
                                    onChanged: (_) => setState(() {}),
                                  ),
                                ),
                                AdminPillButton(
                                  label: "Find",
                                  bg: const Color(0xFFE91E63),
                                  onTap: _find,
                                ),
                                AdminPillButton(
                                  label: "Clear All",
                                  bg: const Color(0xFF00BFA5),
                                  onTap: _clear,
                                ),
                                AdminPillButton(
                                  label: "Add New",
                                  bg: AdminUi.brandPurpleDark,
                                  icon: Icons.add,
                                  onTap: _addNew,
                                ),
                              ],
                            );
                          },
                        ),
                      ),

                      // Desktop/Tablet table header
                      if (!isMobile) ...[
                        Container(
                          height: 44,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          color: const Color(0xFFF7F8FC),
                          child: Row(
                            children: [
                              const Expanded(
                                flex: 3,
                                child: _Head("Full Name"),
                              ),
                              Expanded(
                                flex: isTablet ? 2 : 2,
                                child: const _Head("Signature"),
                              ),
                              Expanded(
                                flex: isTablet ? 4 : 3,
                                child: const _Head("Actions"),
                              ),
                            ],
                          ),
                        ),
                        const Divider(height: 1),
                      ],

                      Expanded(
                        child: ListView.separated(
                          itemCount: _filtered.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (context, i) {
                            final item = _filtered[i];
                            return isMobile
                                ? _DirectorCard(
                                    item: item,
                                    onEdit: () => _edit(item),
                                    onDelete: () => _delete(item),
                                  )
                                : _DirectorRow(
                                    item: item,
                                    compact: isTablet,
                                    onEdit: () => _edit(item),
                                    onDelete: () => _delete(item),
                                  );
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

class _Head extends StatelessWidget {
  final String t;
  const _Head(this.t);

  @override
  Widget build(BuildContext context) {
    return Text(
      t,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w900,
        color: Color(0xFF616161),
      ),
    );
  }
}

class _DirectorRow extends StatelessWidget {
  final DirectorItem item;
  final bool compact;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _DirectorRow({
    required this.item,
    required this.compact,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              item.fullName,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(flex: 2, child: _SignatureChip(text: item.signatureLabel)),
          Expanded(
            flex: compact ? 4 : 3,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  AdminPillButton(
                    label: "View & Edit",
                    bg: const Color(0xFF66BB6A),
                    icon: Icons.edit_outlined,
                    onTap: onEdit,
                  ),
                  AdminPillButton(
                    label: "Delete",
                    bg: const Color(0xFFFF5A6B),
                    icon: Icons.delete_outline,
                    onTap: onDelete,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DirectorCard extends StatelessWidget {
  final DirectorItem item;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _DirectorCard({
    required this.item,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFEDEDED)),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.fullName,
              style: const TextStyle(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 10),
            _SignatureChip(text: item.signatureLabel),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                AdminPillButton(
                  label: "View & Edit",
                  bg: const Color(0xFF66BB6A),
                  icon: Icons.edit_outlined,
                  onTap: onEdit,
                ),
                AdminPillButton(
                  label: "Delete",
                  bg: const Color(0xFFFF5A6B),
                  icon: Icons.delete_outline,
                  onTap: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SignatureChip extends StatelessWidget {
  final String text;
  const _SignatureChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE6E6E6)),
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          fontStyle: FontStyle.italic,
          color: Color(0xFF424242),
        ),
      ),
    );
  }
}
