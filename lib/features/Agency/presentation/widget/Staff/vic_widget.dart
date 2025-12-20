import 'dart:math';

import 'package:flutter/material.dart';

class StaffFiltersModel {
  final String accountStatus;
  final String staffType;
  final String staffStage;
  final String group;
  final String sort;
  final String locationGroup;

  const StaffFiltersModel({
    required this.accountStatus,
    required this.staffType,
    required this.staffStage,
    required this.group,
    required this.sort,
    required this.locationGroup,
  });
}

class MobileFilterSheet extends StatefulWidget {
  final TextEditingController nameCtrl;

  final String accountStatus;
  final String staffType;
  final String staffStage;
  final String group;
  final String sort;
  final String locationGroup;

  final ValueChanged<StaffFiltersModel> onChanged;
  final VoidCallback onClearAll;
  final VoidCallback onFind;

  const MobileFilterSheet({
    super.key,
    required this.nameCtrl,
    required this.accountStatus,
    required this.staffType,
    required this.staffStage,
    required this.group,
    required this.sort,
    required this.locationGroup,
    required this.onChanged,
    required this.onClearAll,
    required this.onFind,
  });

  @override
  State<MobileFilterSheet> createState() => MobileFilterSheetState();
}

class MobileFilterSheetState extends State<MobileFilterSheet> {
  late String accountStatus;
  late String staffType;
  late String staffStage;
  late String group;
  late String sort;
  late String locationGroup;

  @override
  void initState() {
    super.initState();
    accountStatus = widget.accountStatus;
    staffType = widget.staffType;
    staffStage = widget.staffStage;
    group = widget.group;
    sort = widget.sort;
    locationGroup = widget.locationGroup;
  }

  void apply() {
    widget.onChanged(
      StaffFiltersModel(
        accountStatus: accountStatus,
        staffType: staffType,
        staffStage: staffStage,
        group: group,
        sort: sort,
        locationGroup: locationGroup,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(14, 14, 14, 14 + bottomInset),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "Filters",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 8),

            field(
              "Account Status",
              WhiteDropdown(
                value: accountStatus,
                hint: "Account Status",
                items: const ["Account Status", "Active", "Inactive"],
                onChanged: (v) => setState(() => accountStatus = v),
              ),
            ),
            const SizedBox(height: 10),

            field(
              "Staff type",
              WhiteDropdown(
                value: staffType,
                hint: "Staff type",
                items: const ["Staff type", "PCA", "Nurse", "Support"],
                onChanged: (v) => setState(() => staffType = v),
              ),
            ),
            const SizedBox(height: 10),

            field(
              "Staff Stage",
              WhiteDropdown(
                value: staffStage,
                hint: "Staff Stage",
                items: const ["Staff Stage", "Stage 1", "Stage 2"],
                onChanged: (v) => setState(() => staffStage = v),
              ),
            ),
            const SizedBox(height: 10),

            field(
              "Select a group",
              WhiteDropdown(
                value: group,
                hint: "Select a group",
                items: const ["Select a group", "Group A", "Group B"],
                onChanged: (v) => setState(() => group = v),
              ),
            ),
            const SizedBox(height: 10),

            field(
              "Sort",
              WhiteDropdown(
                value: sort,
                hint: "Name A-Z",
                items: const ["Name A-Z", "Name Z-A"],
                onChanged: (v) => setState(() => sort = v),
              ),
            ),
            const SizedBox(height: 10),

            field(
              "Location Group",
              WhiteDropdown(
                value: locationGroup,
                hint: "Select Location Group",
                items: const [
                  "Select Location Group",
                  "Location A",
                  "Location B",
                ],
                onChanged: (v) => setState(() => locationGroup = v),
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      widget.onClearAll();
                      Navigator.pop(context);
                    },
                    child: const Text("Clear All"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      apply();
                      widget.onFind();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8E24AA),
                      foregroundColor: Colors.white,
                      elevation: 0,
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
    );
  }

  Widget field(String label, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
        const SizedBox(height: 6),
        SizedBox(height: 44, child: child),
      ],
    );
  }
}

class ActionButtons extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onMail;

  const ActionButtons({
    required this.onEdit,
    required this.onDelete,
    required this.onMail,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MiniActionBtn(
          label: "Edit",
          color: const Color(0xFF8BC34A),
          icon: Icons.edit,
          onTap: onEdit,
        ),
        const SizedBox(height: 8),
        MiniActionBtn(
          label: "Delete",
          color: const Color(0xFFFF5252),
          icon: Icons.delete,
          onTap: onDelete,
        ),
        const SizedBox(height: 8),
        MiniActionBtn(
          label: "Mail",
          color: const Color(0xFF00B3A6),
          icon: Icons.mail,
          onTap: onMail,
        ),
      ],
    );
  }
}

class MiniActionBtn extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  const MiniActionBtn({
    required this.label,
    required this.color,
    required this.icon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28,
      width: 90,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 14, color: Colors.white),
        label: Text(
          label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
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
        color: const Color(0xFFCFF6F3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF00A79D),
          fontWeight: FontWeight.w900,
          fontSize: 11.5,
        ),
      ),
    );
  }
}

class Badge extends StatelessWidget {
  final String text;
  final Color color;
  const Badge({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withAlpha(114),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w900,
          fontSize: 11,
        ),
      ),
    );
  }
}

class WhiteTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Widget? prefix;

  const WhiteTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.prefix,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(fontSize: 13),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: prefix,
        filled: true,
        fillColor: Colors.white,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class WhiteDropdown extends StatelessWidget {
  final String value;
  final String hint;
  final List<String> items;
  final ValueChanged<String> onChanged;
  final Color bg;
  final double borderRadius;

  const WhiteDropdown({
    super.key,
    required this.value,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.bg = Colors.white,
    this.borderRadius = 6,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      dropdownColor: Colors.white,
      menuMaxHeight: 320,
      icon: const Icon(Icons.keyboard_arrow_down, size: 20),
      style: const TextStyle(color: Colors.black87, fontSize: 13),
      items: items
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(e, maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
          )
          .toList(),
      onChanged: (v) {
        if (v != null) onChanged(v);
      },
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: bg,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class SmallBtn extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;
  final IconData? icon;

  const SmallBtn({
    super.key,
    required this.label,
    required this.color,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: icon == null
            ? const SizedBox.shrink()
            : Icon(icon, size: 16, color: Colors.white),
        label: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
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

class StaffRow {
  final int sl;
  final String staffId;
  final String name;
  final String badgeText;
  final Color badgeColor;

  final String contactEmail;
  final String contactPhone;
  final String staffType;
  final String staffGroup;
  final String state;
  final String status;
  final String regDate;

  const StaffRow({
    required this.sl,
    required this.staffId,
    required this.name,
    required this.badgeText,
    required this.badgeColor,
    required this.contactEmail,
    required this.contactPhone,
    required this.staffType,
    required this.staffGroup,
    required this.state,
    required this.status,
    required this.regDate,
  });
}

class StaffMobileList extends StatelessWidget {
  final List<StaffRow> rows;
  const StaffMobileList({super.key, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final r in rows) ...[
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        r.name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    StatusPill(text: r.status),
                  ],
                ),
                const SizedBox(height: 6),
                Badge(text: r.badgeText, color: r.badgeColor),
                const SizedBox(height: 10),

                kv("StaffId", r.staffId),
                kv("Contact", "${r.contactEmail}\n${r.contactPhone}"),
                kv("Staff type", r.staffType),
                kv("Group", r.staffGroup),
                kv("State", r.state),
                kv("Reg. Date", r.regDate),
                const SizedBox(height: 12),

                ActionButtons(onEdit: () {}, onDelete: () {}, onMail: () {}),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }

  Widget kv(String k, String v) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black87, height: 1.25),
          children: [
            TextSpan(
              text: "$k: ",
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
            TextSpan(text: v),
          ],
        ),
      ),
    );
  }
}

class StaffTable extends StatelessWidget {
  final List<StaffRow> rows;
  const StaffTable({super.key, required this.rows});

  @override
  Widget build(BuildContext context) {
    const tableWidth = 1160.0;

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
              const StaffTableHeader(),
              const Divider(height: 1),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: rows.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, i) => StaffTableRow(row: rows[i]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StaffTableHeader extends StatelessWidget {
  const StaffTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 13,
      color: Color(0xFF3B3B3B),
    );

    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      color: const Color(0xFFF7F7F7),
      child: const Row(
        children: [
          SizedBox(width: 40, child: Text("SL\nNo.", style: style)),
          SizedBox(width: 80, child: Text("StaffId", style: style)),
          SizedBox(width: 170, child: Text("Name", style: style)),
          SizedBox(width: 160, child: Text("Contact", style: style)),
          SizedBox(width: 210, child: Text("Staff type", style: style)),
          SizedBox(width: 160, child: Text("Staff Group", style: style)),
          SizedBox(width: 120, child: Text("State", style: style)),
          SizedBox(width: 90, child: Text("Status", style: style)),
          SizedBox(width: 130, child: Text("Action", style: style)),
        ],
      ),
    );
  }
}

class StaffTableRow extends StatelessWidget {
  final StaffRow row;
  const StaffTableRow({super.key, required this.row});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 40, child: Text("${row.sl}")),
          SizedBox(
            width: 80,
            child: Column(
              children: [
                Checkbox(value: false, onChanged: (_) {}),
                const SizedBox(height: 6),
                Text(row.staffId),
              ],
            ),
          ),
          SizedBox(
            width: 170,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  row.name,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 6),
                Badge(text: row.badgeText, color: row.badgeColor),
              ],
            ),
          ),
          SizedBox(
            width: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  row.contactEmail,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(row.contactPhone),
              ],
            ),
          ),
          SizedBox(width: 210, child: Text(row.staffType)),
          SizedBox(
            width: 160,
            child: Text(
              row.staffGroup,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 120, child: Text(row.state)),
          SizedBox(
            width: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StatusPill(text: row.status),
                const SizedBox(height: 6),
                Text(
                  row.regDate,
                  style: const TextStyle(color: Colors.black45),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 130,
            child: ActionButtons(onEdit: () {}, onDelete: () {}, onMail: () {}),
          ),
        ],
      ),
    );
  }
}

class BulkActionBar extends StatelessWidget {
  final bool checkAll;
  final ValueChanged<bool> onCheckAllChanged;

  final String bulkActionValue;
  final ValueChanged<String> onBulkActionChanged;

  final int total;
  final VoidCallback onGo;

  const BulkActionBar({
    super.key,
    required this.checkAll,
    required this.onCheckAllChanged,
    required this.bulkActionValue,
    required this.onBulkActionChanged,
    required this.total,
    required this.onGo,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final w = c.maxWidth;
        final isMobile = w < 700;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: checkAll,
                    onChanged: (v) => onCheckAllChanged(v ?? false),
                  ),
                  const Text(
                    "Check All",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),

              SizedBox(
                width: isMobile ? min(w, 320) : 320,
                height: 40,
                child: WhiteDropdown(
                  value: bulkActionValue,
                  hint: "Choose an bulk action",
                  items: const [
                    "Choose an bulk action",
                    "Activate",
                    "Deactivate",
                    "Delete",
                  ],
                  onChanged: onBulkActionChanged,
                  bg: Colors.white,
                  borderRadius: 6,
                ),
              ),

              SizedBox(
                height: 36,
                width: 40,
                child: ElevatedButton(
                  onPressed: onGo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEDE7FF),
                    foregroundColor: const Color(0xFF7C4DFF),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text(
                    "GO",
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),

              SizedBox(
                width: isMobile ? w : null,
                child: Align(
                  alignment: isMobile
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Text(
                    "Total Result: $total",
                    style: const TextStyle(fontWeight: FontWeight.w800),
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

class StaffHeaderCard extends StatelessWidget {
  final String title;
  final bool isMobile;

  final TextEditingController nameCtrl;

  final String accountStatus;
  final String staffType;
  final String staffStage;
  final String group;
  final String sort;
  final String locationGroup;

  final ValueChanged<String> onAccountStatusChanged;
  final ValueChanged<String> onStaffTypeChanged;
  final ValueChanged<String> onStaffStageChanged;
  final ValueChanged<String> onGroupChanged;
  final ValueChanged<String> onSortChanged;
  final ValueChanged<String> onLocationGroupChanged;

  final VoidCallback onFind;
  final VoidCallback onClearAll;
  final VoidCallback onAddNew;
  final VoidCallback onOpenMobileFilters;

  const StaffHeaderCard({
    super.key,
    required this.title,
    required this.isMobile,
    required this.nameCtrl,
    required this.accountStatus,
    required this.staffType,
    required this.staffStage,
    required this.group,
    required this.sort,
    required this.locationGroup,
    required this.onAccountStatusChanged,
    required this.onStaffTypeChanged,
    required this.onStaffStageChanged,
    required this.onGroupChanged,
    required this.onSortChanged,
    required this.onLocationGroupChanged,
    required this.onFind,
    required this.onClearAll,
    required this.onAddNew,
    required this.onOpenMobileFilters,
  });

  static const purple = Color(0xFF8E24AA);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: purple,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      child: LayoutBuilder(
        builder: (context, c) {
          final w = c.maxWidth;
          final inputH = 40.0;

          if (isMobile) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: WhiteTextField(
                        controller: nameCtrl,
                        hint: "First name, Middle name",
                        prefix: const Icon(Icons.search, size: 18),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      height: inputH,
                      child: ElevatedButton.icon(
                        onPressed: onOpenMobileFilters,
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
                Wrap(
                  spacing: 8,
                  runSpacing: 10,
                  children: [
                    SmallBtn(
                      label: "Find",
                      color: const Color(0xFFE91E63),
                      onTap: onFind,
                    ),
                    SmallBtn(
                      label: "Clear All",
                      color: const Color(0xFF00B3A6),
                      onTap: onClearAll,
                    ),
                    SmallBtn(
                      label: "Add New",
                      color: const Color(0xFF7C4DFF),
                      icon: Icons.add,
                      onTap: onAddNew,
                    ),
                  ],
                ),
              ],
            );
          }

          // Desktop / Web (2 rows like screenshot)
          final colW = (w - 40) / 5; // 5 items per row-ish
          final boxW = max(180.0, min(220.0, colW));

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),

              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  SizedBox(
                    width: boxW,
                    height: inputH,
                    child: WhiteTextField(
                      controller: nameCtrl,
                      hint: "First name, Middle name",
                      prefix: const Icon(Icons.search, size: 18),
                    ),
                  ),
                  SizedBox(
                    width: boxW,
                    height: inputH,
                    child: WhiteDropdown(
                      value: accountStatus,
                      hint: "Account Status",
                      items: const ["Account Status", "Active", "Inactive"],
                      onChanged: (v) => onAccountStatusChanged(v),
                    ),
                  ),
                  SizedBox(
                    width: boxW,
                    height: inputH,
                    child: WhiteDropdown(
                      value: staffType,
                      hint: "Staff type",
                      items: const ["Staff type", "PCA", "Nurse", "Support"],
                      onChanged: (v) => onStaffTypeChanged(v),
                    ),
                  ),
                  SizedBox(
                    width: boxW,
                    height: inputH,
                    child: WhiteDropdown(
                      value: staffStage,
                      hint: "Staff Stage",
                      items: const ["Staff Stage", "Stage 1", "Stage 2"],
                      onChanged: (v) => onStaffStageChanged(v),
                    ),
                  ),
                  SizedBox(
                    width: boxW,
                    height: inputH,
                    child: WhiteDropdown(
                      value: group,
                      hint: "Select a group",
                      items: const ["Select a group", "Group A", "Group B"],
                      onChanged: (v) => onGroupChanged(v),
                    ),
                  ),

                  // row 2
                  SizedBox(
                    width: boxW,
                    height: inputH,
                    child: WhiteDropdown(
                      value: sort,
                      hint: "Name A-Z",
                      items: const ["Name A-Z", "Name Z-A"],
                      onChanged: (v) => onSortChanged(v),
                    ),
                  ),
                  SizedBox(
                    width: boxW,
                    height: inputH,
                    child: WhiteDropdown(
                      value: locationGroup,
                      hint: "Select Location Group",
                      items: const [
                        "Select Location Group",
                        "Location A",
                        "Location B",
                      ],
                      onChanged: (v) => onLocationGroupChanged(v),
                    ),
                  ),

                  SizedBox(
                    height: inputH,
                    child: SmallBtn(
                      label: "Find",
                      color: const Color(0xFFE91E63),
                      onTap: onFind,
                    ),
                  ),
                  SizedBox(
                    height: inputH,
                    child: SmallBtn(
                      label: "Clear All",
                      color: const Color(0xFF00B3A6),
                      onTap: onClearAll,
                    ),
                  ),
                  SizedBox(
                    height: inputH,
                    child: SmallBtn(
                      label: "Add New",
                      color: const Color(0xFF7C4DFF),
                      icon: Icons.add,
                      onTap: onAddNew,
                    ),
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
