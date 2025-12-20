import 'dart:math';
import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/custom_appbar.dart';

/// ------------------------------------------------------------
/// Organization Timesheet (MATCHES IMAGE)
/// - Purple header card
///   - Title
///   - 5 white fields in ONE ROW (wraps only if screen is smaller)
///   - Buttons row under the fields (Find / Clear All / Todays / Export)
/// - White table with header row + rows
/// - Responsive: on smaller widths it wraps nicely + table horizontal scroll
/// ------------------------------------------------------------
class OrganizationTimesheetPage extends StatefulWidget {
  const OrganizationTimesheetPage({super.key});

  static const pageBg = Color(0xFFF3F4F8);
  static const purple = Color(0xFF8E24AA);

  @override
  State<OrganizationTimesheetPage> createState() =>
      _OrganizationTimesheetPageState();
}

class _OrganizationTimesheetPageState extends State<OrganizationTimesheetPage> {
  final TextEditingController dateCtrl = TextEditingController(
    text: "20-12-2025 - 20-12-2025",
  );

  String organization = "Select organization";
  String staff = "Select Staff";
  String approval = "Select Approved/Unapprove";
  String sort = "Date desc";

  final rows = const <TimesheetRowData>[
    TimesheetRowData(
      dateTitle: "Sat 20 December",
      dateSub: "12:00 PM to 8:00 PM 40380",
      designationName: "Triniti Admin",
      designationAddress: "86 Mann St Gosford 2250",
      organization: "Triniti Home Care PTY LTD",
      staff: "Aleena Monica",
      status: "Signin",
    ),
  ];

  @override
  void dispose() {
    dateCtrl.dispose();
    super.dispose();
  }

  void clearAll() {
    setState(() {
      dateCtrl.text = "20-12-2025 - 20-12-2025";
      organization = "Select organization";
      staff = "Select Staff";
      approval = "Select Approved/Unapprove";
      sort = "Date desc";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Timesheet', centerTitle: true),
      backgroundColor: OrganizationTimesheetPage.pageBg,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, c) {
            final w = c.maxWidth;

            // Like web screenshot: centered content
            final contentMaxWidth = 1100.0;
            final contentWidth = min(w, contentMaxWidth);

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: contentWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TimesheetHeaderCard(
                        dateCtrl: dateCtrl,
                        organization: organization,
                        staff: staff,
                        approval: approval,
                        sort: sort,
                        onOrganizationChanged: (v) =>
                            setState(() => organization = v),
                        onStaffChanged: (v) => setState(() => staff = v),
                        onApprovalChanged: (v) => setState(() => approval = v),
                        onSortChanged: (v) => setState(() => sort = v),
                        onFind: () {},
                        onClearAll: clearAll,
                        onTodays: () {},
                        onExport: () {},
                      ),
                      const SizedBox(height: 14),

                      // Table area (no Expanded inside scroll view)
                      TimesheetTable(rows: rows),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// HEADER (Purple) - looks like image
/// ------------------------------------------------------------
class TimesheetHeaderCard extends StatelessWidget {
  final TextEditingController dateCtrl;
  final String organization;
  final String staff;
  final String approval;
  final String sort;

  final ValueChanged<String> onOrganizationChanged;
  final ValueChanged<String> onStaffChanged;
  final ValueChanged<String> onApprovalChanged;
  final ValueChanged<String> onSortChanged;

  final VoidCallback onFind;
  final VoidCallback onClearAll;
  final VoidCallback onTodays;
  final VoidCallback onExport;

  const TimesheetHeaderCard({
    super.key,
    required this.dateCtrl,
    required this.organization,
    required this.staff,
    required this.approval,
    required this.sort,
    required this.onOrganizationChanged,
    required this.onStaffChanged,
    required this.onApprovalChanged,
    required this.onSortChanged,
    required this.onFind,
    required this.onClearAll,
    required this.onTodays,
    required this.onExport,
  });

  @override
  Widget build(BuildContext context) {
    const purple = OrganizationTimesheetPage.purple;

    return Container(
      decoration: BoxDecoration(
        color: purple,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: LayoutBuilder(
        builder: (context, c) {
          final w = c.maxWidth;

          // If the screen is too small, allow wrapping
          final isTight = w < 980;

          // These widths match the look in the screenshot (5 boxes)
          final dateW = 210.0;
          final orgW = 200.0;
          final staffW = 200.0;
          final apprW = 220.0;
          final sortW = 200.0;

          final inputH = 38.0;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Timesheet Generation",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),

              // Row of 5 inputs (wraps on smaller screens)
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  SizedBox(
                    width: isTight ? min(w, 420) : dateW,
                    height: inputH,
                    child: WhiteField(
                      controller: dateCtrl,
                      hint: "20-12-2025 - 20-12-2025",
                      onTap: () async {},
                    ),
                  ),
                  SizedBox(
                    width: isTight ? min(w, 420) : orgW,
                    height: inputH,
                    child: WhiteDropdown(
                      value: organization,
                      hint: "Select organization",
                      items: const ["Select organization", "Org A", "Org B"],
                      onChanged: (v) =>
                          onOrganizationChanged(v ?? organization),
                    ),
                  ),
                  SizedBox(
                    width: isTight ? min(w, 420) : staffW,
                    height: inputH,
                    child: WhiteDropdown(
                      value: staff,
                      hint: "Select Staff",
                      items: const ["Select Staff", "Aleena Monica", "Liz"],
                      onChanged: (v) => onStaffChanged(v ?? staff),
                    ),
                  ),
                  SizedBox(
                    width: isTight ? min(w, 420) : apprW,
                    height: inputH,
                    child: WhiteDropdown(
                      value: approval,
                      hint: "Select Approved/Unapprove",
                      items: const [
                        "Select Approved/Unapprove",
                        "Approved",
                        "Unapproved",
                      ],
                      onChanged: (v) => onApprovalChanged(v ?? approval),
                    ),
                  ),
                  SizedBox(
                    width: isTight ? min(w, 420) : sortW,
                    height: inputH,
                    child: WhiteDropdown(
                      value: sort,
                      hint: "Date desc",
                      items: const ["Date desc", "Date asc"],
                      onChanged: (v) => onSortChanged(v ?? sort),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Buttons row (exact order/colors from screenshot)
              Wrap(
                spacing: 8,
                runSpacing: 10,
                children: [
                  SmallActionBtn(
                    label: "Find",
                    color: const Color(0xFFE91E63), // pink
                    onTap: onFind,
                  ),
                  SmallActionBtn(
                    label: "Clear All",
                    color: const Color(0xFF00B3A6), // teal
                    onTap: onClearAll,
                  ),
                  SmallActionBtn(
                    label: "Todays",
                    color: const Color(0xFFFF9800), // orange
                    onTap: onTodays,
                  ),
                  SmallActionBtn(
                    label: "Export",
                    color: const Color(0xFF2D2D2D), // dark
                    icon: Icons.file_download_outlined,
                    onTap: onExport,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class SmallActionBtn extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;
  final IconData? icon;

  const SmallActionBtn({
    super.key,
    required this.label,
    required this.color,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: icon == null
            ? const SizedBox(width: 0, height: 0)
            : Icon(icon, size: 16),
        label: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// TABLE (looks like screenshot)
/// ------------------------------------------------------------
class TimesheetTable extends StatelessWidget {
  final List<TimesheetRowData> rows;
  const TimesheetTable({super.key, required this.rows});

  @override
  Widget build(BuildContext context) {
    // total width of your columns (must match header+row SizedBox widths)
    const tableWidth = 1010.0; // 260+260+240+160+90 = 1010

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: tableWidth,
          child: Column(
            children: [
              const _TimesheetTableHeader(),
              const Divider(height: 1),

              // rows scroll vertically inside the fixed-width table
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: rows.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, i) => _TimesheetTableRow(row: rows[i]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimesheetTableHeader extends StatelessWidget {
  const _TimesheetTableHeader();

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 13,
      color: Color(0xFF3B3B3B),
    );

    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: const Color(0xFFF7F7F7),
      child: const Row(
        children: [
          SizedBox(width: 260, child: Text("Date", style: style)),
          SizedBox(width: 260, child: Text("Designation", style: style)),
          SizedBox(width: 240, child: Text("Organization", style: style)),
          SizedBox(width: 160, child: Text("Staff", style: style)),
          SizedBox(width: 90, child: Text("Status", style: style)),
        ],
      ),
    );
  }
}

class _TimesheetTableRow extends StatelessWidget {
  final TimesheetRowData row;
  const _TimesheetTableRow({required this.row});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 260,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  row.dateTitle,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 2),
                Text(
                  row.dateSub,
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 260,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  row.designationName,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 14,
                      color: Colors.deepOrange,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        row.designationAddress,
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 240,
            child: Text(
              row.organization,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(width: 160, child: Text(row.staff)),
          SizedBox(
            width: 90,
            child: Align(
              alignment: Alignment.centerLeft,
              child: StatusPill(text: row.status),
            ),
          ),
        ],
      ),
    );
  }
}

class StatusPill extends StatelessWidget {
  final String text;
  const StatusPill({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F0FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF2F6BFF),
          fontWeight: FontWeight.w800,
          fontSize: 12,
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// WHITE INPUTS (important fixes)
/// - Use `value:` (NOT initialValue)
/// - `isExpanded: true`
/// - `dropdownColor`
/// - set `menuMaxHeight`
/// ------------------------------------------------------------
class WhiteDropdown extends StatelessWidget {
  final String value;
  final String hint;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const WhiteDropdown({
    super.key,
    required this.value,
    required this.hint,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      dropdownColor: Colors.white,
      menuMaxHeight: 320,
      icon: const Icon(Icons.keyboard_arrow_down, size: 20),
      style: const TextStyle(color: Colors.black87, fontSize: 13),
      items: items
          .map(
            (e) => DropdownMenuItem<String>(
              value: e,
              child: Text(e, maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
          )
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class WhiteField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final VoidCallback? onTap;

  const WhiteField({
    super.key,
    required this.controller,
    required this.hint,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: onTap != null,
      onTap: onTap,
      style: const TextStyle(fontSize: 13),
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// DATA MODEL
/// ------------------------------------------------------------
class TimesheetRowData {
  final String dateTitle;
  final String dateSub;

  final String designationName;
  final String designationAddress;

  final String organization;
  final String staff;
  final String status;

  const TimesheetRowData({
    required this.dateTitle,
    required this.dateSub,
    required this.designationName,
    required this.designationAddress,
    required this.organization,
    required this.staff,
    required this.status,
  });
}
