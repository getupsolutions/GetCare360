import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/admin_ui.dart';
import 'package:getcare360/core/widget/custom_appbar.dart';

class SubAdminItem {
  final String name;
  final String email;
  final String type;
  final bool active;

  const SubAdminItem({
    required this.name,
    required this.email,
    this.type = "Sub Admin",
    this.active = true,
  });
}

class SubAdminManagementPage extends StatefulWidget {
  final VoidCallback? onAddNew;

  const SubAdminManagementPage({super.key, this.onAddNew});

  @override
  State<SubAdminManagementPage> createState() => _SubAdminManagementPageState();
}

class _SubAdminManagementPageState extends State<SubAdminManagementPage> {
  final _searchCtrl = TextEditingController();
  String _query = "";

  final List<SubAdminItem> _items = const [
    SubAdminItem(name: "Aleena Monica", email: "aleenamonica456@gmail.com"),
    SubAdminItem(
      name: "Bineesh George",
      email: "bineeshgeorge@triniticare.com.au",
    ),
    SubAdminItem(
      name: "Brittany Jean Lyons",
      email: "brittany@triniticare.com.au",
    ),
    SubAdminItem(
      name: "Cicilia Ragunathan",
      email: "contact@triniticare.com.au",
    ),
    SubAdminItem(name: "David Light", email: "davidlight@triniticare.com.au"),
    SubAdminItem(
      name: "ELYZA KAZE PAMPOSA",
      email: "elissa@triniticare.com.au",
    ),
    SubAdminItem(name: "Erika", email: "erika@triniticare.com.au"),
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<SubAdminItem> get _filtered {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return _items;
    return _items
        .where(
          (e) =>
              e.name.toLowerCase().contains(q) ||
              e.email.toLowerCase().contains(q),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdminUi.pageBg,
      appBar: const CustomAppBar(title: "Sub Admins Management"),
      body: LayoutBuilder(
        builder: (context, c) {
          final w = c.maxWidth;
          final isMobile = w < 980;
          final hp = isMobile ? 12.0 : 22.0;

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1180),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: hp,
                  vertical: isMobile ? 12 : 20,
                ),
                child: AdminCardShell(
                  child: Column(
                    children: [
                      AdminPurpleHeader(
                        title: "Sub Admins Management",
                        right: LayoutBuilder(
                          builder: (context, hc) {
                            final tight = hc.maxWidth < 520;

                            return Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              alignment: WrapAlignment.end,
                              children: [
                                SizedBox(
                                  width: tight
                                      ? hc.maxWidth
                                      : (isMobile ? 220 : 280),
                                  height: 38,
                                  child: TextField(
                                    controller: _searchCtrl,
                                    decoration: AdminUi.input(
                                      "Search...",
                                      prefixIcon: Icons.search,
                                    ),
                                    onChanged: (_) => setState(() {}),
                                  ),
                                ),
                                AdminPillButton(
                                  label: "Find",
                                  bg: const Color(0xFFE91E63),
                                  onTap: () =>
                                      setState(() => _query = _searchCtrl.text),
                                ),
                                AdminPillButton(
                                  label: "Clear All",
                                  bg: const Color(0xFF00BFA5),
                                  onTap: () {
                                    _searchCtrl.clear();
                                    setState(() => _query = "");
                                  },
                                ),
                                AdminPillButton(
                                  label: "Add New",
                                  bg: AdminUi.brandPurpleDark,
                                  icon: Icons.add,
                                  onTap:
                                      widget.onAddNew ??
                                      () => ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                            const SnackBar(
                                              content: Text("Add New"),
                                            ),
                                          ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),

                      if (!isMobile)
                        Container(
                          height: 44,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          color: const Color(0xFFF7F8FC),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text("NAME", style: _ThStyle()),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text("EMAIL", style: _ThStyle()),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text("TYPE", style: _ThStyle()),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text("STATUS", style: _ThStyle()),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text("ACTION", style: _ThStyle()),
                              ),
                            ],
                          ),
                        ),

                      Expanded(
                        child: ListView.separated(
                          itemCount: _filtered.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (context, i) {
                            final item = _filtered[i];
                            return isMobile
                                ? _SubAdminCard(item: item)
                                : _SubAdminRow(item: item);
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
}

class _ThStyle extends TextStyle {
  _ThStyle()
    : super(
        fontSize: 12,
        fontWeight: FontWeight.w900,
        color: const Color(0xFF9E9E9E),
        letterSpacing: .6,
      );
}

class _SubAdminRow extends StatelessWidget {
  final SubAdminItem item;
  const _SubAdminRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              item.name,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              item.email,
              style: const TextStyle(color: Color(0xFF616161)),
            ),
          ),
          Expanded(flex: 1, child: Text(item.type)),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFB2F5EA),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                "Active",
                style: TextStyle(
                  color: Color(0xFF0BAE8A),
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                AdminPillButton(
                  label: "Block",
                  bg: const Color(0xFF3D6DFF),
                  icon: Icons.block,
                  onTap: () => ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Block ${item.name}"))),
                ),
                AdminPillButton(
                  label: "View & Edit",
                  bg: const Color(0xFF66BB6A),
                  icon: Icons.edit_outlined,
                  onTap: () => ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Edit ${item.name}"))),
                ),
                AdminPillButton(
                  label: "Delete",
                  bg: const Color(0xFFFF5A6B),
                  icon: Icons.delete_outline,
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Delete ${item.name}")),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SubAdminCard extends StatelessWidget {
  final SubAdminItem item;
  const _SubAdminCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFEDEDED)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 4),
            Text(item.email, style: const TextStyle(color: Color(0xFF616161))),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                AdminPillButton(
                  label: "Block",
                  bg: const Color(0xFF3D6DFF),
                  icon: Icons.block,
                  onTap: () => ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Block ${item.name}"))),
                ),
                AdminPillButton(
                  label: "View & Edit",
                  bg: const Color(0xFF66BB6A),
                  icon: Icons.edit_outlined,
                  onTap: () => ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Edit ${item.name}"))),
                ),
                AdminPillButton(
                  label: "Delete",
                  bg: const Color(0xFFFF5A6B),
                  icon: Icons.delete_outline,
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Delete ${item.name}")),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
