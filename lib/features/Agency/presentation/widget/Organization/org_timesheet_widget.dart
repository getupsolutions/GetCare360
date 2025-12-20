import 'dart:math';

import 'package:flutter/material.dart';
import 'package:getcare360/features/Agency/presentation/screen/Organization/organization_timesheet.dart';

/// ------------------------------------------------------------
/// Header card
/// ------------------------------------------------------------
class TimesheetHeaderCard extends StatelessWidget {
  final bool isMobile;

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
  final VoidCallback onToday;
  final VoidCallback onExport;

  final VoidCallback onMobileFilters;

  const TimesheetHeaderCard({
    super.key,
    required this.isMobile,
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
    required this.onToday,
    required this.onExport,
    required this.onMobileFilters,
  });

  @override
  Widget build(BuildContext context) {
    const purple = OrganizationTimesheetPage.purple;

    return Container(
      decoration: BoxDecoration(
        color: purple,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      child: Column(
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

          if (isMobile) ...[
            // ✅ Mobile: date + Filters button (dialog)
            Row(
              children: [
                Expanded(
                  child: WhiteField(
                    controller: dateCtrl,
                    hint: "Date range",
                    suffix: const Icon(Icons.calendar_month, size: 18),
                    onTap: () async {},
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 40,
                  child: ElevatedButton.icon(
                    onPressed: onMobileFilters,
                    icon: const Icon(Icons.tune, size: 18),
                    label: const Text(
                      "Filters",
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: purple,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // ✅ actions
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                MiniBtn(
                  label: "Find",
                  color: const Color(0xFFE91E63),
                  onTap: onFind,
                ),
                MiniBtn(
                  label: "Clear All",
                  color: const Color(0xFF00B3A6),
                  onTap: onClearAll,
                ),
                MiniBtn(
                  label: "Todays",
                  color: const Color(0xFFFF9800),
                  onTap: onToday,
                ),
                MiniBtn(
                  label: "Export",
                  color: const Color(0xFF2D2D2D),
                  onTap: onExport,
                  icon: Icons.file_download_outlined,
                ),
              ],
            ),
            const SizedBox(height: 10),

            // small summary
            MobileSummary(
              organization: organization,
              staff: staff,
              approval: approval,
              sort: sort,
            ),
          ] else ...[
            // ✅ Desktop/Tablet: inline fields
            LayoutBuilder(
              builder: (context, c) {
                final w = c.maxWidth;
                const gap = 10.0;

                return Wrap(
                  spacing: gap,
                  runSpacing: gap,
                  children: [
                    SizedBox(
                      width: 220,
                      height: 40,
                      child: WhiteField(
                        controller: dateCtrl,
                        hint: "Date range",
                        onTap: () async {},
                      ),
                    ),
                    SizedBox(
                      width: 210,
                      height: 40,
                      child: WhiteDropdown(
                        value: organization,
                        hint: "Select organization",
                        items: const ["Select organization", "Org A", "Org B"],
                        onChanged: (v) =>
                            onOrganizationChanged(v ?? organization),
                      ),
                    ),
                    SizedBox(
                      width: 210,
                      height: 40,
                      child: WhiteDropdown(
                        value: staff,
                        hint: "Select Staff",
                        items: const ["Select Staff", "Aleena Monica", "Liz"],
                        onChanged: (v) => onStaffChanged(v ?? staff),
                      ),
                    ),
                    SizedBox(
                      width: 220,
                      height: 40,
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
                      width: min(220, w),
                      height: 40,
                      child: WhiteDropdown(
                        value: sort,
                        hint: "Date desc",
                        items: const ["Date desc", "Date asc"],
                        onChanged: (v) => onSortChanged(v ?? sort),
                      ),
                    ),
                    MiniBtn(
                      label: "Find",
                      color: const Color(0xFFE91E63),
                      onTap: onFind,
                    ),
                    MiniBtn(
                      label: "Clear All",
                      color: const Color(0xFF00B3A6),
                      onTap: onClearAll,
                    ),
                    MiniBtn(
                      label: "Todays",
                      color: const Color(0xFFFF9800),
                      onTap: onToday,
                    ),
                    MiniBtn(
                      label: "Export",
                      color: const Color(0xFF2D2D2D),
                      onTap: onExport,
                      icon: Icons.file_download_outlined,
                    ),
                  ],
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}

class MobileSummary extends StatelessWidget {
  final String organization;
  final String staff;
  final String approval;
  final String sort;

  const MobileSummary({
    super.key,
    required this.organization,
    required this.staff,
    required this.approval,
    required this.sort,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(112),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withAlpha(118)),
      ),
      child: DefaultTextStyle(
        style: const TextStyle(color: Colors.white, fontSize: 12.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Current filters:",
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 6),
            Text("• Org: $organization"),
            Text("• Staff: $staff"),
            Text("• Approval: $approval"),
            Text("• Sort: $sort"),
          ],
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// Filters Dialog (Mobile)
/// ------------------------------------------------------------
class TimesheetFiltersDialog extends StatefulWidget {
  final TimesheetFilters initial;
  const TimesheetFiltersDialog({super.key, required this.initial});

  @override
  State<TimesheetFiltersDialog> createState() => TimesheetFiltersDialogState();
}

class TimesheetFiltersDialogState extends State<TimesheetFiltersDialog> {
  late TextEditingController dateCtrl;
  late String organization;
  late String staff;
  late String approval;
  late String sort;

  @override
  void initState() {
    super.initState();
    dateCtrl = TextEditingController(text: widget.initial.dateRange);
    organization = widget.initial.organization;
    staff = widget.initial.staff;
    approval = widget.initial.approval;
    sort = widget.initial.sort;
  }

  @override
  void dispose() {
    dateCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const purple = OrganizationTimesheetPage.purple;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Filters",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 6),

              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      DialogField(
                        label: "Date Range",
                        child: WhiteField(
                          controller: dateCtrl,
                          hint: "Date range",
                          suffix: const Icon(Icons.calendar_month, size: 18),
                          onTap: () async {},
                        ),
                      ),
                      const SizedBox(height: 10),
                      DialogField(
                        label: "Organization",
                        child: WhiteDropdown(
                          value: organization,
                          hint: "Select organization",
                          items: const [
                            "Select organization",
                            "Org A",
                            "Org B",
                          ],
                          onChanged: (v) =>
                              setState(() => organization = v ?? organization),
                        ),
                      ),
                      const SizedBox(height: 10),
                      DialogField(
                        label: "Staff",
                        child: WhiteDropdown(
                          value: staff,
                          hint: "Select Staff",
                          items: const ["Select Staff", "Aleena Monica", "Liz"],
                          onChanged: (v) => setState(() => staff = v ?? staff),
                        ),
                      ),
                      const SizedBox(height: 10),
                      DialogField(
                        label: "Approval",
                        child: WhiteDropdown(
                          value: approval,
                          hint: "Select Approved/Unapprove",
                          items: const [
                            "Select Approved/Unapprove",
                            "Approved",
                            "Unapproved",
                          ],
                          onChanged: (v) =>
                              setState(() => approval = v ?? approval),
                        ),
                      ),
                      const SizedBox(height: 10),
                      DialogField(
                        label: "Sort",
                        child: WhiteDropdown(
                          value: sort,
                          hint: "Date desc",
                          items: const ["Date desc", "Date asc"],
                          onChanged: (v) => setState(() => sort = v ?? sort),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          dateCtrl.text = "20-12-2025 - 20-12-2025";
                          organization = "Select organization";
                          staff = "Select Staff";
                          approval = "Select Approved/Unapprove";
                          sort = "Date desc";
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Reset"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                          TimesheetFilters(
                            dateRange: dateCtrl.text,
                            organization: organization,
                            staff: staff,
                            approval: approval,
                            sort: sort,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: purple,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Apply",
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DialogField extends StatelessWidget {
  final String label;
  final Widget child;

  const DialogField({super.key, required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6),
        SizedBox(height: 44, child: child),
      ],
    );
  }
}

class TimesheetFilters {
  final String dateRange;
  final String organization;
  final String staff;
  final String approval;
  final String sort;

  const TimesheetFilters({
    required this.dateRange,
    required this.organization,
    required this.staff,
    required this.approval,
    required this.sort,
  });
}

/// ------------------------------------------------------------
/// Table (Desktop/Tablet)
/// ------------------------------------------------------------
class TimesheetTable extends StatelessWidget {
  final List<TimesheetRowData> rows;
  const TimesheetTable({super.key, required this.rows});

  @override
  Widget build(BuildContext context) {
    // table width like screenshot; allow scroll if smaller window
    const tableMinWidth = 980.0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const TableHeader(),
          const Divider(height: 1),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: tableMinWidth,
                child: ListView.separated(
                  itemCount: rows.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, i) => TableRow(row: rows[i]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TableHeader extends StatelessWidget {
  const TableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 13,
      color: Color(0xFF3B3B3B),
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      color: const Color(0xFFF7F7F7),
      child: const Row(
        children: [
          SizedBox(width: 220, child: Text("Date", style: style)),
          SizedBox(width: 220, child: Text("Designation", style: style)),
          SizedBox(width: 220, child: Text("Organization", style: style)),
          SizedBox(width: 170, child: Text("Staff", style: style)),
          SizedBox(width: 120, child: Text("Status", style: style)),
        ],
      ),
    );
  }
}

class TableRow extends StatelessWidget {
  final TimesheetRowData row;
  const TableRow({super.key, required this.row});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 220,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  row.dateTitle,
                  style: const TextStyle(fontWeight: FontWeight.w800),
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
            width: 220,
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
            width: 220,
            child: Text(
              row.organization,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(width: 170, child: Text(row.staff)),
          SizedBox(
            width: 120,
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F0FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF2F6BFF),
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// Mobile list cards
/// ------------------------------------------------------------
class TimesheetMobileList extends StatelessWidget {
  final List<TimesheetRowData> rows;
  const TimesheetMobileList({super.key, required this.rows});

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(child: Text("No records")),
      );
    }

    return Column(
      children: [
        for (final r in rows) ...[
          TimesheetCard(row: r),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class TimesheetCard extends StatelessWidget {
  final TimesheetRowData row;
  const TimesheetCard({super.key, required this.row});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            row.dateTitle,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
          ),
          const SizedBox(height: 4),
          Text(row.dateSub, style: const TextStyle(color: Colors.black54)),
          const SizedBox(height: 12),
          kv("Designation", row.designationName),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_on, size: 16, color: Colors.deepOrange),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  row.designationAddress,
                  style: const TextStyle(color: Colors.black87, height: 1.3),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          kv("Organization", row.organization),
          const SizedBox(height: 6),
          kv("Staff", row.staff),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: StatusPill(text: row.status),
          ),
        ],
      ),
    );
  }

  Widget kv(String k, String v) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black87, height: 1.2),
        children: [
          TextSpan(
            text: "$k: ",
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          TextSpan(text: v),
        ],
      ),
    );
  }
}

/// ------------------------------------------------------------
/// Small buttons like screenshot
/// ------------------------------------------------------------
class MiniBtn extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;
  final IconData? icon;

  const MiniBtn({
    super.key,
    required this.label,
    required this.color,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon ?? Icons.circle, size: icon == null ? 0 : 16),
        label: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// White inputs (fix dropdown click issue)
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
      initialValue: value,
      isExpanded: true,
      dropdownColor: Colors.white,
      menuMaxHeight: 300,
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
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class WhiteField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Widget? suffix;
  final VoidCallback? onTap;

  const WhiteField({
    super.key,
    required this.controller,
    required this.hint,
    this.suffix,
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
        suffixIcon: suffix == null
            ? null
            : Padding(padding: const EdgeInsets.only(right: 6), child: suffix),
        suffixIconConstraints: const BoxConstraints(
          minHeight: 40,
          minWidth: 40,
        ),
        filled: true,
        fillColor: Colors.white,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// Data model
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
