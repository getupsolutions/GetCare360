import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/custom_appbar.dart';

class ParticipantTimesheetPage extends StatefulWidget {
  const ParticipantTimesheetPage({super.key});

  @override
  State<ParticipantTimesheetPage> createState() =>
      _ParticipantTimesheetPageState();
}

class _ParticipantTimesheetPageState extends State<ParticipantTimesheetPage> {
  final TextEditingController dateRangeCtrl = TextEditingController(
    text: "22-12-2025 - 22-12-2025",
  );

  String participant = "Select participant";
  String staff = "Select Staff";
  String approveFilter = "Select Approved/Unapprove";
  String sort = "Date desc";

  final List<TimesheetRowItem> items = const [
    TimesheetRowItem(
      dateTitle: "Mon 22 December",
      timeRange: "7:00 AM to 10:00 AM",
      designation: "Disability Support Worker",
      location: "8 Fortunato Street Prestons 2170",
      participant: "Tun Li",
      staff: "Prabhjeet Kaur",
      status: "Pending",
      xeroStatus: "Pending",
    ),
    TimesheetRowItem(
      dateTitle: "Mon 22 December",
      timeRange: "7:45 AM to 9:45 AM",
      designation: "Disability Support Worker",
      location: "19 Cheeryble Place Ambervale 2560",
      participant: "Tama Tofaeno",
      staff: "",
      status: "Pending",
      xeroStatus: "Pending",
    ),
    TimesheetRowItem(
      dateTitle: "Mon 22 December",
      timeRange: "8:00 AM to 3:00 PM",
      designation: "Disability Support Worker",
      location: "51 HALCYON ST WYOMING 2250",
      participant: "David Moyle",
      staff: "Saurav Dhungana",
      status: "Pending",
      xeroStatus: "Pending",
    ),
  ];

  @override
  void dispose() {
    dateRangeCtrl.dispose();
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
      appBar: CustomAppBar(title: "Timesheet", centerTitle: true),
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
              _TimesheetHeader(
                isMobile: isMobile,
                compact: isTablet,
                dateRangeCtrl: dateRangeCtrl,
                participant: participant,
                staff: staff,
                approveFilter: approveFilter,
                sort: sort,
                onChangeParticipant: (v) => setState(() => participant = v),
                onChangeStaff: (v) => setState(() => staff = v),
                onChangeApprove: (v) => setState(() => approveFilter = v),
                onChangeSort: (v) => setState(() => sort = v),
                onFind: () {},
                onClearAll: () {},
                onToday: () {},
                onExport: () {},
                onPreviewXero: () {},
                onExportFinalize: () {},
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
                      ? _TimesheetMobileList(items: items)
                      : _TimesheetDesktopTable(items: items, dense: !isDesktop),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ---------------- HEADER (FILTERS + BUTTONS) ----------------

class _TimesheetHeader extends StatelessWidget {
  final bool isMobile;
  final bool compact;

  final TextEditingController dateRangeCtrl;
  final String participant;
  final String staff;
  final String approveFilter;
  final String sort;

  final ValueChanged<String> onChangeParticipant;
  final ValueChanged<String> onChangeStaff;
  final ValueChanged<String> onChangeApprove;
  final ValueChanged<String> onChangeSort;

  final VoidCallback onFind;
  final VoidCallback onClearAll;
  final VoidCallback onToday;
  final VoidCallback onExport;
  final VoidCallback onPreviewXero;
  final VoidCallback onExportFinalize;

  const _TimesheetHeader({
    required this.isMobile,
    required this.compact,
    required this.dateRangeCtrl,
    required this.participant,
    required this.staff,
    required this.approveFilter,
    required this.sort,
    required this.onChangeParticipant,
    required this.onChangeStaff,
    required this.onChangeApprove,
    required this.onChangeSort,
    required this.onFind,
    required this.onClearAll,
    required this.onToday,
    required this.onExport,
    required this.onPreviewXero,
    required this.onExportFinalize,
  });

  @override
  Widget build(BuildContext context) {
    final filters = [
      _FilterTextField(
        controller: dateRangeCtrl,
        hint: "Date Range",
        readOnly: true,
        onTap: () {},
        prefixIcon: Icons.date_range_outlined,
      ),
      _FilterDropdown(
        value: participant,
        items: const ["Select participant", "Tun Li", "David Moyle"],
        onChanged: onChangeParticipant,
      ),
      _FilterDropdown(
        value: staff,
        items: const ["Select Staff", "Prabhjeet Kaur", "Saurav Dhungana"],
        onChanged: onChangeStaff,
      ),
      _FilterDropdown(
        value: approveFilter,
        items: const ["Select Approved/Unapprove", "Approved", "Unapproved"],
        onChanged: onChangeApprove,
      ),
      _FilterDropdown(
        value: sort,
        items: const ["Date desc", "Date asc"],
        onChanged: onChangeSort,
      ),
    ];

    final actions = [
      _ActionBtn(label: "Find", color: const Color(0xFFE53935), onTap: onFind),
      _ActionBtn(
        label: "Clear All",
        color: const Color(0xFF00BFA5),
        onTap: onClearAll,
      ),
      _ActionBtn(
        label: "Todays",
        color: const Color(0xFFFFC107),
        onTap: onToday,
        darkText: true,
      ),
      _ActionBtn(
        label: "Export",
        color: const Color(0xFF263238),
        onTap: onExport,
      ),
      _ActionBtn(
        label: "Preview Xero Format",
        color: const Color(0xFF7B1FA2),
        onTap: onPreviewXero,
      ),
      _ActionBtn(
        label: "Export & Finalize Time Sheet",
        color: const Color(0xFF00BFA5),
        onTap: onExportFinalize,
      ),
    ];

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
          vertical: compact ? 12 : 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Timesheet Generation",
              style: TextStyle(
                color: Colors.white,
                fontSize: compact ? 16 : 18,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 12),

            // Filters
            LayoutBuilder(
              builder: (context, c) {
                // Mobile => stack
                if (isMobile) {
                  return Column(
                    children: [
                      for (int i = 0; i < filters.length; i++) ...[
                        filters[i],
                        const SizedBox(height: 10),
                      ],
                    ],
                  );
                }

                // Desktop/tablet => grid-ish
                final cols = c.maxWidth > 1100 ? 5 : 3;
                return _WrapGrid(columns: cols, gap: 12, children: filters);
              },
            ),

            const SizedBox(height: 12),

            // Actions
            Wrap(spacing: 10, runSpacing: 10, children: actions),
          ],
        ),
      ),
    );
  }
}

class _FilterTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool readOnly;
  final VoidCallback? onTap;
  final IconData? prefixIcon;

  const _FilterTextField({
    required this.controller,
    required this.hint,
    this.readOnly = false,
    this.onTap,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hint,
          prefixIcon: prefixIcon == null ? null : Icon(prefixIcon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class _FilterDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;

  const _FilterDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (v) {
          if (v != null) onChanged(v);
        },
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;
  final bool darkText;

  const _ActionBtn({
    required this.label,
    required this.color,
    required this.onTap,
    this.darkText = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: color,
          foregroundColor: darkText ? Colors.black : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
        ),
      ),
    );
  }
}

/// ---------------- TABLE (DESKTOP) ----------------

class _TimesheetDesktopTable extends StatelessWidget {
  final List<TimesheetRowItem> items;
  final bool dense;

  const _TimesheetDesktopTable({required this.items, required this.dense});

  @override
  Widget build(BuildContext context) {
    final headStyle = TextStyle(
      fontWeight: FontWeight.w900,
      color: Colors.black87,
      fontSize: dense ? 12.5 : 13.5,
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
                  headingTextStyle: headStyle,
                  headingRowHeight: dense ? 44 : 50,
                  dataRowMinHeight: dense ? 56 : 62,
                  dataRowMaxHeight: dense ? 86 : 96,
                  horizontalMargin: 16,
                  columnSpacing: 22,
                  dividerThickness: 0.8,
                  columns: const [
                    DataColumn(label: Text("Date")),
                    DataColumn(label: Text("Designation")),
                    DataColumn(label: Text("Participant")),
                    DataColumn(label: Text("Staff")),
                    DataColumn(label: Text("Status")),
                    DataColumn(label: Text("Xero Export Status")),
                  ],
                  rows: List.generate(items.length, (i) {
                    final e = items[i];
                    final bg = i.isOdd ? const Color(0xFFF7F7FB) : Colors.white;

                    return DataRow(
                      color: WidgetStatePropertyAll(bg),
                      cells: [
                        DataCell(
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.dateTitle,
                                style: rowStyle.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(e.timeRange, style: rowStyle),
                            ],
                          ),
                        ),
                        DataCell(
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.designation,
                                style: rowStyle.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 14,
                                    color: Colors.orange,
                                  ),
                                  const SizedBox(width: 4),
                                  SizedBox(
                                    width: 260,
                                    child: Text(
                                      e.location,
                                      style: rowStyle.copyWith(
                                        color: Colors.black54,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        DataCell(Text(e.participant, style: rowStyle)),
                        DataCell(
                          Text(
                            e.staff.isEmpty ? "-" : e.staff,
                            style: rowStyle,
                          ),
                        ),
                        DataCell(_StatusChip(text: e.status)),
                        DataCell(_StatusChip(text: e.xeroStatus)),
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

class _StatusChip extends StatelessWidget {
  final String text;
  const _StatusChip({required this.text});

  @override
  Widget build(BuildContext context) {
    final bg = const Color(0xFFFFE3EA);
    final fg = const Color(0xFFE53935);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 12,
          color: Color(0xFFE53935),
        ),
      ),
    );
  }
}

/// ---------------- MOBILE LIST ----------------

class _TimesheetMobileList extends StatelessWidget {
  final List<TimesheetRowItem> items;
  const _TimesheetMobileList({required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const Center(child: Text("No timesheets"));

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
                "${e.dateTitle} • ${e.timeRange}",
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 8),

              Text(
                e.designation,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 14, color: Colors.orange),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      e.location,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              _kv("Participant", e.participant),
              _kv("Staff", e.staff.isEmpty ? "-" : e.staff),

              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _StatusChip(text: e.status),
                  _StatusChip(text: e.xeroStatus),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _kv(String k, String v) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              "$k:",
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(child: Text(v)),
        ],
      ),
    );
  }
}

/// ---------------- SIMPLE WRAP GRID ----------------

class _WrapGrid extends StatelessWidget {
  final int columns;
  final double gap;
  final List<Widget> children;

  const _WrapGrid({
    required this.columns,
    required this.gap,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (int i = 0; i < children.length; i += columns) {
      final rowChildren = <Widget>[];
      for (int j = 0; j < columns; j++) {
        final idx = i + j;
        rowChildren.add(
          Expanded(
            child: idx < children.length ? children[idx] : const SizedBox(),
          ),
        );
        if (j != columns - 1) rowChildren.add(SizedBox(width: gap));
      }
      rows.add(Row(children: rowChildren));
      if (i + columns < children.length) rows.add(SizedBox(height: gap));
    }
    return Column(children: rows);
  }
}

/// ---------------- MODEL ----------------

class TimesheetRowItem {
  final String dateTitle;
  final String timeRange;
  final String designation;
  final String location;
  final String participant;
  final String staff;
  final String status;
  final String xeroStatus;

  const TimesheetRowItem({
    required this.dateTitle,
    required this.timeRange,
    required this.designation,
    required this.location,
    required this.participant,
    required this.staff,
    required this.status,
    required this.xeroStatus,
  });
}
