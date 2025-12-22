import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/custom_appbar.dart';

class CarePlanListPage extends StatefulWidget {
  const CarePlanListPage({super.key});

  @override
  State<CarePlanListPage> createState() => _CarePlanListPageState();
}

class _CarePlanListPageState extends State<CarePlanListPage> {
  final TextEditingController _searchCtrl = TextEditingController();

  final List<CarePlanItem> _all = const [
    CarePlanItem(title: "Hearing Issue"),
    CarePlanItem(title: "wefewwer"),
    CarePlanItem(title: "pain care plan"),
    CarePlanItem(title: "Epilepsy Management Plan"),
    CarePlanItem(title: "Falls Risk"),
    CarePlanItem(title: "Mobility and Transfers"),
  ];

  List<CarePlanItem> _filtered = [];

  @override
  void initState() {
    super.initState();
    _filtered = List.of(_all);
  }

  void _applySearch() {
    final q = _searchCtrl.text.trim().toLowerCase();
    if (q.isEmpty) {
      setState(() => _filtered = List.of(_all));
      return;
    }
    setState(() {
      _filtered = _all.where((e) => e.title.toLowerCase().contains(q)).toList();
    });
  }

  void _clearAll() {
    _searchCtrl.clear();
    setState(() => _filtered = List.of(_all));
  }

  void _onAddNew() {
    // Navigator.push(... AddNewCarePlanPage());
  }

  void _onViewEdit(CarePlanItem item) {}
  void _onDelete(CarePlanItem item) {}

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final bool isMobile = w < 900;
    final bool isTablet = w >= 600 && w < 1024;
    final bool isDesktop = w >= 1024;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F8),
      appBar: CustomAppBar(title: "Care Plan", centerTitle: true),
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
              _CarePlanHeader(
                title: "Care Plan",
                searchCtrl: _searchCtrl,
                compact: isTablet,
                onFind: _applySearch,
                onClear: _clearAll,
                onAddNew: _onAddNew,
              ),
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
                      ? _CarePlanMobileList(
                          items: _filtered,
                          onViewEdit: _onViewEdit,
                          onDelete: _onDelete,
                        )
                      : _CarePlanDesktopTable(
                          items: _filtered,
                          dense: !isDesktop,
                          onViewEdit: _onViewEdit,
                          onDelete: _onDelete,
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

/// ---------------- HEADER ----------------

class _CarePlanHeader extends StatelessWidget {
  final String title;
  final TextEditingController searchCtrl;
  final bool compact;
  final VoidCallback onFind;
  final VoidCallback onClear;
  final VoidCallback onAddNew;

  const _CarePlanHeader({
    required this.title,
    required this.searchCtrl,
    required this.compact,
    required this.onFind,
    required this.onClear,
    required this.onAddNew,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final bool tiny = w < 520;

    final searchField = SizedBox(
      height: compact ? 38 : 42,
      child: TextField(
        controller: searchCtrl,
        onSubmitted: (_) => onFind(),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: "Search...",
          prefixIcon: const Icon(Icons.search),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );

    final findBtn = _SmallBtn(
      label: "Find",
      color: const Color(0xFFE53935),
      onTap: onFind,
    );

    final clearBtn = _SmallBtn(
      label: "Clear All",
      color: const Color(0xFF00BFA5),
      onTap: onClear,
    );

    final addNewBtn = _SmallBtn(
      label: "+ Add New",
      color: const Color(0xFF7B1FA2),
      onTap: onAddNew,
    );

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF7B1FA2),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 14,
          vertical: compact ? 10 : 14,
        ),
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          runSpacing: 10,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: compact ? 16 : 18,
                fontWeight: FontWeight.w900,
              ),
            ),
            if (tiny)
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    searchField,
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        SizedBox(width: 110, child: findBtn),
                        SizedBox(width: 130, child: clearBtn),
                        SizedBox(width: 120, child: addNewBtn),
                      ],
                    ),
                  ],
                ),
              )
            else
              SizedBox(
                width: compact ? 560 : 640,
                child: Row(
                  children: [
                    Expanded(child: searchField),
                    const SizedBox(width: 8),
                    findBtn,
                    const SizedBox(width: 8),
                    clearBtn,
                    const SizedBox(width: 8),
                    addNewBtn,
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SmallBtn extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _SmallBtn({
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w900)),
      ),
    );
  }
}

/// ---------------- DESKTOP TABLE ----------------

class _CarePlanDesktopTable extends StatelessWidget {
  final List<CarePlanItem> items;
  final bool dense;
  final ValueChanged<CarePlanItem> onViewEdit;
  final ValueChanged<CarePlanItem> onDelete;

  const _CarePlanDesktopTable({
    required this.items,
    required this.dense,
    required this.onViewEdit,
    required this.onDelete,
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
        return SingleChildScrollView(
          child: DataTable(
            headingTextStyle: headerStyle,
            headingRowHeight: dense ? 44 : 50,
            dataRowMinHeight: dense ? 54 : 60,
            dataRowMaxHeight: dense ? 62 : 70,
            horizontalMargin: 16,
            columnSpacing: 22,
            dividerThickness: 0.8,
            columns: const [
              DataColumn(label: Text("TITLE")),
              DataColumn(label: Text("ACTION")),
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
                          label: "Delete",
                          icon: Icons.delete_outline,
                          color: const Color(0xFFE53935),
                          onTap: () => onDelete(e),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
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

class _CarePlanMobileList extends StatelessWidget {
  final List<CarePlanItem> items;
  final ValueChanged<CarePlanItem> onViewEdit;
  final ValueChanged<CarePlanItem> onDelete;

  const _CarePlanMobileList({
    required this.items,
    required this.onViewEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const Center(child: Text("No care plans found"));

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
                    label: "Delete",
                    icon: Icons.delete_outline,
                    color: const Color(0xFFE53935),
                    onTap: () => onDelete(e),
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

/// ---------------- MODEL ----------------

class CarePlanItem {
  final String title;
  const CarePlanItem({required this.title});
}
