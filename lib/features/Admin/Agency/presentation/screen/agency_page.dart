import 'package:flutter/material.dart';
import 'package:getcare360/features/Admin/Agency/presentation/screen/Organization/add_organization_page.dart';
import 'package:getcare360/features/Admin/Agency/presentation/screen/Organization/organization_archive.dart';
import 'package:getcare360/features/Admin/Agency/presentation/screen/Organization/organization_rosterpage.dart';
import 'package:getcare360/features/Admin/Agency/presentation/screen/Organization/organization_timesheet.dart';
import 'package:getcare360/features/Admin/Agency/presentation/screen/Organization/view_all_organization.dart';
import 'package:getcare360/features/Admin/Agency/presentation/screen/Staff/act.dart';
import 'package:getcare360/features/Admin/Agency/presentation/screen/Staff/add_new_staff.dart';
import 'package:getcare360/features/Admin/Agency/presentation/screen/Staff/add_saff_group_page.dart';
import 'package:getcare360/features/Admin/Agency/presentation/screen/Staff/all_staff_grouppage.dart';
import 'package:getcare360/features/Admin/Agency/presentation/screen/Staff/all_staff_type_page.dart';
import 'package:getcare360/features/Admin/Agency/presentation/screen/Staff/nsw.dart';
import 'package:getcare360/features/Admin/Agency/presentation/screen/Staff/staff_archive.dart';
import 'package:getcare360/features/Admin/Agency/presentation/screen/Staff/staff_availablitity_page.dart';
import 'package:getcare360/features/Admin/Agency/presentation/screen/Staff/vic.dart';
import 'package:getcare360/features/Admin/Agency/presentation/widget/agency_menu_list.dart';
import 'package:getcare360/features/Admin/Dashboard/presentation/screen/home_page.dart';
import 'package:getcare360/core/widget/dashboard_card.dart';
import 'package:getcare360/core/widget/custom_drawer.dart';
import 'package:getcare360/core/widget/navigator_helper.dart';

class AgencyPage extends StatefulWidget {
  const AgencyPage({super.key});

  @override
  State<AgencyPage> createState() => _AgencyPageState();
}

class _AgencyPageState extends State<AgencyPage> {
  String _selected = "dashboard";

  void _handleSelect(
    BuildContext context,
    String key, {
    required bool closeDrawer,
  }) {
    // Close drawer (mobile)
    if (closeDrawer) Navigator.pop(context);

    // ✅ Route navigations (full page)
    if (key == "dashboard") {
      NavigatorHelper.pushAndRemoveUntil(context, const HomePage());
      return;
    }

    if (key == "org_view_all") {
      NavigatorHelper.push(context, const ViewAllOrganizationPage());
      return;
    }

    if (key == "org_add") {
      NavigatorHelper.push(context, const AddOrganizationPage());
      return;
    }

    if (key == "org_archive") {
      NavigatorHelper.push(context, const OrganizationArchivePage());
      return;
    }
    if (key == "roster") {
      NavigatorHelper.push(context, const OrganizationRosterPage());
      return;
    }
    if (key == "timesheet") {
      NavigatorHelper.push(context, const OrganizationTimesheetPage());
      return;
    }
    if (key == "staff_vic") {
      NavigatorHelper.push(context, const StaffVictoriaPage());
      return;
    }
    if (key == "staff_nsw") {
      NavigatorHelper.push(context, const StaffNSW());
      return;
    }
    if (key == "staff_act") {
      NavigatorHelper.push(context, const StaffACT());
      return;
    }
    if (key == "staff_archive") {
      NavigatorHelper.push(context, const StaffArchivePage());
      return;
    }
    if (key == "staff_availability") {
      NavigatorHelper.push(context, const StaffAvailabilityPage());
      return;
    }

    if (key == "staff_type_all") {
      NavigatorHelper.push(context, const AllStaffTypePage());
      return;
    }

    if (key == "staff_type_add") {
      NavigatorHelper.push(context, const AddNewStaffGroupPage());
      return;
    }

    if (key == "staff_group_all") {
      NavigatorHelper.push(context, const AllStaffGroupPage());
      return;
    }

    if (key == "staff_group_add") {
      NavigatorHelper.push(context, const AddNewStaffGroupPage());
      return;
    }

    if (key == "staff_add") {
      NavigatorHelper.push(context, const AgencyAddNewStaffPage());
      return;
    }

    // ✅ Shell body swap (same scaffold)
    setState(() => _selected = key);
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 980;

    return Scaffold(
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
                items: agencyDrawerItems,
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
                  items: agencyDrawerItems,
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
  }
}

/// Example content area (replace with your real pages)
class _BodyArea extends StatelessWidget {
  final String selectedKey;
  const _BodyArea({required this.selectedKey});

  @override
  Widget build(BuildContext context) {
    // Dashboard (your existing UI)
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
                  title: "Organization",
                  icon: Icons.assignment,
                  onTap: () => NavigatorHelper.push(
                    context,
                    const ViewAllOrganizationPage(),
                  ),
                ),
              ],
            );
          },
        ),
      );
    }

    // ✅ Do NOT navigate here. Just show placeholder (or other content widgets).
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
