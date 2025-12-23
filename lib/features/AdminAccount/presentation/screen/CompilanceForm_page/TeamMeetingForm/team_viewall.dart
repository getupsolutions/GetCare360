import 'package:flutter/material.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/CompilanceForm_page/Continous_improvment/continuos_viewall.dart';

class TeamtRegisterItem {
  final String id;
  final String referenceCode;
  final String position;
  final String location;
  final String completedBy;
  final String staff;
  final DateTime completedDate;
  final DateTime createdAt;

  const TeamtRegisterItem({
    required this.id,
    required this.referenceCode,
    required this.position,
    required this.location,
    required this.completedBy,
    required this.staff,
    required this.completedDate,
    required this.createdAt,
  });
}

class TeamViewall extends StatefulWidget {
  final VoidCallback? onAddNew;
  final void Function(ContinoustRegisterItem item)? onView;
  final void Function(ContinoustRegisterItem item)? onEdit;
  final void Function(ContinoustRegisterItem item)? onDelete;

  const TeamViewall({
    super.key,
    this.onAddNew,
    this.onView,
    this.onEdit,
    this.onDelete,
  });

  @override
  State<TeamViewall> createState() => _TeamViewallState();
}

class _TeamViewallState extends State<TeamViewall> {
  static const Color brandPurple = Color(0xFF9C27B0);
  static const Color pageBg = Color(0xFFF3F4F8);

  final _searchCtrl = TextEditingController();
  final _startCtrl = TextEditingController();
  final _endCtrl = TextEditingController();
  String? _staff;

  String _query = "";

  final _staffList = const ["All", "Steven Maschek", "Shine", "Bincy", "Dazy"];

  final List<ContinoustRegisterItem> _items = [
    ContinoustRegisterItem(
      id: "1",
      referenceCode: "AC230725",
      position: "Carer",
      location: "Entrance On community Outing",
      completedBy: "Steven",
      staff: "Steven Maschek",
      completedDate: DateTime(2025, 7, 23),
      createdAt: DateTime(2025, 7, 23, 12, 0),
    ),
    ContinoustRegisterItem(
      id: "2",
      referenceCode: "1111",
      position: "s",
      location: "s",
      completedBy: "Shine",
      staff: "s",
      completedDate: DateTime(2025, 7, 2),
      createdAt: DateTime(2025, 7, 7, 16, 15),
    ),
    ContinoustRegisterItem(
      id: "3",
      referenceCode: ".",
      position: "RN",
      location: "In Stephen's home",
      completedBy: "Bincy",
      staff: "Bincy Pappachan",
      completedDate: DateTime(2025, 7, 1),
      createdAt: DateTime(2025, 6, 30, 13, 0),
    ),
    ContinoustRegisterItem(
      id: "4",
      referenceCode: "edna kamara",
      position: "support worker",
      location: "villawood",
      completedBy: "dazy",
      staff: "dazy rani",
      completedDate: DateTime(2025, 6, 29),
      createdAt: DateTime(2025, 6, 30, 13, 0),
    ),
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    _startCtrl.dispose();
    _endCtrl.dispose();
    super.dispose();
  }

  List<ContinoustRegisterItem> get _filtered {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty && (_staff == null || _staff == "All")) return _items;

    return _items.where((e) {
      final matchesText =
          q.isEmpty ||
          e.referenceCode.toLowerCase().contains(q) ||
          e.location.toLowerCase().contains(q) ||
          e.staff.toLowerCase().contains(q) ||
          e.completedBy.toLowerCase().contains(q);

      final matchesStaff = (_staff == null || _staff == "All")
          ? true
          : e.staff.toLowerCase().contains(_staff!.toLowerCase());

      return matchesText && matchesStaff;
    }).toList();
  }

  Future<void> _pickDate(TextEditingController ctrl) async {
    final d = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );
    if (d != null) {
      ctrl.text =
          "${d.year}-${d.month.toString().padLeft(2, "0")}-${d.day.toString().padLeft(2, "0")}";
    }
  }

  void _find() => setState(() => _query = _searchCtrl.text);

  void _clear() {
    _searchCtrl.clear();
    _startCtrl.clear();
    _endCtrl.clear();
    setState(() {
      _query = "";
      _staff = null;
    });
  }

  void _defaultAddNew() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Add New")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBg,
      appBar: AppBar(
        backgroundColor: brandPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Continuous Register",
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, c) {
          final w = c.maxWidth;

          final isMobile = w < 760;
          final isTablet = w >= 760 && w < 1100;

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
                      _HeaderWithFilters(
                        isMobile: isMobile,
                        searchCtrl: _searchCtrl,
                        startCtrl: _startCtrl,
                        endCtrl: _endCtrl,
                        staff: _staff,
                        staffList: _staffList,
                        onStaffChanged: (v) => setState(() => _staff = v),
                        onFind: _find,
                        onClear: _clear,
                        onAddNew: widget.onAddNew ?? _defaultAddNew,
                        onPickStart: () => _pickDate(_startCtrl),
                        onPickEnd: () => _pickDate(_endCtrl),
                      ),
                      Expanded(
                        child: ListView.separated(
                          padding: EdgeInsets.all(isMobile ? 12 : 14),
                          itemCount: _filtered.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, i) {
                            final item = _filtered[i];
                            return _RegisterCard(
                              item: item,
                              isMobile: isMobile,
                              isTablet: isTablet,
                              onView: () =>
                                  (widget.onView ?? _noopView).call(item),
                              onEdit: () =>
                                  (widget.onEdit ?? _noopEdit).call(item),
                              onDelete: () =>
                                  (widget.onDelete ?? _noopDelete).call(item),
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

  void _noopView(ContinoustRegisterItem item) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("View: ${item.referenceCode}")));
  }

  void _noopEdit(ContinoustRegisterItem item) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Edit: ${item.referenceCode}")));
  }

  void _noopDelete(ContinoustRegisterItem item) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Delete: ${item.referenceCode}")));
  }
}

/// ---------------- UI widgets ----------------

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

class _HeaderWithFilters extends StatelessWidget {
  final bool isMobile;
  final TextEditingController searchCtrl;
  final TextEditingController startCtrl;
  final TextEditingController endCtrl;

  final String? staff;
  final List<String> staffList;
  final void Function(String?) onStaffChanged;

  final VoidCallback onFind;
  final VoidCallback onClear;
  final VoidCallback onAddNew;
  final VoidCallback onPickStart;
  final VoidCallback onPickEnd;

  const _HeaderWithFilters({
    required this.isMobile,
    required this.searchCtrl,
    required this.startCtrl,
    required this.endCtrl,
    required this.staff,
    required this.staffList,
    required this.onStaffChanged,
    required this.onFind,
    required this.onClear,
    required this.onAddNew,
    required this.onPickStart,
    required this.onPickEnd,
  });

  static const Color brandPurple = Color(0xFF9C27B0);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: brandPurple,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Continuous Register",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 12),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _FilterBox(
                fullWidth: isMobile,
                width: 210,
                child: TextField(
                  controller: searchCtrl,
                  decoration: _fieldDeco("Search...", icon: Icons.search),
                ),
              ),
              _FilterBox(
                fullWidth: isMobile,
                width: 210,
                child: TextField(
                  controller: startCtrl,
                  readOnly: true,
                  onTap: onPickStart,
                  decoration: _fieldDeco(
                    "Start Date",
                    icon: Icons.calendar_month,
                  ),
                ),
              ),
              _FilterBox(
                fullWidth: isMobile,
                width: 210,
                child: TextField(
                  controller: endCtrl,
                  readOnly: true,
                  onTap: onPickEnd,
                  decoration: _fieldDeco(
                    "End Date",
                    icon: Icons.calendar_month,
                  ),
                ),
              ),
              _FilterBox(
                fullWidth: isMobile,
                width: 220,
                child: DropdownButtonFormField<String>(
                  value: staff,
                  items: staffList
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: onStaffChanged,
                  decoration: _fieldDeco("Select Staff"),
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
          ),
        ],
      ),
    );
  }

  static InputDecoration _fieldDeco(String hint, {IconData? icon}) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: icon != null ? Icon(icon, size: 18) : null,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    );
  }
}

class _FilterBox extends StatelessWidget {
  final double width;
  final bool fullWidth;
  final Widget child;

  const _FilterBox({
    required this.width,
    required this.fullWidth,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth ? MediaQuery.of(context).size.width : width,
      height: 42,
      child: child,
    );
  }
}

class _RegisterCard extends StatelessWidget {
  final ContinoustRegisterItem item;
  final bool isMobile;
  final bool isTablet;
  final VoidCallback onView;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _RegisterCard({
    required this.item,
    required this.isMobile,
    required this.isTablet,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
  });

  String _fmtDate(DateTime d) =>
      "${d.day.toString().padLeft(2, "0")}-${d.month.toString().padLeft(2, "0")}-${d.year}";

  String _fmtCreated(DateTime d) {
    final hh = d.hour.toString().padLeft(2, "0");
    final mm = d.minute.toString().padLeft(2, "0");
    return "Created at ${_fmtDate(d)} $hh:$mm";
  }

  @override
  Widget build(BuildContext context) {
    final actionButtons = Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        _PillButton(
          label: "View",
          bg: const Color(0xFF00BFA5),
          icon: Icons.remove_red_eye_outlined,
          onTap: onView,
        ),
        _PillButton(
          label: "Edit",
          bg: const Color(0xFF66BB6A),
          icon: Icons.edit_outlined,
          onTap: onEdit,
        ),
        _PillButton(
          label: "Delete",
          bg: const Color(0xFFFF5A6B),
          icon: Icons.delete_outline,
          onTap: onDelete,
        ),
      ],
    );

    return Container(
      padding: EdgeInsets.all(isMobile ? 12 : 14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFEDEDED)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _InfoGridMobile(item: item),
                const SizedBox(height: 12),
                actionButtons,
                const SizedBox(height: 10),
                Text(
                  _fmtCreated(item.createdAt),
                  style: const TextStyle(
                    color: Color(0xFF00BFA5),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _InfoGridDesktop(item: item, isTablet: isTablet),
                ),
                const SizedBox(width: 14),
                // ✅ On tablet keep wrap; on desktop stack looks like your screenshot
                SizedBox(
                  width: isTablet ? 220 : 140,
                  child: isTablet
                      ? actionButtons
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _PillButton(
                              label: "View",
                              bg: const Color(0xFF00BFA5),
                              icon: Icons.remove_red_eye_outlined,
                              onTap: onView,
                            ),
                            const SizedBox(height: 8),
                            _PillButton(
                              label: "Edit",
                              bg: const Color(0xFF66BB6A),
                              icon: Icons.edit_outlined,
                              onTap: onEdit,
                            ),
                            const SizedBox(height: 8),
                            _PillButton(
                              label: "Delete",
                              bg: const Color(0xFFFF5A6B),
                              icon: Icons.delete_outline,
                              onTap: onDelete,
                            ),
                          ],
                        ),
                ),
              ],
            ),
    );
  }
}

class _InfoGridMobile extends StatelessWidget {
  final ContinoustRegisterItem item;
  const _InfoGridMobile({required this.item});

  String _fmtDate(DateTime d) =>
      "${d.day.toString().padLeft(2, "0")}-${d.month.toString().padLeft(2, "0")}-${d.year}";

  @override
  Widget build(BuildContext context) {
    final blocks = [
      _InfoBlock(label: "Reference Code", value: item.referenceCode),
      _InfoBlock(label: "Position", value: item.position),
      _InfoBlock(label: "Location", value: item.location),
      _InfoBlock(label: "Completed Date", value: _fmtDate(item.completedDate)),
      _InfoBlock(label: "Completed By", value: item.completedBy),
      _InfoBlock(label: "Staff", value: item.staff),
    ];

    return Column(
      children: blocks
          .map(
            (b) =>
                Padding(padding: const EdgeInsets.only(bottom: 10), child: b),
          )
          .toList(),
    );
  }
}

class _InfoGridDesktop extends StatelessWidget {
  final ContinoustRegisterItem item;
  final bool isTablet;

  const _InfoGridDesktop({required this.item, required this.isTablet});

  String _fmtDate(DateTime d) =>
      "${d.day.toString().padLeft(2, "0")}-${d.month.toString().padLeft(2, "0")}-${d.year}";

  @override
  Widget build(BuildContext context) {
    final blocks = [
      _InfoBlock(label: "Reference Code", value: item.referenceCode),
      _InfoBlock(label: "Position", value: item.position),
      _InfoBlock(label: "Location", value: item.location),
      _InfoBlock(label: "Completed Date", value: _fmtDate(item.completedDate)),
      _InfoBlock(label: "Completed By", value: item.completedBy),
      _InfoBlock(label: "Staff", value: item.staff),
    ];

    // Tablet: 2 columns wrap (more compact)
    if (isTablet) {
      return Wrap(
        spacing: 18,
        runSpacing: 14,
        children: blocks.map((b) => SizedBox(width: 260, child: b)).toList(),
      );
    }

    // Desktop: 3 columns x 2 rows + created line
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: blocks[0]),
            const SizedBox(width: 18),
            Expanded(child: blocks[1]),
            const SizedBox(width: 18),
            Expanded(child: blocks[2]),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(child: blocks[3]),
            const SizedBox(width: 18),
            Expanded(child: blocks[4]),
            const SizedBox(width: 18),
            Expanded(child: blocks[5]),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          "Created at ${_fmtDate(item.createdAt)} "
          "${item.createdAt.hour.toString().padLeft(2, "0")}:${item.createdAt.minute.toString().padLeft(2, "0")}",
          style: const TextStyle(
            color: Color(0xFF00BFA5),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _InfoBlock extends StatelessWidget {
  final String label;
  final String value;

  const _InfoBlock({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF3B3B3B),
            fontWeight: FontWeight.w800,
            fontSize: 12.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF7A7A7A),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
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
    // ✅ Material + Ink fixes ripple + "No Material widget found"
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
