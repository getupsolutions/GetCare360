import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/custom_drawer.dart';
import 'package:getcare360/core/widget/dashboard_card.dart';
import 'package:getcare360/core/widget/navigator_helper.dart';
import 'package:getcare360/features/Dashboard/presentation/screen/home_page.dart';
import 'package:getcare360/features/HomeCare/presentation/screen/Participants/add_new_participants.dart';
import 'package:getcare360/features/HomeCare/presentation/screen/Participants/create_care_plan/all_care_plan.dart';
import 'package:getcare360/features/HomeCare/presentation/screen/Participants/create_care_plan/careplan_archive.dart';
import 'package:getcare360/features/HomeCare/presentation/screen/Participants/create_care_plan/create_care_plan.dart';
import 'package:getcare360/features/HomeCare/presentation/screen/Participants/create_chart/all_chart.dart';
import 'package:getcare360/features/HomeCare/presentation/screen/Participants/create_chart/chart_archive.dart';
import 'package:getcare360/features/HomeCare/presentation/screen/Participants/create_chart/create_chart.dart';
import 'package:getcare360/features/HomeCare/presentation/screen/Participants/create_support/all_support.dart';
import 'package:getcare360/features/HomeCare/presentation/screen/Participants/create_support/create_support.dart';
import 'package:getcare360/features/HomeCare/presentation/screen/Participants/create_support/support_archive.dart';
import 'package:getcare360/features/HomeCare/presentation/screen/Participants/nsw_participant.dart';
import 'package:getcare360/features/HomeCare/presentation/screen/Participants/parti_vic.dart';
import 'package:getcare360/features/HomeCare/presentation/screen/Participants/participant_archive_page.dart';
import 'package:getcare360/features/HomeCare/presentation/screen/Participants/participant_roster_page.dart';
import 'package:getcare360/features/HomeCare/presentation/screen/Participants/participant_timesheet.dart';
import 'package:getcare360/features/HomeCare/presentation/screen/Staff/act.dart';
import 'package:getcare360/features/HomeCare/presentation/screen/Staff/add_new_staff.dart';
import 'package:getcare360/features/HomeCare/presentation/screen/Staff/add_new_stafftype_page.dart';
import 'package:getcare360/features/HomeCare/presentation/screen/Staff/add_saff_group_page.dart';
import 'package:getcare360/features/HomeCare/presentation/screen/Staff/all_staff_grouppage.dart';
import 'package:getcare360/features/HomeCare/presentation/screen/Staff/all_staff_type_page.dart';
import 'package:getcare360/features/HomeCare/presentation/screen/Staff/nsw.dart';
import 'package:getcare360/features/HomeCare/presentation/screen/Staff/staff_archive.dart';
import 'package:getcare360/features/HomeCare/presentation/screen/Staff/staff_availablitity_page.dart';
import 'package:getcare360/features/HomeCare/presentation/screen/Staff/vic.dart';
import 'package:getcare360/features/HomeCare/presentation/widget/homecare_menu_list.dart';

class HomeCare extends StatefulWidget {
  const HomeCare({super.key});

  @override
  State<HomeCare> createState() => _HomeCareState();
}

class _HomeCareState extends State<HomeCare> {
  String _selected = "dashboard";
  void _handleSelect(
    BuildContext context,
    String key, {
    required bool closeDrawer,
  }) {
    // ✅ close drawer safely (mobile)
    if (closeDrawer && Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }

    // ✅ route navigation
    if (key == "dashboard") {
      NavigatorHelper.pushAndRemoveUntil(context, const HomePage());
      return;
    }

    if (key == "new_south_homecare") {
      NavigatorHelper.push(context, const HomecareConsumerNSWPage());
      return;
    }

    if (key == "vic_homecare") {
      NavigatorHelper.push(context, const HomeCareVIC());
      return;
    }

    if (key == "add_new_part_homecare") {
      NavigatorHelper.push(context, const HomecareAddnewConsumerPage());
      return;
    }
    if (key == "arch_homecare") {
      NavigatorHelper.push(context, const HomeCareConsumerArchive());
      return;
    }
    if (key == "roster_homecare") {
      NavigatorHelper.push(context, const HomeCareConsumerRosterPage());
      return;
    }
    if (key == "timesheet_homecare") {
      NavigatorHelper.push(context, const HomeCareConsumerTimesheet());
      return;
    }
    if (key == "all_careplans_homecare") {
      NavigatorHelper.push(context, const HomecareCareListPage());
      return;
    }
    if (key == "add_new_care_plan_homecare") {
      NavigatorHelper.push(context, const HomecareAddNewCarePlanPage());
      return;
    }
    if (key == "all_charthomecare") {
      NavigatorHelper.push(context, const HomecareAllChart());
      return;
    }
    if (key == "add_new_chart_homecare") {
      NavigatorHelper.push(context, const HomecareCreateChart());
      return;
    }

    if (key == "all_support_homecare") {
      NavigatorHelper.push(context, const HomecareAllSupport());
      return;
    }

    if (key == "add_new_support_homecare") {
      NavigatorHelper.push(context, const HomecareCreateSupport());
      return;
    }

    if (key == "homecare_support_archived") {
      NavigatorHelper.push(context, const HomecareSupportsArchivePage());
      return;
    }

    if (key == "homecare_Chart_archived") {
      NavigatorHelper.push(context, const HomecareChartArchive());
      return;
    }

    if (key == "homecare_Careplan_archived") {
      NavigatorHelper.push(context, const HomecareCareplanArchive());
      return;
    }

    //Staff
    if (key == "staff_vic_homecare") {
      NavigatorHelper.push(context, const HomecareStaffVictoriaPage());
      return;
    }
    if (key == "staff_nsw_homecare") {
      NavigatorHelper.push(context, const HomecareStaffNSW());
      return;
    }
    if (key == "staff_act_homecare") {
      NavigatorHelper.push(context, const HomecareStaffACT());
      return;
    }
    if (key == "add_new_staff_homecare") {
      NavigatorHelper.push(context, const HomecareAddNewStaffPage());
      return;
    }
    if (key == "arch_homecare") {
      NavigatorHelper.push(context, const HomecareStaffArchivePage());
      return;
    }
    if (key == "staff_type_all_homecare") {
      NavigatorHelper.push(context, const HomecareAllStaffTypePage());
      return;
    }
    if (key == "staff_type_add_homecare") {
      NavigatorHelper.push(context, const HomecareAddNewStaffTypePage());
      return;
    }
    if (key == "staff_group_all_homecare") {
      NavigatorHelper.push(context, const HomecareAllStaffGroupPage());
      return;
    }
    if (key == "staff_group_add_homecare") {
      NavigatorHelper.push(context, const HomecareAddNewStaffGroupPage());
      return;
    }
    if (key == "staff_availability_homecare") {
      NavigatorHelper.push(context, const HomecareStaffAvailabilityPage());
      return;
    }

    // ✅ Shell body swap (same scaffold)
    setState(() => _selected = key);
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 980;

    final scaffold = Scaffold(
      backgroundColor: const Color(0xFFF3F4F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: isDesktop
            ? null
            : Builder(
                builder: (ctx) => IconButton(
                  icon: const Icon(Icons.menu, color: Colors.black87),
                  onPressed: () => Scaffold.of(ctx).openDrawer(),
                ),
              ),
        title: const Text(
          "Admin - Dashboard",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.black87),
          ),
          const SizedBox(width: 8),
          const Padding(
            padding: EdgeInsets.only(right: 14),
            child: Row(
              children: [
                Text(
                  "Hi, Triniti Admin",
                  style: TextStyle(color: Colors.black87),
                ),
                SizedBox(width: 10),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Color(0xFFB012A5),
                  child: Text(
                    "T",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      drawer: isDesktop
          ? null
          : Drawer(
              child: UniversalCustomDrawer(
                style: UniversalDrawerStyle.purple(),
                items: homecareDrawerItems,
                selectedKey: _selected,
                onSelect: (key) =>
                    _handleSelect(context, key, closeDrawer: true),
                title: "getup",
                subtitle: "Admin Panel",
              ),
            ),

      body: isDesktop
          ? Row(
              children: [
                UniversalCustomDrawer(
                  style: UniversalDrawerStyle.purple(),
                  items: homecareDrawerItems,
                  selectedKey: _selected,
                  onSelect: (key) =>
                      _handleSelect(context, key, closeDrawer: true),
                  title: "getup",
                  subtitle: "Admin Panel",
                ),
                Expanded(child: _BodyArea(selectedKey: _selected)),
              ],
            )
          : _BodyArea(selectedKey: _selected),
    );

    return scaffold;
  }
}

/// Example content area (replace with your real pages)
class _BodyArea extends StatelessWidget {
  final String selectedKey;
  const _BodyArea({required this.selectedKey});

  @override
  Widget build(BuildContext context) {
    // For your screenshot-like dashboard cards
    if (selectedKey == "dashboard") {
      return Padding(
        padding: const EdgeInsets.all(18),
        child: LayoutBuilder(
          builder: (ctx, c) {
            final w = c.maxWidth;
            final isWide = w >= 900;
            return Wrap(
              spacing: 18,
              runSpacing: 18,
              children: [
                DashboardCard(
                  width: isWide ? (w / 2) - 18 : w,
                  title: "Staffs",
                  icon: Icons.group,
                ),
              ],
            );
          },
        ),
      );
    }

    // Generic placeholder for navigation destinations
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          "Selected: $selectedKey",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
