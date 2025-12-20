import 'package:flutter/material.dart';
import 'package:getcare360/features/Agency/presentation/screen/Staff/staff_archive.dart';

/// ------------------------------------------------------------
/// Header (Purple) - matches screenshot
/// ------------------------------------------------------------
class StaffArchiveHeader extends StatelessWidget {
  final TextEditingController searchCtrl;
  final String accountStatus;

  final ValueChanged<String> onAccountStatusChanged;
  final VoidCallback onFind;
  final VoidCallback onClearAll;

  const StaffArchiveHeader({
    super.key,
    required this.searchCtrl,
    required this.accountStatus,
    required this.onAccountStatusChanged,
    required this.onFind,
    required this.onClearAll,
  });

  static const purple = StaffArchivePageState.purple;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: purple,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: LayoutBuilder(
        builder: (context, c) {
          final w = c.maxWidth;
          final isMobile = w < 750;

          final inputH = 40.0;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                child: Text(
                  "Staff Management",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),

              if (!isMobile) ...[
                SizedBox(
                  width: 210,
                  height: inputH,
                  child: WhiteSearchField(controller: searchCtrl),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 210,
                  height: inputH,
                  child: WhiteDropdown(
                    value: accountStatus,
                    hint: "Account Status",
                    items: const [
                      "Account Status",
                      "Active",
                      "Pending",
                      "Inactive",
                    ],
                    onChanged: onAccountStatusChanged,
                  ),
                ),
                const SizedBox(width: 10),
                SmallBtn(
                  label: "Find",
                  color: const Color(0xFFE91E63),
                  onTap: onFind,
                ),
                const SizedBox(width: 8),
                SmallBtn(
                  label: "Clear All",
                  color: const Color(0xFF00B3A6),
                  onTap: onClearAll,
                ),
              ] else ...[
                // Mobile: show compact actions (Filters in sheet)
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      builder: (_) => MobileArchiveFilters(
                        searchCtrl: searchCtrl,
                        accountStatus: accountStatus,
                        onAccountStatusChanged: onAccountStatusChanged,
                        onFind: onFind,
                        onClearAll: onClearAll,
                      ),
                    );
                  },
                  icon: const Icon(Icons.tune, color: Colors.white),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class MobileArchiveFilters extends StatelessWidget {
  final TextEditingController searchCtrl;
  final String accountStatus;
  final ValueChanged<String> onAccountStatusChanged;
  final VoidCallback onFind;
  final VoidCallback onClearAll;

  const MobileArchiveFilters({
    super.key,
    required this.searchCtrl,
    required this.accountStatus,
    required this.onAccountStatusChanged,
    required this.onFind,
    required this.onClearAll,
  });

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(14, 14, 14, 14 + bottomInset),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
          const SizedBox(height: 10),
          SizedBox(height: 44, child: WhiteSearchField(controller: searchCtrl)),
          const SizedBox(height: 10),
          SizedBox(
            height: 44,
            child: WhiteDropdown(
              value: accountStatus,
              hint: "Account Status",
              items: const ["Account Status", "Active", "Pending", "Inactive"],
              onChanged: onAccountStatusChanged,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    onClearAll();
                    Navigator.pop(context);
                  },
                  child: const Text("Clear All"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    onFind();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: StaffArchivePageState.purple,
                    foregroundColor: Colors.white,
                    elevation: 0,
                  ),
                  child: const Text(
                    "Find",
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// ------------------------------------------------------------
/// White table card (Total result + table/list)
/// ------------------------------------------------------------
class StaffArchiveTableCard extends StatelessWidget {
  final int total;
  final List<StaffArchiveRow> rows;
  final bool isDesktop;

  const StaffArchiveTableCard({
    super.key,
    required this.total,
    required this.rows,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Total result bar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: const Color(0xFFF7F7F7),
            child: Text(
              "Total Result: $total",
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
          const Divider(height: 1),

          if (isDesktop)
            ArchiveTable(rows: rows)
          else
            ArchiveMobileList(rows: rows),
        ],
      ),
    );
  }
}

class ArchiveTable extends StatelessWidget {
  final List<StaffArchiveRow> rows;
  const ArchiveTable({super.key, required this.rows});

  @override
  Widget build(BuildContext context) {
    // keep table like web, add horizontal scroll fallback
    const minTableWidth = 1080.0;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: minTableWidth,
        child: Column(
          children: [
            const ArchiveTableHeader(),
            const Divider(height: 1),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: rows.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, i) => ArchiveTableRow(row: rows[i]),
            ),
          ],
        ),
      ),
    );
  }
}

class ArchiveTableHeader extends StatelessWidget {
  const ArchiveTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 13,
      color: Color(0xFF3B3B3B),
    );

    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: const Color(0xFFF7F7F7),
      child: const Row(
        children: [
          SizedBox(width: 180, child: Text("Name", style: style)),
          SizedBox(width: 260, child: Text("Contact", style: style)),
          SizedBox(width: 300, child: Text("Staff type", style: style)),
          SizedBox(width: 120, child: Text("State", style: style)),
          SizedBox(width: 90, child: Text("Reg.\nDate", style: style)),
          SizedBox(width: 110, child: Text("Status", style: style)),
          SizedBox(width: 120, child: Text("Action", style: style)),
        ],
      ),
    );
  }
}

class ArchiveTableRow extends StatelessWidget {
  final StaffArchiveRow row;
  const ArchiveTableRow({super.key, required this.row});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  row.name,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                if (row.nameBadge != null) ...[
                  const SizedBox(height: 6),
                  NameBadge(text: row.nameBadge!),
                ],
              ],
            ),
          ),
          SizedBox(
            width: 260,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(row.contactEmail),
                const SizedBox(height: 4),
                Text(row.contactPhone),
              ],
            ),
          ),
          SizedBox(width: 300, child: Text(row.staffType)),
          SizedBox(width: 120, child: Text(row.state)),
          SizedBox(
            width: 90,
            child: Text(
              row.regDate,
              style: const TextStyle(color: Colors.black45),
            ),
          ),
          SizedBox(width: 110, child: StatusPill(text: row.status)),
          SizedBox(
            width: 120,
            child: Column(
              children: [
                ActionBtn(
                  label: "Restore",
                  color: const Color(0xFF00B3A6),
                  icon: Icons.undo,
                  onTap: () {},
                ),
                const SizedBox(height: 8),
                ActionBtn(
                  label: "Delete",
                  color: const Color(0xFFFF5252),
                  icon: Icons.delete_outline,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// ------------------------------------------------------------
/// Mobile list layout
/// ------------------------------------------------------------
class ArchiveMobileList extends StatelessWidget {
  final List<StaffArchiveRow> rows;
  const ArchiveMobileList({super.key, required this.rows});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: rows.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, i) {
        final r = rows[i];
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFEDEFF5)),
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
              if (r.nameBadge != null) ...[
                const SizedBox(height: 8),
                NameBadge(text: r.nameBadge!),
              ],
              const SizedBox(height: 10),
              kv("Email", r.contactEmail),
              kv("Phone", r.contactPhone),
              kv("Staff Type", r.staffType),
              kv("State", r.state),
              kv("Reg Date", r.regDate),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ActionBtn(
                      label: "Restore",
                      color: const Color(0xFF00B3A6),
                      icon: Icons.undo,
                      onTap: () {},
                      expanded: true,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ActionBtn(
                      label: "Delete",
                      color: const Color(0xFFFF5252),
                      icon: Icons.delete_outline,
                      onTap: () {},
                      expanded: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
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

/// ------------------------------------------------------------
/// Small UI helpers
/// ------------------------------------------------------------
class WhiteSearchField extends StatelessWidget {
  final TextEditingController controller;
  const WhiteSearchField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(fontSize: 13),
      decoration: InputDecoration(
        hintText: "Search...",
        prefixIcon: const Icon(Icons.search, size: 18),
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

class WhiteDropdown extends StatelessWidget {
  final String value;
  final String hint;
  final List<String> items;
  final ValueChanged<String> onChanged;

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
      onChanged: (v) {
        if (v != null) onChanged(v);
      },
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

class SmallBtn extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const SmallBtn({
    super.key,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
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
    final bool isPending = text.toLowerCase() == "pending";

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isPending ? const Color(0xFFFFF1CC) : const Color(0xFFCFF6F3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isPending ? const Color(0xFFFFA000) : const Color(0xFF00A79D),
          fontWeight: FontWeight.w900,
          fontSize: 11.5,
        ),
      ),
    );
  }
}

class ActionBtn extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;
  final bool expanded;

  const ActionBtn({
    super.key,
    required this.label,
    required this.color,
    required this.icon,
    required this.onTap,
    this.expanded = false,
  });

  @override
  Widget build(BuildContext context) {
    final child = ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 16, color: Colors.white),
      label: Text(
        label,
        style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w900),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
    );

    return SizedBox(
      height: 32,
      width: expanded ? double.infinity : 110,
      child: child,
    );
  }
}

class NameBadge extends StatelessWidget {
  final String text;
  const NameBadge({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFD8E8FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF2F6BFF),
          fontWeight: FontWeight.w900,
          fontSize: 11,
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// Data model
/// ------------------------------------------------------------
class StaffArchiveRow {
  final String name;
  final String? nameBadge; // e.g. "Approval Pending"
  final String contactEmail;
  final String contactPhone;
  final String staffType;
  final String state;
  final String regDate;
  final String status;

  const StaffArchiveRow({
    required this.name,
    this.nameBadge,
    required this.contactEmail,
    required this.contactPhone,
    required this.staffType,
    required this.state,
    required this.regDate,
    required this.status,
  });
}
