import 'dart:math';

import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/custom_appbar.dart';
import 'package:getcare360/features/Admin/Ndis/presentation/widget/Staff/staff_archive_widget.dart';

class HomecareStaffArchivePage extends StatefulWidget {
  const HomecareStaffArchivePage({super.key});

  @override
  State<HomecareStaffArchivePage> createState() => StaffArchivePageState();
}

class StaffArchivePageState extends State<HomecareStaffArchivePage> {
  static const pageBg = Color(0xFFF3F4F8);
  static const purple = Color(0xFF8E24AA);

  final TextEditingController searchCtrl = TextEditingController();

  String accountStatus = "Account Status";

  // demo archive rows (replace with API/BLoC)
  final List<StaffArchiveRow> rows = const [
    StaffArchiveRow(
      name: "A Doris Allen",
      contactEmail: "Amieallen@live.com.au",
      contactPhone: "0432 549 330",
      staffType: "Disability Support Worker",
      state: "New South Wales",
      regDate: "16-04-2025",
      status: "Active",
    ),
    StaffArchiveRow(
      name: "Aadarsha Wenju Shrestha",
      nameBadge: "Approval Pending",
      contactEmail: "adarshwenju@gmail.com",
      contactPhone: "0435268853",
      staffType: "Disability Support Worker",
      state: "New South Wales",
      regDate: "24-07-2025",
      status: "Active",
    ),
    StaffArchiveRow(
      name: "Aakriti Aryal",
      contactEmail: "aakuaryal3@gmail.com",
      contactPhone: "0448065777",
      staffType: "Assistant in Nursing",
      state: "New South Wales",
      regDate: "15-09-2023",
      status: "Active",
    ),
    StaffArchiveRow(
      name: "Aarju Tamang",
      contactEmail: "aarjul118@gmail.com",
      contactPhone: "0450509409",
      staffType: "Cleaner",
      state: "New South Wales",
      regDate: "07-08-2025",
      status: "Active",
    ),
    StaffArchiveRow(
      name: "Aarju Tamang",
      contactEmail: "tmgaarjul118@gmail.com",
      contactPhone: "0450509409",
      staffType: "Cleaner",
      state: "New South Wales",
      regDate: "09-06-2025",
      status: "Pending",
    ),
  ];

  @override
  void dispose() {
    searchCtrl.dispose();
    super.dispose();
  }

  void clearAll() {
    setState(() {
      searchCtrl.clear();
      accountStatus = "Account Status";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Staff Archive', centerTitle: true),
      backgroundColor: pageBg,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, c) {
            final w = c.maxWidth;
            final isDesktop = w >= 980;
            final contentWidth = min(w, 1200.0);

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: contentWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      StaffArchiveHeader(
                        searchCtrl: searchCtrl,
                        accountStatus: accountStatus,
                        onAccountStatusChanged: (v) =>
                            setState(() => accountStatus = v),
                        onFind: () {},
                        onClearAll: clearAll,
                      ),
                      const SizedBox(height: 14),
                      StaffArchiveTableCard(
                        total: rows.length,
                        rows: rows,
                        isDesktop: isDesktop,
                      ),
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
