import 'dart:async';
import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/action_btn.dart';
import 'package:getcare360/core/widget/custom_appbar.dart';
import 'package:getcare360/features/Admin/Agency/presentation/screen/Staff/add_new_stafftype_page.dart';

class AdminAllStaffTypePage extends StatefulWidget {
  const AdminAllStaffTypePage({super.key});

  @override
  State<AdminAllStaffTypePage> createState() => AllStaffTypePageState();
}

class AllStaffTypePageState extends State<AdminAllStaffTypePage> {
  static const Color pageBg = Color(0xFFF3F4F8);
  static const Color brandPurple = Color(0xFF8E24AA);
  static const Color sidePurple = Color(0xFF9C27B0);

  final TextEditingController searchCtrl = TextEditingController();
  Timer? debounce;

  List<StaffTypeItem> allItems = const [
    StaffTypeItem(
      designation: "Disability Support Worker",
      normalHour: "Casual",
      pay: "36.50",
      organization: "Yes",
    ),
    StaffTypeItem(
      designation: "Registered Nurses - NDIS",
      normalHour: "15",
      pay: "63.50",
      organization: "Yes",
    ),
    StaffTypeItem(
      designation: "Physiotherapy",
      normalHour: "casual",
      pay: "63.50",
      organization: "No",
    ),
    StaffTypeItem(
      designation: "Registered Nurse Agency",
      normalHour: "Casual",
      pay: "40.00",
      organization: "No",
    ),
    StaffTypeItem(
      designation: "Assistant in Nursing",
      normalHour: "Casual",
      pay: "0.00",
      organization: "No",
    ),
    StaffTypeItem(
      designation: "Enrolled Nurse",
      normalHour: "Casual",
      pay: "0.00",
      organization: "No",
    ),
    StaffTypeItem(
      designation: "Book Keeper",
      normalHour: "20 Weekly",
      pay: "0.00",
      organization: "No",
    ),
    StaffTypeItem(
      designation: "Agency Staff - PCA",
      normalHour: "Casual",
      pay: "0.00",
      organization: "No",
    ),
    StaffTypeItem(
      designation: "Cleaner",
      normalHour: "casual",
      pay: "35.00",
      organization: "No",
    ),
    StaffTypeItem(
      designation: "Kitchen hand",
      normalHour: "Casual",
      pay: "36.50",
      organization: "Yes",
    ),
    StaffTypeItem(
      designation: "Medicator (Cert IV)",
      normalHour: "Hours",
      pay: "36.50",
      organization: "Yes",
    ),
    StaffTypeItem(
      designation: "Support Coordinator",
      normalHour: "0",
      pay: "0.00",
      organization: "Yes",
    ),
    StaffTypeItem(
      designation: "Support Coordinator/Business Development Manager",
      normalHour: "0",
      pay: "0.00",
      organization: "Yes",
    ),
    StaffTypeItem(
      designation: "Business Development Manager",
      normalHour: "0",
      pay: "0.00",
      organization: "No",
    ),
  ];

  List<StaffTypeItem> filtered = const [];

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
            .where(
              (e) =>
                  e.designation.toLowerCase().contains(q) ||
                  e.normalHour.toLowerCase().contains(q) ||
                  e.pay.toLowerCase().contains(q) ||
                  e.organization.toLowerCase().contains(q),
            )
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
    final w = MediaQuery.of(context).size.width;
    final bool isDesktop = w >= 980;

    return Scaffold(
      appBar: CustomAppBar(title: 'All Staff Type', centerTitle: true),
      backgroundColor: pageBg,
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1150),
                          child: StaffTypeListCard(
                            searchCtrl: searchCtrl,
                            onSearchChanged: onSearchChanged,
                            onFind: applyFilter,
                            onClearAll: clearAll,
                            onAddNew: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const AddNewStaffTypePage(),
                                ),
                              );
                            },
                            items: filtered,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const FooterBar(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StaffTypeListCard extends StatelessWidget {
  static const Color brandPurple = Color(0xFF8E24AA);

  final TextEditingController searchCtrl;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onFind;
  final VoidCallback onClearAll;
  final VoidCallback onAddNew;
  final List<StaffTypeItem> items;

  const StaffTypeListCard({
    super.key,
    required this.searchCtrl,
    required this.onSearchChanged,
    required this.onFind,
    required this.onClearAll,
    required this.onAddNew,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final bool isMobile = w < 720;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: brandPurple,
            child: LayoutBuilder(
              builder: (context, c) {
                final bool isNarrow = c.maxWidth < 650;

                if (isNarrow) {
                  // ✅ MOBILE: Stack + Wrap (no overflow)
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Staff type",
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

                // ✅ TABLET / DESKTOP: single row like screenshot
                return Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Staff type",
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

          // table header + rows
          LayoutBuilder(
            builder: (context, c) {
              final bool isSmall = c.maxWidth < 520;

              final double normalW = isSmall ? 90 : 140;
              final double payW = isSmall ? 70 : 110;
              final double orgW = isSmall ? 90 : 130;
              final double actionW = isSmall ? 110 : 160;

              return Column(
                children: [
                  Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        const Expanded(child: TableHeaderText("DESIGNATION")),
                        SizedBox(
                          width: normalW,
                          child: const TableHeaderText("NORMAL HOUR"),
                        ),
                        SizedBox(
                          width: payW,
                          child: const Align(
                            alignment: Alignment.center,
                            child: TableHeaderText("PAY"),
                          ),
                        ),
                        SizedBox(
                          width: orgW,
                          child: const Align(
                            alignment: Alignment.center,
                            child: TableHeaderText("ORGANIZATION"),
                          ),
                        ),
                        SizedBox(
                          width: actionW,
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
                      child: Text("No staff type found."),
                    )
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, i) {
                        return StaffTypeRow(
                          item: items[i],
                          normalW: normalW,
                          payW: payW,
                          orgW: orgW,
                          actionW: actionW,
                          onEdit: () {},
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

class StaffTypeRow extends StatelessWidget {
  final StaffTypeItem item;
  final VoidCallback onEdit;

  final double normalW;
  final double payW;
  final double orgW;
  final double actionW;

  const StaffTypeRow({
    super.key,
    required this.item,
    required this.onEdit,
    required this.normalW,
    required this.payW,
    required this.orgW,
    required this.actionW,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSmall = MediaQuery.of(context).size.width < 520;

    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(child: TableCellText(item.designation)),
          SizedBox(width: normalW, child: TableCellText(item.normalHour)),
          SizedBox(
            width: payW,
            child: TableCellText(item.pay, align: TextAlign.center),
          ),
          SizedBox(
            width: orgW,
            child: TableCellText(item.organization, align: TextAlign.center),
          ),
          SizedBox(
            width: actionW,
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 28,
                child: ElevatedButton.icon(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit, size: 14),
                  label: const Text(
                    "Edit",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
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
