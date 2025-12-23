import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/navigator_helper.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/CompilanceForm_page/Continous_improvment/continuos_create_new.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/CompilanceForm_page/Continous_improvment/continuos_viewall.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/CompilanceForm_page/IncidentReportForm/incident_create_new.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/CompilanceForm_page/IncidentReportForm/incident_viewall.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/CompilanceForm_page/TeamMeetingForm/team_create_new.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/CompilanceForm_page/TeamMeetingForm/team_viewall.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/Message/message_page.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/Organization/add_organization_page.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/Organization/organization_archive.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/Organization/organization_rosterpage.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/Organization/organization_timesheet.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/Organization/view_all_organization.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/Participants/add_new_participants.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/Participants/create_care_plan/all_care_plan.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/Participants/create_care_plan/careplan_archive.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/Participants/create_care_plan/create_care_plan.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/Participants/create_chart/all_chart.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/Participants/create_chart/chart_archive.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/Participants/create_chart/create_chart.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/Participants/create_support/all_support.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/Participants/create_support/create_support.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/Participants/create_support/support_archive.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/Participants/nsw_participant.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/Participants/parti_vic.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/Participants/participant_archive_page.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/Participants/participant_roster_page.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/Participants/participant_timesheet.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/PolicyAndProcedure/add_new_policy.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/PolicyAndProcedure/all_policy.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/Site%20Option/Director/add_new_director.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/Site%20Option/Director/all_director_page.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/Site%20Option/general_option_page.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/Site%20Option/line_items_page.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/Site%20Option/sub_admin_page.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/Staff/act.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/Staff/add_new_staff.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/Staff/add_new_stafftype_page.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/Staff/add_saff_group_page.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/Staff/all_staff_grouppage.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/Staff/all_staff_type_page.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/Staff/nsw.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/Staff/staff_archive.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/Staff/staff_availablitity_page.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/Staff/vic.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/view_downloadForm_page/superannuation_page.dart';
import 'package:getcare360/features/AdminAccount/presentation/screen/view_downloadForm_page/tax_file_page.dart';
import 'package:getcare360/features/AdminAccount/presentation/widget/admin_menu_list.dart';
import 'package:getcare360/core/widget/dashboard_card.dart';
import 'package:getcare360/core/widget/custom_drawer.dart';
import 'package:getcare360/features/Dashboard/presentation/screen/home_page.dart';
import 'package:getcare360/features/Ndis/presentation/screen/Participants/create_support/all_support.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
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

    if (key == "new_south_admin") {
      NavigatorHelper.push(context, AdminNSWPage());
      return;
    }

    if (key == "vic_admin") {
      NavigatorHelper.push(context, const AdminVIC());
      return;
    }

    if (key == "add_new_part_admin") {
      NavigatorHelper.push(context, const AdminAddnewParticipantPage());
      return;
    }
    if (key == "arch_admin") {
      NavigatorHelper.push(context, const AdminArchive());
      return;
    }
    if (key == "part_roster_admin") {
      NavigatorHelper.push(context, const AdminRosterPage());
      return;
    }
    if (key == "timesheet_admin") {
      NavigatorHelper.push(context, const AdminTimesheet());
      return;
    }
    if (key == "all_careplans_Admin") {
      NavigatorHelper.push(context, const AdminCareListPage());
      return;
    }
    if (key == "add_new_care_plan_Admin") {
      NavigatorHelper.push(context, const AdminAddNewCarePlanPage());
      return;
    }
    if (key == "Admin_Careplan_archived") {
      NavigatorHelper.push(context, const AdminCareplanArchive());
      return;
    }
    if (key == "all_chartAdmin") {
      NavigatorHelper.push(context, const AdminAllChart());
      return;
    }

    if (key == "add_new_chart_Admin") {
      NavigatorHelper.push(context, const AdminCreateChart());
      return;
    }

    if (key == "Admin_Chart_archived") {
      NavigatorHelper.push(context, const AdminChartArchive());
      return;
    }

    if (key == "all_support_Admin") {
      NavigatorHelper.push(context, const AdminAllSupport());
      return;
    }

    if (key == "add_new_support_Admin") {
      NavigatorHelper.push(context, const AdminCreateSupport());
      return;
    }

    if (key == "Admin_support_archived") {
      NavigatorHelper.push(context, const AdminSupportsArchivePage());
      return;
    }

    //Staff
    if (key == "org_view_all_admin") {
      NavigatorHelper.push(context, const AdminViewAllOrganizationPage());
      return;
    }
    if (key == "org_add_admin") {
      NavigatorHelper.push(context, const AdminAddOrganizationPage());
      return;
    }
    if (key == "org_archive_admin") {
      NavigatorHelper.push(context, const AdminOrganizationArchivePage());
      return;
    }
    if (key == "Org_roster_admin") {
      NavigatorHelper.push(context, const AdminOrganizationRosterPage());
      return;
    }
    if (key == "org_timesheet_admin") {
      NavigatorHelper.push(context, const AdminOrganizationTimesheetPage());
      return;
    }
    // if (key == "message_all_admin") {
    //   NavigatorHelper.push(context, const HomecareAllStaffTypePage());
    //   return;
    // }
    if (key == "staff_vic_admin") {
      NavigatorHelper.push(context, const AdminStaffVictoriaPage());
      return;
    }
    if (key == "staff_nsw_admin") {
      NavigatorHelper.push(context, const AdminStaffNSW());
      return;
    }
    if (key == "staff_act_admin") {
      NavigatorHelper.push(context, const AdminStaffACT());
      return;
    }
    if (key == "staff_add_admin") {
      NavigatorHelper.push(context, const AdminAddNewStaffPage());
      return;
    }
    if (key == "staff_archive_admin") {
      NavigatorHelper.push(context, const AdminStaffArchivePage());
      return;
    }
    if (key == "staff_availability_admin") {
      NavigatorHelper.push(context, const AdminStaffAvailabilityPage());
      return;
    }
    if (key == "staff_type_all_admin") {
      NavigatorHelper.push(context, const AdminAllStaffTypePage());
      return;
    }
    if (key == "staff_type_add_admin") {
      NavigatorHelper.push(context, const AdminAddNewStaffTypePage());
      return;
    }
    if (key == "staff_group_all_admin") {
      NavigatorHelper.push(context, const AdminAllStaffGroupPage());
      return;
    }
    if (key == "staff_group_add_admin") {
      NavigatorHelper.push(context, const AdminAddNewStaffGroupPage());
      return;
    }
    if (key == "admin_msg") {
      NavigatorHelper.push(context, const AdminMessageModulePage());
      return;
    }
    if (key == "admin_add_item_procedurepoli") {
      NavigatorHelper.push(context, const AdminAddPolicyAndProcedurePage());
      return;
    }
    if (key == "admin_allitem_procedurepoli") {
      NavigatorHelper.push(context, const AdminAllPolicyAndProcedurePage());
      return;
    }
    if (key == "admin_allitem_procedurepoli") {
      NavigatorHelper.push(context, const AdminAddNewStaffPage());
      return;
    }
    if (key == "admin_tax_file") {
      NavigatorHelper.push(
        context,
        const AdminTaxFileNumberDeclarationFormPage(),
      );
      return;
    }
    if (key == "admin_superannuation") {
      NavigatorHelper.push(
        context,
        const AdminSuperannuationStandardChoiceFormPage(),
      );
      return;
    }
    if (key == "admin_view_all") {
      NavigatorHelper.push(context, const ComplianceIncidentViewAllPage());
      return;
    }
    if (key == "admin_create_new") {
      NavigatorHelper.push(context, CreateComplianceIncidentPage());
      return;
    }
    if (key == "admin_view_all2") {
      NavigatorHelper.push(context, const TeamViewall());
      return;
    }
    if (key == "admin_create_new2") {
      NavigatorHelper.push(context, const TeamCreateNew());
      return;
    }

    if (key == "admin_view_all3") {
      NavigatorHelper.push(context, const AdminContinuosViewAllPage());
      return;
    }
    if (key == "admin_create_new3") {
      NavigatorHelper.push(context, const AdminContinuosCreateNewPage());
      return;
    }
    if (key == "admin_gen_opt") {
      NavigatorHelper.push(context, const GeneralOptionPage());
      return;
    }
    if (key == "admin_all_dir") {
      NavigatorHelper.push(context, const AllDirectorPage());
      return;
    }
    if (key == "admin_add_new_dir") {
      NavigatorHelper.push(context, const AddNewDirectorPage());
      return;
    }
    if (key == "sub_admin") {
      NavigatorHelper.push(context, const SubAdminManagementPage());
      return;
    }
    if (key == "line_items") {
      NavigatorHelper.push(context, const LineItemsManagementPage());
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
                items: adminDrawerItems,
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
                  items: adminDrawerItems,
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
                  onTap: () =>
                      NavigatorHelper.push(context, AdminStaffVictoriaPage()),
                  width: isWide ? (w / 2) - 18 : w,
                  title: "Staffs",
                  icon: Icons.group,
                ),
                DashboardCard(
                  onTap: () => NavigatorHelper.push(context, AdminNSWPage()),
                  width: isWide ? (w / 2) - 18 : w,
                  title: "Participants",
                  icon: Icons.person_add_alt_1,
                ),
                DashboardCard(
                  onTap: () => NavigatorHelper.push(
                    context,
                    AdminViewAllOrganizationPage(),
                  ),
                  width: isWide ? (w / 2) - 18 : w,
                  title: "Organization",
                  icon: Icons.assignment,
                ),
                DashboardCard(
                  onTap: () =>
                      NavigatorHelper.push(context, AdminMessageModulePage()),
                  width: isWide ? (w / 2) - 18 : w,
                  title: "Messages",
                  icon: Icons.message,
                ),
                DashboardCard(
                  onTap: () => NavigatorHelper.push(
                    context,
                    AdminAllPolicyAndProcedurePage(),
                  ),
                  width: isWide ? (w / 2) - 18 : w,
                  title: "Policy & Procedure",
                  icon: Icons.policy_sharp,
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
