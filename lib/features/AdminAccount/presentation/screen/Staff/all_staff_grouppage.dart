import 'dart:async';
import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/action_btn.dart';
import 'package:getcare360/core/widget/custom_appbar.dart';
import 'package:getcare360/features/Agency/presentation/screen/Staff/add_saff_group_page.dart';

class AdminAllStaffGroupPage extends StatefulWidget {
  const AdminAllStaffGroupPage({super.key});

  @override
  State<AdminAllStaffGroupPage> createState() => AllStaffGroupPageState();
}

class AllStaffGroupPageState extends State<AdminAllStaffGroupPage> {
  static const Color pageBg = Color(0xFFF3F4F8);

  final TextEditingController searchCtrl = TextEditingController();
  Timer? debounce;

  final List<StaffGroupItem> allItems = const [
    StaffGroupItem(groupName: "Chamberlain Gardens AINs"),
    StaffGroupItem(groupName: "Chamberlain Gardens RNs"),
    StaffGroupItem(groupName: "Kitchen Hand -Chamberlain"),
    StaffGroupItem(groupName: "Chamberlain Gardens ENs"),
    StaffGroupItem(groupName: "DSW Triniti"),
    StaffGroupItem(groupName: "KELLYVILLE-Gino"),
    StaffGroupItem(groupName: "Casula- Julio"),
    StaffGroupItem(groupName: "Campbelltown-Shivam"),
    StaffGroupItem(groupName: "Leumeah-Mattew"),
    StaffGroupItem(groupName: "Edmondson-Evelyn"),
    StaffGroupItem(groupName: "Oran Park-Shane"),
    StaffGroupItem(groupName: "Bradbury-Kira"),
    StaffGroupItem(groupName: "LIVERPOOL - NEZ"),
    StaffGroupItem(groupName: "Macquarie-Fayyad"),
  ];

  List<StaffGroupItem> filtered = const [];

  @override
  void initState() {
    super.initState();
    filtered = List.of(allItems);
  }

  @override
  void dispose() {
    debounce?.cancel();
    searchCtrl.dispose();
    super.dispose();
  }

  void applyFilter() {
    final q = searchCtrl.text.trim().toLowerCase();
    setState(() {
      if (q.isEmpty) {
        filtered = List.of(allItems);
      } else {
        filtered = allItems
            .where((e) => e.groupName.toLowerCase().contains(q))
            .toList();
      }
    });
  }

  void clearAll() {
    searchCtrl.clear();
    setState(() => filtered = List.of(allItems));
  }

  void onSearchChanged(String _) {
    debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 250), applyFilter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'All Staff Group', centerTitle: true),
      backgroundColor: pageBg,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1150),
                    child: StaffGroupListCard(
                      searchCtrl: searchCtrl,
                      onSearchChanged: onSearchChanged,
                      onFind: applyFilter,
                      onClearAll: clearAll,
                      onAddNew: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const AddNewStaffGroupPage(),
                          ),
                        );
                      },
                      items: filtered,
                      onEdit: (item) {},
                    ),
                  ),
                ),
              ),
            ),
            const FooterBar(),
          ],
        ),
      ),
    );
  }
}

class StaffGroupListCard extends StatelessWidget {
  static const Color brandPurple = Color(0xFF8E24AA);

  final TextEditingController searchCtrl;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onFind;
  final VoidCallback onClearAll;
  final VoidCallback onAddNew;
  final List<StaffGroupItem> items;
  final ValueChanged<StaffGroupItem> onEdit;

  const StaffGroupListCard({
    super.key,
    required this.searchCtrl,
    required this.onSearchChanged,
    required this.onFind,
    required this.onClearAll,
    required this.onAddNew,
    required this.items,
    required this.onEdit,
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
          // ✅ Responsive header (prevents overflow on small screens)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: brandPurple,
            child: LayoutBuilder(
              builder: (context, c) {
                final bool isNarrow = c.maxWidth < 650;

                if (isNarrow) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Staff Groups",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 40,
                        child: SearchField(
                          controller: searchCtrl,
                          hint: "Search...",
                          onChanged: onSearchChanged,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ActionBtn(
                            label: "Find",
                            color: const Color(0xFFE91E63),
                            onTap: onFind,
                          ),
                          ActionBtn(
                            label: "Clear All",
                            color: const Color(0xFF00B3A6),
                            onTap: onClearAll,
                          ),
                          ActionBtn(
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

                return Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Staff Groups",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 320,
                      height: 38,
                      child: SearchField(
                        controller: searchCtrl,
                        hint: "Search...",
                        onChanged: onSearchChanged,
                      ),
                    ),
                    const SizedBox(width: 10),
                    ActionBtn(
                      label: "Find",
                      color: const Color(0xFFE91E63),
                      onTap: onFind,
                    ),
                    const SizedBox(width: 8),
                    ActionBtn(
                      label: "Clear All",
                      color: const Color(0xFF00B3A6),
                      onTap: onClearAll,
                    ),
                    const SizedBox(width: 8),
                    ActionBtn(
                      label: "Add New",
                      color: const Color(0xFF7C4DFF),
                      icon: Icons.add,
                      onTap: onAddNew,
                    ),
                  ],
                );
              },
            ),
          ),

          LayoutBuilder(
            builder: (context, c) {
              final bool isSmall = c.maxWidth < 420;
              final double actionWidth = isSmall ? 110 : 160;

              return Column(
                children: [
                  Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        const Expanded(child: TableHeaderText("GROUP")),
                        SizedBox(
                          width: actionWidth,
                          child: const Align(
                            alignment: Alignment.center,
                            child: TableHeaderText("ACTIONS"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),

                  if (items.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(18),
                      child: Text("No staff group found."),
                    )
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, i) {
                        return StaffGroupRow(
                          item: items[i],
                          actionWidth: actionWidth,
                          onEdit: () => onEdit(items[i]),
                        );
                      },
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class StaffGroupRow extends StatelessWidget {
  final StaffGroupItem item;
  final VoidCallback onEdit;
  final double actionWidth;

  const StaffGroupRow({
    super.key,
    required this.item,
    required this.onEdit,
    required this.actionWidth,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSmall = MediaQuery.of(context).size.width < 420;

    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(child: TableCellText(item.groupName)),
          SizedBox(
            width: actionWidth,
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 28,
                child: ElevatedButton.icon(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit, size: 14),
                  label: Text(
                    isSmall ? "Edit" : "Edit",
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7ED957),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmall ? 10 : 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TableHeaderText extends StatelessWidget {
  final String text;
  const TableHeaderText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w900,
        color: Color(0xFF9CA3AF),
        letterSpacing: 1.2,
      ),
    );
  }
}

class TableCellText extends StatelessWidget {
  final String text;
  final TextAlign align;

  const TableCellText(this.text, {super.key, this.align = TextAlign.left});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Color(0xFF374151),
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;

  const SearchField({
    super.key,
    required this.controller,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
        filled: true,
        fillColor: Colors.white,
        isDense: true,
        prefixIcon: const Icon(Icons.search, size: 18),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE6E8EF)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE6E8EF)),
        ),
      ),
    );
  }
}

class FooterBar extends StatelessWidget {
  const FooterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: const Color(0xFFEDEFF6),
      child: const Text(
        "2025©",
        style: TextStyle(color: Color(0xFF9CA3AF), fontWeight: FontWeight.w700),
      ),
    );
  }
}

class StaffGroupItem {
  final String groupName;
  const StaffGroupItem({required this.groupName});
}
