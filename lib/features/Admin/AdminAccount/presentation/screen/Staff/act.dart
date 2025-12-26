import 'dart:math';
import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/custom_appbar.dart';
import 'package:getcare360/features/Admin/Ndis/presentation/widget/Staff/vic_widget.dart';

class AdminStaffACT extends StatefulWidget {
  const AdminStaffACT({super.key});

  @override
  State<AdminStaffACT> createState() => _StaffACTState();
}

class _StaffACTState extends State<AdminStaffACT> {
  // --- Filters (plug into BLoC later) ---
  final TextEditingController nameCtrl = TextEditingController();

  String accountStatus = "Account Status";
  String staffType = "Staff type";
  String staffStage = "Staff Stage";
  String group = "Select a group";
  String sort = "Name A-Z";
  String locationGroup = "Select Location Group";

  bool checkAll = false;
  String bulkAction = "Choose an bulk action";

  // Demo data
  final List<StaffRow> rows = const [
    StaffRow(
      sl: 1,
      staffId: "THC-4346",
      name: "Abijith PC",
      badgeText: "Stage 1",
      badgeColor: Color(0xFF1F1F1F),
      contactEmail: "abijithpc76@gmail.com",
      contactPhone: "09188292401",
      staffType: "Agency Staff - PCA",
      staffGroup: "Adelene Village Wyomimg AINs",
      state: "Victoria",
      status: "Active",
      regDate: "20-12-2025",
    ),
    StaffRow(
      sl: 2,
      staffId: "THC-0131",
      name: "Asha William William",
      badgeText: "On boarding Completed",
      badgeColor: Color(0xFF2ED4C7),
      contactEmail: "asha_ranjith@hotmail.com",
      contactPhone: "+61430064713",
      staffType: "Registered Nurses - NDIS",
      staffGroup: "19 Warringal Street Bulleen Victoria 3105, Victoria",
      state: "Victoria",
      status: "Active",
      regDate: "26-09-2022",
    ),
    StaffRow(
      sl: 3,
      staffId: "THC-1574",
      name: "Cicilia Ragunathan",
      badgeText: "Stage 2",
      badgeColor: Color(0xFFB66DFF),
      contactEmail: "cicibala@gmail.com",
      contactPhone: "0487266700",
      staffType: "Registered Nurses - NDIS",
      staffGroup: "cc, cc, Victoria",
      state: "Victoria",
      status: "Active",
      regDate: "09-08-2023",
    ),
  ];

  @override
  void dispose() {
    nameCtrl.dispose();
    super.dispose();
  }

  void clearAll() {
    setState(() {
      nameCtrl.clear();
      accountStatus = "Account Status";
      staffType = "Staff type";
      staffStage = "Staff Stage";
      group = "Select a group";
      sort = "Name A-Z";
      locationGroup = "Select Location Group";
      checkAll = false;
      bulkAction = "Choose an bulk action";
    });
  }

  Future<void> openMobileFilters() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return MobileFilterSheet(
          nameCtrl: nameCtrl,
          accountStatus: accountStatus,
          staffType: staffType,
          staffStage: staffStage,
          group: group,
          sort: sort,
          locationGroup: locationGroup,
          onChanged: (f) {
            setState(() {
              accountStatus = f.accountStatus;
              staffType = f.staffType;
              staffStage = f.staffStage;
              group = f.group;
              sort = f.sort;
              locationGroup = f.locationGroup;
            });
          },
          onClearAll: clearAll,
          onFind: () => Navigator.pop(context),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const pageBg = Color(0xFFF3F4F8);

    return Scaffold(
      appBar: CustomAppBar(title: 'Staff- ACT', centerTitle: true),
      backgroundColor: pageBg,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, c) {
            final w = c.maxWidth;
            final isDesktop = w >= 980;
            final isMobile = w < 700;
            final contentWidth = min(w, 1200.0);

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: contentWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      StaffHeaderCard(
                        title: "Staff - ACT",
                        isMobile: isMobile,
                        nameCtrl: nameCtrl,
                        accountStatus: accountStatus,
                        staffType: staffType,
                        staffStage: staffStage,
                        group: group,
                        sort: sort,
                        locationGroup: locationGroup,
                        onAccountStatusChanged: (v) =>
                            setState(() => accountStatus = v),
                        onStaffTypeChanged: (v) =>
                            setState(() => staffType = v),
                        onStaffStageChanged: (v) =>
                            setState(() => staffStage = v),
                        onGroupChanged: (v) => setState(() => group = v),
                        onSortChanged: (v) => setState(() => sort = v),
                        onLocationGroupChanged: (v) =>
                            setState(() => locationGroup = v),
                        onFind: () {},
                        onClearAll: clearAll,
                        onAddNew: () {},
                        onOpenMobileFilters: openMobileFilters,
                      ),
                      const SizedBox(height: 14),

                      BulkActionBar(
                        checkAll: checkAll,
                        onCheckAllChanged: (v) => setState(() => checkAll = v),
                        bulkActionValue: bulkAction,
                        onBulkActionChanged: (v) =>
                            setState(() => bulkAction = v),
                        total: rows.length,
                        onGo: () {},
                      ),
                      const SizedBox(height: 10),

                      if (isDesktop)
                        StaffTable(rows: rows)
                      else
                        StaffMobileList(rows: rows),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
