import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/custom_drawer.dart';
import 'package:getcare360/core/widget/dashboard_card.dart';
import 'package:getcare360/core/widget/navigator_helper.dart';
import 'package:getcare360/features/Admin/Dashboard/presentation/screen/home_page.dart';
import 'package:getcare360/features/Admin/Ndis/presentation/screen/Participants/add_new_participants.dart';
import 'package:getcare360/features/Admin/Ndis/presentation/screen/Participants/create_care_plan/all_care_plan.dart';
import 'package:getcare360/features/Admin/Ndis/presentation/screen/Participants/create_care_plan/careplan_archive.dart';
import 'package:getcare360/features/Admin/Ndis/presentation/screen/Participants/create_care_plan/create_care_plan.dart';
import 'package:getcare360/features/Admin/Ndis/presentation/screen/Participants/create_chart/all_chart.dart';
import 'package:getcare360/features/Admin/Ndis/presentation/screen/Participants/create_chart/chart_archive.dart';
import 'package:getcare360/features/Admin/Ndis/presentation/screen/Participants/create_chart/create_chart.dart';
import 'package:getcare360/features/Admin/Ndis/presentation/screen/Participants/create_support/all_support.dart';
import 'package:getcare360/features/Admin/Ndis/presentation/screen/Participants/create_support/create_support.dart';
import 'package:getcare360/features/Admin/Ndis/presentation/screen/Participants/create_support/support_archive.dart';
import 'package:getcare360/features/Admin/Ndis/presentation/screen/Participants/nsw_participant.dart';
import 'package:getcare360/features/Admin/Ndis/presentation/screen/Participants/parti_vic.dart';
import 'package:getcare360/features/Admin/Ndis/presentation/screen/Participants/participant_archive_page.dart';
import 'package:getcare360/features/Admin/Ndis/presentation/screen/Participants/participant_roster_page.dart';
import 'package:getcare360/features/Admin/Ndis/presentation/screen/Participants/participant_timesheet.dart';
import 'package:getcare360/features/Admin/Ndis/presentation/screen/Staff/act.dart';
import 'package:getcare360/features/Admin/Ndis/presentation/screen/Staff/add_saff_group_page.dart';
import 'package:getcare360/features/Admin/Ndis/presentation/screen/Staff/all_staff_grouppage.dart';
import 'package:getcare360/features/Admin/Ndis/presentation/screen/Staff/all_staff_type_page.dart';
import 'package:getcare360/features/Admin/Ndis/presentation/screen/Staff/ndis_add_new_staff.dart';
import 'package:getcare360/features/Admin/Ndis/presentation/screen/Staff/ndis_add_new_stafftype_page.dart';
import 'package:getcare360/features/Admin/Ndis/presentation/screen/Staff/nsw.dart';
import 'package:getcare360/features/Admin/Ndis/presentation/screen/Staff/staff_archive.dart';
import 'package:getcare360/features/Admin/Ndis/presentation/screen/Staff/staff_availablitity_page.dart';
import 'package:getcare360/features/Admin/Ndis/presentation/screen/Staff/vic.dart';
import 'package:getcare360/features/Admin/Ndis/presentation/widget/ndis_menu_list.dart';

class NdisPage extends StatefulWidget {
  const NdisPage({super.key});

  @override
  State<NdisPage> createState() => _NdisPageState();
}

class _NdisPageState extends State<NdisPage> {
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

    if (key == "new_southNdis") {
      NavigatorHelper.push(context, const ParticipantsNswPage());
      return;
    }

    if (key == "Ndis_vic") {
      NavigatorHelper.push(context, const PartiVic());
      return;
    }

    if (key == "add_new_partNdis") {
      NavigatorHelper.push(context, const AddNewParticipantPageNdis());
      return;
    }
    if (key == "arch_ndis") {
      NavigatorHelper.push(context, const ParticipantsArchivePage());
      return;
    }
    if (key == "roster_Ndis") {
      NavigatorHelper.push(context, const ParticipantRosterPage());
      return;
    }
    if (key == "timesheet_ndis") {
      NavigatorHelper.push(context, const ParticipantTimesheetPage());
      return;
    }
    if (key == "all_careplans_ndis") {
      NavigatorHelper.push(context, const CarePlanListPage());
      return;
    }
    if (key == "add_new_care_plan_ndis") {
      NavigatorHelper.push(context, const AddNewCarePlanPage());
      return;
    }
    if (key == "all_chartndis") {
      NavigatorHelper.push(context, const AllChart());
      return;
    }
    if (key == "add_new_chart_ndis") {
      NavigatorHelper.push(context, const CreateChart());
      return;
    }

    if (key == "all_support_ndis") {
      NavigatorHelper.push(context, const AllSupport());
      return;
    }

    if (key == "add_new_support_ndis") {
      NavigatorHelper.push(context, const CreateSupport());
      return;
    }

    if (key == "Ndis_support_archived") {
      NavigatorHelper.push(context, const SupportsArchivePage());
      return;
    }

    if (key == "Ndis_Chart_archived") {
      NavigatorHelper.push(context, const ChartArchive());
      return;
    }

    if (key == "Ndis_Careplan_archived") {
      NavigatorHelper.push(context, const CareplanArchive());
      return;
    }

    //Staff
    if (key == "staff_vic_ndis") {
      NavigatorHelper.push(context, const NdisStaffVictoriaPage());
      return;
    }
    if (key == "staff_nsw_ndis") {
      NavigatorHelper.push(context, const NdisStaffNSW());
      return;
    }
    if (key == "staff_act_ndis") {
      NavigatorHelper.push(context, const NdisParticipantACT());
      return;
    }
    if (key == "add_new_staff_ndis") {
      NavigatorHelper.push(context, const NdisAddNewStaffPage());
      return;
    }
    if (key == "staff_arch_ndis") {
      NavigatorHelper.push(context, const NdisStaffArchivePage());
      return;
    }
    if (key == "staff_type_all_ndis") {
      NavigatorHelper.push(context, const NdisAllStaffTypePage());
      return;
    }
    if (key == "staff_type_add_ndis") {
      NavigatorHelper.push(context, const NdisAddNewStaffTypePage());
      return;
    }
    if (key == "staff_group_all_ndis") {
      NavigatorHelper.push(context, const NdisAllStaffGroupPage());
      return;
    }
    if (key == "staff_group_add_ndis") {
      NavigatorHelper.push(context, const NdisAddNewStaffGroupPage());
      return;
    }
    if (key == "staff_availability_ndis") {
      NavigatorHelper.push(context, const NdisStaffAvailabilityPage());
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
                items: ndisDraweritems,
                selectedKey: _selected,
                onSelect: (key) =>
                    _handleSelect(context, key, closeDrawer: true),
              ),
            ),

      body: isDesktop
          ? Row(
              children: [
                UniversalCustomDrawer(
                  style: UniversalDrawerStyle.purple(),
                  items: ndisDraweritems,
                  selectedKey: _selected,
                  onSelect: (key) =>
                      _handleSelect(context, key, closeDrawer: false),
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
                DashboardCard(
                  width: isWide ? (w / 2) - 18 : w,
                  title: "Participants",
                  icon: Icons.person_add_alt_1,
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
