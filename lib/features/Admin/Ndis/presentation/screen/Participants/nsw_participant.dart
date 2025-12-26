import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/custom_appbar.dart';

class ParticipantsNswPage extends StatefulWidget {
  const ParticipantsNswPage({super.key});

  @override
  State<ParticipantsNswPage> createState() => _ParticipantsNswPageState();
}

class _ParticipantsNswPageState extends State<ParticipantsNswPage> {
  final TextEditingController _searchCtrl = TextEditingController();

  final List<ParticipantItem> _all = [
    ParticipantItem(
      id: "THC-0320",
      name: "Elaine Patterson",
      ndisNo: "430174637",
      state: "New South Wales",
      phone: "0433674455",
      email: "info@triniticare.com.au",
      address: "15A Brenda Cres, Tumbi Umbi, 2261",
    ),
    ParticipantItem(
      id: "THC-0319",
      name: "Susan Mchugh",
      ndisNo: "430250718",
      state: "New South Wales",
      phone: "0405481674",
      email: "rubyssusan2607@gmail.com",
      address: "4/17 Lushington St, East Gosford, 2250",
    ),
    ParticipantItem(
      id: "THC-0318",
      name: "Markyra Varagnola",
      ndisNo: "431134896",
      state: "New South Wales",
      phone: "0404647349",
      email: "megan@trustedhomecare.com.au",
      address: "140 Warnervale Road, Hamlyn Terrace, 2259",
    ),
    ParticipantItem(
      id: "THC-0317",
      name: "Anthony Bryson",
      ndisNo: "580176239",
      state: "New South Wales",
      phone: "0432777253",
      email: "amyshengamy@yahoo.com",
      address: "1005/159 Mann Street, Gosford, 2250",
    ),
  ];

  List<ParticipantItem> _filtered = [];

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
        return e.id.toLowerCase().contains(q) ||
            e.name.toLowerCase().contains(q) ||
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
      appBar: CustomAppBar(title: 'New South Wales', centerTitle: true),
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
              _HeaderCard(
                title: "Participants - New South Wales",
                searchCtrl: _searchCtrl,
                onFind: _applySearch,
                onClear: _clearAll,
                compact: isTablet,
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
                      ? _MobileListView(items: _filtered)
                      : _DesktopTableView(items: _filtered, dense: !isDesktop),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  final String title;
  final TextEditingController searchCtrl;
  final VoidCallback onFind;
  final VoidCallback onClear;
  final bool compact;

  const _HeaderCard({
    required this.title,
    required this.searchCtrl,
    required this.onFind,
    required this.onClear,
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
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
                fontWeight: FontWeight.w700,
              ),
            ),
            _SearchRow(
              searchCtrl: searchCtrl,
              onFind: onFind,
              onClear: onClear,
              compact: compact,
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchRow extends StatelessWidget {
  final TextEditingController searchCtrl;
  final VoidCallback onFind;
  final VoidCallback onClear;
  final bool compact;

  const _SearchRow({
    required this.searchCtrl,
    required this.onFind,
    required this.onClear,
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final bool tiny = w < 520;

    final textField = SizedBox(
      height: compact ? 38 : 42,
      child: TextField(
        controller: searchCtrl,
        onSubmitted: (_) => onFind(),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: "Name, Email, Phone, Address",
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

    if (tiny) {
      return SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            textField,
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
      );
    }

    return SizedBox(
      width: compact ? 520 : 620,
      child: Row(
        children: [
          Expanded(child: textField),
          const SizedBox(width: 8),
          findBtn,
          const SizedBox(width: 8),
          clearBtn,
        ],
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
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
      ),
    );
  }
}

/// -------------------- Desktop Table --------------------

class _DesktopTableView extends StatelessWidget {
  final List<ParticipantItem> items;
  final bool dense;

  const _DesktopTableView({required this.items, required this.dense});

  @override
  Widget build(BuildContext context) {
    final headerStyle = TextStyle(
      fontWeight: FontWeight.w800,
      color: Colors.black87,
      fontSize: dense ? 12.5 : 13.5,
    );

    final rowTextStyle = TextStyle(fontSize: dense ? 12.5 : 13.5);

    return LayoutBuilder(
      builder: (context, c) {
        return Scrollbar(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: c.maxWidth),
              child: SingleChildScrollView(
                child: DataTable(
                  headingRowHeight: dense ? 44 : 50,
                  dataRowMinHeight: dense ? 56 : 62,
                  dataRowMaxHeight: dense ? 72 : 78,
                  horizontalMargin: 16,
                  columnSpacing: 22,
                  dividerThickness: 0.8,
                  headingTextStyle: headerStyle,
                  columns: const [
                    DataColumn(label: Text("ID")),
                    DataColumn(label: Text("Name")),
                    DataColumn(label: Text("Ndis No")),
                    DataColumn(label: Text("State")),
                    DataColumn(label: Text("Contact")),
                    DataColumn(label: Text("Address")),
                    DataColumn(label: Text("Actions")),
                  ],
                  rows: List.generate(items.length, (i) {
                    final e = items[i];
                    final isAlt = i.isOdd;
                    final bg = isAlt ? const Color(0xFFFDE3EA) : Colors.white;

                    return DataRow(
                      color: WidgetStatePropertyAll(bg),
                      cells: [
                        DataCell(Text(e.id, style: rowTextStyle)),
                        DataCell(Text(e.name, style: rowTextStyle)),
                        DataCell(Text(e.ndisNo, style: rowTextStyle)),
                        DataCell(Text(e.state, style: rowTextStyle)),
                        DataCell(
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(e.phone, style: rowTextStyle),
                              const SizedBox(height: 3),
                              Text(
                                e.email,
                                style: rowTextStyle.copyWith(
                                  color: Colors.black54,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        DataCell(
                          SizedBox(
                            width: 320,
                            child: Text(
                              e.address,
                              style: rowTextStyle,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ),
                        const DataCell(_ActionIcons()),
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

/// -------------------- Mobile List --------------------

class _MobileListView extends StatelessWidget {
  final List<ParticipantItem> items;

  const _MobileListView({required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty)
      return const Center(child: Text("No participants found"));

    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        final e = items[i];
        final isAlt = i.isOdd;

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isAlt ? const Color(0xFFFDE3EA) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE7E7EF)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "${e.name} (${e.id})",
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const _ActionIcons(compact: true),
                ],
              ),
              const SizedBox(height: 8),
              _kv("NDIS No", e.ndisNo),
              _kv("State", e.state),
              _kv("Phone", e.phone),
              _kv("Email", e.email),
              _kv("Address", e.address, maxLines: 3),
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
            width: 74,
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

class _ActionIcons extends StatelessWidget {
  final bool compact;
  const _ActionIcons({this.compact = false});

  @override
  Widget build(BuildContext context) {
    final iconSize = compact ? 18.0 : 20.0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          visualDensity: VisualDensity.compact,
          constraints: const BoxConstraints(),
          padding: EdgeInsets.zero,
          onPressed: () {},
          icon: Icon(Icons.edit_outlined, size: iconSize),
        ),
        const SizedBox(width: 6),
        IconButton(
          visualDensity: VisualDensity.compact,
          constraints: const BoxConstraints(),
          padding: EdgeInsets.zero,
          onPressed: () {},
          icon: Icon(Icons.delete_outline, size: iconSize),
        ),
        const SizedBox(width: 6),
        IconButton(
          visualDensity: VisualDensity.compact,
          constraints: const BoxConstraints(),
          padding: EdgeInsets.zero,
          onPressed: () {},
          icon: Icon(Icons.logout, size: iconSize),
        ),
      ],
    );
  }
}

class ParticipantItem {
  final String id;
  final String name;
  final String ndisNo;
  final String state;
  final String phone;
  final String email;
  final String address;

  ParticipantItem({
    required this.id,
    required this.name,
    required this.ndisNo,
    required this.state,
    required this.phone,
    required this.email,
    required this.address,
  });
}
