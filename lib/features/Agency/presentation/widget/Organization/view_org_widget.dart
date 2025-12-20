import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getcare360/core/constant/app_color.dart';
import 'package:getcare360/features/Agency/domain/entity/org_entity.dart';
import 'package:getcare360/features/Agency/presentation/bloc/organization/org_bloc.dart';
import 'package:getcare360/features/Agency/presentation/bloc/organization/org_event.dart';
import 'package:getcare360/features/Agency/presentation/bloc/organization/org_state.dart';
import 'package:getcare360/core/widget/responsive.dart';

class OrgTableRow extends StatelessWidget {
  final int? slNo;
  final OrgEntity item;
  final bool mobile;
  final bool isTablet;

  const OrgTableRow.desktop({
    super.key,
    required this.slNo,
    required this.item,
    required this.isTablet,
  }) : mobile = false;

  const OrgTableRow.mobile({super.key, required this.item})
    : slNo = null,
      mobile = true,
      isTablet = false;

  @override
  Widget build(BuildContext context) {
    if (mobile) return _mobileCard(context);

    if (isTablet) {
      // ✅ Tablet compact row
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 50, child: Text("${slNo ?? ""}")),
            SizedBox(
              width: 200,
              child: Text(
                item.name,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(width: 240, child: Text(item.contact)),
            SizedBox(width: 160, child: StatusChip(status: item.status)),
            SizedBox(
              width: 160,
              child: ActionButtons(
                compact: true,
                onEdit: () {},
                onDelete: () {},
              ),
            ),
          ],
        ),
      );
    }

    // ✅ Desktop full row
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 50, child: Text("${slNo ?? ""}")),
          SizedBox(
            width: 200,
            child: Text(
              item.name,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(width: 260, child: Text(item.contact)),
          SizedBox(width: 260, child: Text(item.services)),
          SizedBox(width: 220, child: Text(item.group)),
          SizedBox(width: 120, child: Text(_fmtDate(item.regDate))),
          SizedBox(width: 130, child: StatusChip(status: item.status)),
          SizedBox(
            width: 160,
            child: ActionButtons(onEdit: () {}, onDelete: () {}),
          ),
        ],
      ),
    );
  }

  Widget _mobileCard(BuildContext context) {
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
            item.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          _kv("Contact", item.contact),
          _kv("Services", item.services),
          _kv("Group", item.group),
          _kv("Reg. Date", _fmtDate(item.regDate)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatusChip(status: item.status),
              ActionButtons(onEdit: () {}, onDelete: () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _kv(String k, String v) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black87, height: 1.3),
          children: [
            TextSpan(
              text: "$k: ",
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            TextSpan(text: v),
          ],
        ),
      ),
    );
  }

  String _fmtDate(DateTime d) {
    final dd = d.day.toString().padLeft(2, '0');
    final mm = d.month.toString().padLeft(2, '0');
    final yy = d.year.toString();
    return "$dd-$mm-$yy";
  }
}

class OrgTable extends StatelessWidget {
  final List<OrgEntity> data;
  const OrgTable({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    if (isMobile) {
      // ✅ Mobile: cards
      return ListView.separated(
        itemCount: data.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) => OrgTableRow.mobile(item: data[index]),
      );
    }

    // ✅ Tablet/Desktop: table-like rows + horizontal scroll only if needed
    final minTableWidth = isTablet ? 920.0 : 1250.0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          OrgTableHeader(isTablet: isTablet),
          const Divider(height: 1),
          Expanded(
            child: LayoutBuilder(
              builder: (ctx, constraints) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: minTableWidth,
                      // if screen is wider than minWidth, table expands to screen
                      maxWidth: constraints.maxWidth > minTableWidth
                          ? constraints.maxWidth
                          : minTableWidth,
                    ),
                    child: ListView.separated(
                      itemCount: data.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) => OrgTableRow.desktop(
                        slNo: index + 1,
                        item: data[index],
                        isTablet: isTablet,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OrgTableHeader extends StatelessWidget {
  final bool isTablet;
  const OrgTableHeader({super.key, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 13,
      color: Color(0xFF3B3B3B),
    );

    // Tablet shows fewer columns (prevents cramped UI)
    if (isTablet) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: const Row(
          children: [
            SizedBox(width: 50, child: Text("SL\nNo.", style: style)),
            SizedBox(width: 200, child: Text("Name", style: style)),
            SizedBox(width: 240, child: Text("Contact", style: style)),
            SizedBox(width: 160, child: Text("Status", style: style)),
            SizedBox(width: 160, child: Text("Action", style: style)),
          ],
        ),
      );
    }

    // Desktop full header
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: const Row(
        children: [
          SizedBox(width: 50, child: Text("SL\nNo.", style: style)),
          SizedBox(width: 200, child: Text("Name", style: style)),
          SizedBox(width: 260, child: Text("Contact", style: style)),
          SizedBox(width: 260, child: Text("Services", style: style)),
          SizedBox(width: 220, child: Text("Group", style: style)),
          SizedBox(width: 120, child: Text("Reg.\nDate", style: style)),
          SizedBox(width: 130, child: Text("Status", style: style)),
          SizedBox(width: 160, child: Text("Action", style: style)),
        ],
      ),
    );
  }
}

class StatusChip extends StatelessWidget {
  final String status;
  const StatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final isActive = status.toLowerCase() == "active";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.infoChipBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: isActive ? AppColors.infoChipText : Colors.black87,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  /// if true => renders in one row (better on tablet)
  final bool compact;

  const ActionButtons({
    super.key,
    required this.onEdit,
    required this.onDelete,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 32,
              child: ElevatedButton.icon(
                onPressed: onEdit,
                icon: const Icon(Icons.edit, size: 16, color: Colors.white),
                label: const Text(
                  "Edit",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.success,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SizedBox(
              height: 32,
              child: ElevatedButton.icon(
                onPressed: onDelete,
                icon: const Icon(Icons.delete, size: 16, color: Colors.white),
                label: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.danger,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    // desktop (column)
    return Column(
      children: [
        SizedBox(
          height: 32,
          width: 90,
          child: ElevatedButton.icon(
            onPressed: onEdit,
            icon: const Icon(Icons.edit, size: 16, color: Colors.white),
            label: const Text(
              "Edit",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.success,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 32,
          width: 90,
          child: ElevatedButton.icon(
            onPressed: onDelete,
            icon: const Icon(Icons.delete, size: 16, color: Colors.white),
            label: const Text(
              "Delete",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.danger,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class OrgFilterBar extends StatelessWidget {
  const OrgFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrgBloc, OrgState>(
      buildWhen: (p, n) =>
          p.query != n.query || p.status != n.status || p.sort != n.sort,
      builder: (context, state) {
        final isMobile = Responsive.isMobile(context);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Organization",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                SizedBox(
                  width: isMobile ? double.infinity : 260,
                  child: _SearchField(
                    value: state.query,
                    onChanged: (v) =>
                        context.read<OrgBloc>().add(OrgSearchChanged(v)),
                  ),
                ),

                SizedBox(
                  width: isMobile ? double.infinity : 220,
                  child: _Dropdown(
                    value: state.status,
                    hint: "Account Status",
                    items: const ["All", "Active", "Inactive", "Pending"],
                    onChanged: (v) =>
                        context.read<OrgBloc>().add(OrgStatusChanged(v)),
                  ),
                ),

                SizedBox(
                  width: isMobile ? double.infinity : 200,
                  child: _Dropdown(
                    value: state.sort,
                    hint: "Name A-Z",
                    items: const ["Name A-Z", "Name Z-A", "Newest", "Oldest"],
                    onChanged: (v) =>
                        context.read<OrgBloc>().add(OrgSortChanged(v)),
                  ),
                ),

                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEF4444),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () {
                      // "Find" button: you can trigger API call here.
                      // Right now filtering is live, so no-op.
                      FocusScope.of(context).unfocus();
                    },
                    child: const Text(
                      "Find",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF14B8A6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () =>
                        context.read<OrgBloc>().add(OrgClearFilters()),
                    child: const Text(
                      "Clear All",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _SearchField extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;

  const _SearchField({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      onChanged: onChanged,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: "Search...",
        prefixIcon: const Icon(Icons.search),
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

class _Dropdown extends StatelessWidget {
  final String value;
  final String hint;
  final List<String> items;
  final ValueChanged<String> onChanged;

  const _Dropdown({
    required this.value,
    required this.hint,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
      ),
      icon: const Icon(Icons.keyboard_arrow_down),
      items: items
          .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
          .toList(),
      onChanged: (v) {
        if (v != null) onChanged(v);
      },
    );
  }
}

final mockOrgsJson = [
  {
    "id": 1,
    "name": "Aleeza Syed",
    "contact": "11 Antwerp Ave\nEdmondson Park 2174\n0422 279 806",
    "services": "Disability Support Worker",
    "group": "DSW Triniti",
    "regDate": "2025-03-19",
    "status": "Active",
  },
  {
    "id": 2,
    "name": "Andrew Paul Emmerson",
    "contact": "406/142 Albany Street\nPoint Frederick 2250\n0413 809 337",
    "services": "Disability Support Worker",
    "group": "Andrew - Frederick Point",
    "regDate": "2024-05-27",
    "status": "Active",
  },
  {
    "id": 3,
    "name": "Ashliegh Browne",
    "contact": "Morisset 2264\n0423 725 843",
    "services": "Disability Support Worker",
    "group": "Ashliegh Browne - Morisset",
    "regDate": "2024-05-28",
    "status": "Active",
  },
];
