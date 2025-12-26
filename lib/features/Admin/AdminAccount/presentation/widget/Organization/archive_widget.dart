import 'package:flutter/material.dart';
import 'package:getcare360/features/Admin/Agency/data/model/organization/archive_demomodel.dart';

class ArchiveTableHeader extends StatelessWidget {
  const ArchiveTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(fontWeight: FontWeight.w600);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: const [
          SizedBox(width: 200, child: Text("Name", style: style)),
          Expanded(child: Text("Contact", style: style)),
          SizedBox(width: 120, child: Text("Reg. Date", style: style)),
          SizedBox(width: 100, child: Text("Status", style: style)),
          SizedBox(width: 80, child: Text("Action", style: style)),
        ],
      ),
    );
  }
}

class ArchiveCard extends StatelessWidget {
  final ArchiveItem item;
  const ArchiveCard({super.key, required this.item});

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
            item.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          _kv("Contact", item.contact),
          _kv("Date", item.date),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatusChip(status: item.status),
              IconButton(
                icon: const Icon(Icons.undo, color: Colors.blue),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _kv(String k, String v) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text("$k: $v"),
    );
  }
}

class StatusChip extends StatelessWidget {
  final String status;
  const StatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFB2F5EA),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        status,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.teal,
        ),
      ),
    );
  }
}

class ArchiveTableRows extends StatelessWidget {
  const ArchiveTableRows({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: demoData.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final item = demoData[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              SizedBox(
                width: 200,
                child: Text(
                  item.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(child: Text(item.contact)),
              SizedBox(width: 120, child: Text(item.date)),
              SizedBox(width: 100, child: StatusChip(status: item.status)),
              SizedBox(
                width: 80,
                child: IconButton(
                  icon: const Icon(Icons.undo, color: Colors.blue),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ArchiveBody extends StatelessWidget {
  const ArchiveBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    if (isMobile) {
      return ListView.separated(
        itemCount: demoData.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return ArchiveCard(item: demoData[index]);
        },
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: const [
          ArchiveTableHeader(),
          Divider(height: 1),
          Expanded(child: ArchiveTableRows()),
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final ValueChanged<String>? onSearchChanged;
  final ValueChanged<String?>? onStatusChanged;
  final VoidCallback? onFind;
  final VoidCallback? onClear;
  final String? statusValue;

  const SearchBar({
    super.key,
    this.onSearchChanged,
    this.onStatusChanged,
    this.onFind,
    this.onClear,
    this.statusValue,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final w = c.maxWidth;

        final isMobile = w < 650;
        final isSmall = w < 420;

        final searchWidth = isMobile ? w : 260.0;
        final dropdownWidth = isSmall ? w : (isMobile ? w : 200.0);
        final buttonWidth = isSmall ? w : 90.0;

        // keep the selected value visible in DropdownMenu
        final statusCtrl = TextEditingController(text: statusValue ?? "");

        return Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.end,
          children: [
            // 🔍 Search
            SizedBox(
              width: searchWidth,
              height: 48,
              child: TextField(
                onChanged: onSearchChanged,
                decoration: InputDecoration(
                  hintText: "Search...",
                  prefixIcon: const Icon(Icons.search, size: 18),
                  filled: true,
                  fillColor: Colors.white,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // ✅ Account Status (DropdownMenu — overlay safe)
            SizedBox(
              width: dropdownWidth,
              height: 48,
              child: DropdownMenu<String>(
                controller: statusCtrl,
                expandedInsets: EdgeInsets.zero,
                enableSearch: false,
                enableFilter: false,
                requestFocusOnTap: false,
                hintText: "Account Status",
                inputDecorationTheme: InputDecorationTheme(
                  filled: true,
                  fillColor: Colors.white,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide.none,
                  ),
                ),
                dropdownMenuEntries: const [
                  DropdownMenuEntry(value: "Active", label: "Active"),
                  DropdownMenuEntry(value: "Inactive", label: "Inactive"),
                ],
                onSelected: (v) => onStatusChanged?.call(v),
              ),
            ),

            // 🔎 Find Button
            SizedBox(
              width: buttonWidth,
              height: 48,
              child: ElevatedButton(
                onPressed: onFind,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8E24AA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Find",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // ❌ Clear All
            SizedBox(
              width: isSmall ? w : null,
              height: 48,
              child: Align(
                alignment: isSmall
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: TextButton(
                  onPressed: onClear,
                  child: const Text(
                    "Clear All",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ArchiveHeader extends StatelessWidget {
  const ArchiveHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFB012A5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Text(
                  "Organization Management",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10),
                SearchBar(),
              ],
            )
          : Row(
              children: const [
                Expanded(
                  child: Text(
                    "Organization Management",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SearchBar(),
              ],
            ),
    );
  }
}
