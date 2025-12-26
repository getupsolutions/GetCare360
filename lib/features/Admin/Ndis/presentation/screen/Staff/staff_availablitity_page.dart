import 'dart:math';
import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/custom_appbar.dart';
import 'package:getcare360/features/Admin/Ndis/presentation/widget/Staff/staff_avail_widget.dart';

/// ------------------------------------------------------------
/// Staff Availability Page (Mobile-first + Responsive + Optimized)
/// - Horizontal scroll calendar grid
/// - Bigger day boxes (width + height)
/// - Each day cell scrolls internally to show all availability items
/// - No private class names (no "_" anywhere)
/// ------------------------------------------------------------
class NdisStaffAvailabilityPage extends StatefulWidget {
  const NdisStaffAvailabilityPage({super.key});

  @override
  State<NdisStaffAvailabilityPage> createState() => StaffAvailabilityPageState();
}

class StaffAvailabilityPageState extends State<NdisStaffAvailabilityPage> {
  static const Color pageBg = Color(0xFFF3F4F8);
  static const Color purple = Color(0xFF8E24AA);

  DateTime visibleMonth = DateTime(2025, 12, 1);
  String selectedStaff = "Select Staff";

  late final Map<DateTime, List<AvailabilityBlock>> availabilityByDay;

  @override
  void initState() {
    super.initState();

    availabilityByDay = {
      d(2025, 12, 1): const [
        AvailabilityBlock("12:00 AM - 12:00 AM", "Tasegir Hossain Khan"),
        AvailabilityBlock("12:00 AM - 12:55 AM", "Katrina(EUN SEON) JEON"),
        AvailabilityBlock("01:00 AM - 02:00 AM", "Extra availability demo"),
        AvailabilityBlock("03:00 AM - 04:00 AM", "Another demo"),
      ],
      d(2025, 12, 2): const [
        AvailabilityBlock("12:00 AM - 12:00 AM", "Tasegir Hossain Khan"),
        AvailabilityBlock("12:00 AM - 12:55 AM", "Katrina(EUN SEON) JEON"),
      ],
      d(2025, 12, 3): const [
        AvailabilityBlock("12:00 AM - 12:00 AM", "Tasegir Hossain Khan"),
        AvailabilityBlock("12:00 AM - 12:55 AM", "Katrina(EUN SEON) JEON"),
      ],
      d(2025, 12, 4): const [
        AvailabilityBlock("12:00 AM - 12:00 AM", "Tasegir Hossain Khan"),
        AvailabilityBlock("12:00 AM - 12:55 AM", "Katrina(EUN SEON) JEON"),
      ],
      d(2025, 12, 5): const [
        AvailabilityBlock("12:00 AM - 12:00 AM", "Tasegir Hossain Khan"),
        AvailabilityBlock("12:00 AM - 12:55 AM", "Katrina(EUN SEON) JEON"),
      ],
      d(2025, 12, 6): const [
        AvailabilityBlock("12:00 AM - 12:00 AM", "Tasegir Hossain Khan"),
        AvailabilityBlock("12:00 AM - 12:55 AM", "Katrina(EUN SEON) JEON"),
      ],
      d(2025, 12, 20): const [
        AvailabilityBlock("12:00 AM - 12:00 AM", "Tasegir Hossain Khan"),
        AvailabilityBlock("12:00 AM - 12:55 AM", "Katrina(EUN SEON) JEON"),
        AvailabilityBlock("01:00 AM - 02:00 AM", "Extra availability demo"),
        AvailabilityBlock("02:00 AM - 03:00 AM", "More demo"),
        AvailabilityBlock("03:00 AM - 04:00 AM", "More demo"),
      ],
    };
  }

  static DateTime d(int y, int m, int day) => DateTime(y, m, day);

  void goPrevMonth() => setState(() {
    visibleMonth = DateTime(visibleMonth.year, visibleMonth.month - 1, 1);
  });

  void goNextMonth() => setState(() {
    visibleMonth = DateTime(visibleMonth.year, visibleMonth.month + 1, 1);
  });

  void goToday() => setState(() {
    final now = DateTime.now();
    visibleMonth = DateTime(now.year, now.month, 1);
  });

  void clearAll() {
    setState(() => selectedStaff = "Select Staff");
  }

  Future<void> openAddMultipleDaysDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => const AddAvailabilityDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final bool isDesktop = w >= 980;
    final double contentMaxWidth = 1100;

    return Scaffold(
      appBar: CustomAppBar(title: 'Staff Availbility', centerTitle: true),
      backgroundColor: pageBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isDesktop ? contentMaxWidth : w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  HeaderBar(
                    staffValue: selectedStaff,
                    onStaffChanged: (v) => setState(() => selectedStaff = v),
                    onFind: () {},
                    onClearAll: clearAll,
                    onAddMultipleDays: openAddMultipleDaysDialog,
                  ),
                  const SizedBox(height: 14),
                  CalendarCard(
                    month: visibleMonth,
                    onPrev: goPrevMonth,
                    onNext: goNextMonth,
                    onToday: goToday,
                    availabilityByDay: availabilityByDay,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
