import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/custom_appbar.dart';

class AdminArchive extends StatefulWidget {
  const AdminArchive({super.key});

  @override
  State<AdminArchive> createState() =>
      _AdminConsumerArchiveState();
}

class _AdminConsumerArchiveState extends State<AdminArchive> {
  final TextEditingController _searchCtrl = TextEditingController();

  final List<ArchiveParticipantItem> _all = const [
    ArchiveParticipantItem(
      name: "Glenn Gosper Gosper",
      ndisNo: "430562666",
      state: "New South Wales",
      phone: "0418402180",
      email: "gosperglenn@hotmail.com",
      address: "7 Roberta Ave",
    ),
    ArchiveParticipantItem(
      name: "Anthony Banks Banks",
      ndisNo: "431440464",
      state: "New South Wales",
      phone: "+61468522770",
      email: "banks777anthony@gmail.com",
      address: "1/21 Rawson Road",
    ),
    ArchiveParticipantItem(
      name: "Robert Stephenson Stephenson",
      ndisNo: "430012737",
      state: "New South Wales",
      phone: "0283199433",
      email: "brightstar.nsw@gmail.com",
      address: "Unit 1/21 Rawson Way, Woy Woy 2256",
    ),
    ArchiveParticipantItem(
      name: "Ace Brooks Brooks",
      ndisNo: "430141559",
      state: "New South Wales",
      phone: "0498208178",
      email: "acerose03@yahoo.com.au",
      address: "43 Milky Way",
    ),
  ];

  List<ArchiveParticipantItem> _filtered = [];

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
      _filtered = _all.where((e) {
        return e.name.toLowerCase().contains(q) ||
            e.ndisNo.toLowerCase().contains(q) ||
            e.state.toLowerCase().contains(q) ||
            e.phone.toLowerCase().contains(q) ||
            e.email.toLowerCase().contains(q) ||
            e.address.toLowerCase().contains(q);
      }).toList();
    });
  }

  void _clearAll() {
    _searchCtrl.clear();
    setState(() => _filtered = List.of(_all));
  }

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
      appBar: CustomAppBar(title: "Archive", centerTitle: true),
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
              _ArchiveHeader(
                title: "Participants - Archive",
                searchCtrl: _searchCtrl,
                compact: isTablet,
                onFind: _applySearch,
                onClear: _clearAll,
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
                      ? _ArchiveMobileList(items: _filtered)
                      : _ArchiveDesktopTable(
                          items: _filtered,
                          dense: !isDesktop,
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

/// -------------------- HEADER --------------------

class _ArchiveHeader extends StatelessWidget {
  final String title;
  final TextEditingController searchCtrl;
  final bool compact;
  final VoidCallback onFind;
  final VoidCallback onClear;

  const _ArchiveHeader({
    required this.title,
    required this.searchCtrl,
    required this.compact,
    required this.onFind,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final bool tiny = w < 520;

    Widget searchField = SizedBox(
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
                fontWeight: FontWeight.w800,
              ),
            ),

            // responsive search area
            if (tiny)
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    searchField,
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        SizedBox(width: 110, child: findBtn),
                        SizedBox(width: 130, child: clearBtn),
                      ],
                    ),
                  ],
                ),
              )
            else
              SizedBox(
                width: compact ? 520 : 560,
                child: Row(
                  children: [
                    Expanded(child: searchField),
                    const SizedBox(width: 8),
                    findBtn,
                    const SizedBox(width: 8),
                    clearBtn,
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
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
      ),
    );
  }
}

/// -------------------- DESKTOP TABLE --------------------

class _ArchiveDesktopTable extends StatelessWidget {
  final List<ArchiveParticipantItem> items;
  final bool dense;

  const _ArchiveDesktopTable({required this.items, required this.dense});

  @override
  Widget build(BuildContext context) {
    final headerStyle = TextStyle(
      fontWeight: FontWeight.w800,
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
                  headingTextStyle: headerStyle,
                  headingRowHeight: dense ? 44 : 50,
                  dataRowMinHeight: dense ? 56 : 62,
                  dataRowMaxHeight: dense ? 72 : 78,
                  horizontalMargin: 16,
                  columnSpacing: 22,
                  dividerThickness: 0.8,
                  columns: const [
                    DataColumn(label: Text("Name")),
                    DataColumn(label: Text("Ndis No")),
                    DataColumn(label: Text("State")),
                    DataColumn(label: Text("Contact")),
                    DataColumn(label: Text("Address")),
                    DataColumn(label: Text("Actions")),
                  ],
                  rows: List.generate(items.length, (i) {
                    final e = items[i];
                    final bg = i.isOdd ? const Color(0xFFFDE3EA) : Colors.white;

                    return DataRow(
                      color: WidgetStatePropertyAll(bg),
                      cells: [
                        DataCell(Text(e.name, style: rowStyle)),
                        DataCell(Text(e.ndisNo, style: rowStyle)),
                        DataCell(Text(e.state, style: rowStyle)),
                        DataCell(
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(e.phone, style: rowStyle),
                              const SizedBox(height: 3),
                              Text(
                                e.email,
                                style: rowStyle.copyWith(color: Colors.black54),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        DataCell(
                          SizedBox(
                            width: 260,
                            child: Text(
                              e.address,
                              style: rowStyle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        DataCell(
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: const [
                              _ActionPill(
                                label: "View & Edit",
                                icon: Icons.edit_outlined,
                                color: Color(0xFF4CAF50),
                              ),
                              _ActionPill(
                                label: "Profile",
                                icon: Icons.person_outline,
                                color: Color(0xFF00BFA5),
                              ),
                              _ActionPill(
                                label: "Restore",
                                icon: Icons.restore,
                                color: Color(0xFFFF9800),
                              ),
                            ],
                          ),
                        ),
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

class _ActionPill extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const _ActionPill({
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ElevatedButton.icon(
        onPressed: () {},
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
          textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
        ),
      ),
    );
  }
}

/// -------------------- MOBILE LIST --------------------

class _ArchiveMobileList extends StatelessWidget {
  final List<ArchiveParticipantItem> items;

  const _ArchiveMobileList({required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty)
      return const Center(child: Text("No archived participants"));

    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        final e = items[i];
        final bg = i.isOdd ? const Color(0xFFFDE3EA) : Colors.white;

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
                e.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              _kv("NDIS", e.ndisNo),
              _kv("State", e.state),
              _kv("Phone", e.phone),
              _kv("Email", e.email),
              _kv("Address", e.address, maxLines: 3),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: const [
                  _ActionPill(
                    label: "View & Edit",
                    icon: Icons.edit_outlined,
                    color: Color(0xFF4CAF50),
                  ),
                  _ActionPill(
                    label: "Profile",
                    icon: Icons.person_outline,
                    color: Color(0xFF00BFA5),
                  ),
                  _ActionPill(
                    label: "Restore",
                    icon: Icons.restore,
                    color: Color(0xFFFF9800),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _kv(String k, String v, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 70,
            child: Text(
              "$k:",
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
            child: Text(v, maxLines: maxLines, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}

/// -------------------- MODEL --------------------

class ArchiveParticipantItem {
  final String name;
  final String ndisNo;
  final String state;
  final String phone;
  final String email;
  final String address;

  const ArchiveParticipantItem({
    required this.name,
    required this.ndisNo,
    required this.state,
    required this.phone,
    required this.email,
    required this.address,
  });
}
