import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/custom_drawer.dart';

final List<NavItem> adminDrawerItems = const [
  NavItem(title: "Dashboard", routeKey: "dashboard", icon: Icons.home),

  NavItem(
    title: "Participants",
    routeKey: "part",
    icon: Icons.apartment,
    children: [
      NavItem(
        title: "All Participants",
        routeKey: "org_all",
        children: [
          NavItem(title: "New South Wales", routeKey: "new_south_admin"),
          NavItem(title: "Victoria", routeKey: "vic_admin"),
          NavItem(
            title: "Add New Participants",
            routeKey: "add_new_part_admin",
          ),
          NavItem(title: "Archive", routeKey: "arch_admin"),
        ],
      ),
      NavItem(title: "Roster", routeKey: "part_roster_admin"),
      NavItem(title: "Timesheet", routeKey: "timesheet_admin"),
      NavItem(
        title: "Create Care Plan",
        routeKey: "create_careAdmin",
        children: [
          NavItem(title: "All Care Plans", routeKey: "all_careplans_Admin"),
          NavItem(
            title: "Add New Care Plan",
            routeKey: "add_new_care_plan_Admin",
          ),
          NavItem(title: "Archived", routeKey: "Admin_Careplan_archived"),
        ],
      ),
      NavItem(
        title: "Create Chart",
        routeKey: "create_ChartAdmin",
        children: [
          NavItem(title: "All Chart", routeKey: "all_chartAdmin"),
          NavItem(title: "Add New Chart", routeKey: "add_new_chart_Admin"),
          NavItem(title: "Archived", routeKey: "Admin_Chart_archived"),
        ],
      ),
      NavItem(
        title: "Support items",
        routeKey: "support_items_Admin",
        children: [
          NavItem(title: "All Supprort", routeKey: "all_support_Admin"),
          NavItem(
            title: "Add New Support",
            routeKey: "add_new_support_Admin",
          ),
          NavItem(title: "Archived", routeKey: "Admin_support_archived"),
        ],
      ),
    ],
  ),

  NavItem(
    title: "Organization",
    routeKey: "org_admin",
    icon: Icons.apartment,
    children: [
      NavItem(
        title: "All Organization",
        routeKey: "org_all_admin",
        children: [
          NavItem(
            title: "View All Organization",
            routeKey: "org_view_all_admin",
          ),
          NavItem(title: "Add New Organization", routeKey: "org_add_admin"),
          NavItem(title: "Archive", routeKey: "org_archive_admin"),
        ],
      ),
      NavItem(title: "Roster", routeKey: "Org_roster_admin"),
      NavItem(title: "Timesheet", routeKey: "org_timesheet_admin"),
      NavItem(title: "Message for all staff", routeKey: "message_all_admin"),
    ],
  ),

  NavItem(
    title: "Staff",
    routeKey: "staff_admin",
    icon: Icons.people,
    children: [
      NavItem(
        title: "All Staffs",
        routeKey: "staff_all_admin",
        children: [
          NavItem(title: "VIC", routeKey: "staff_vic_admin"),
          NavItem(title: "NSW", routeKey: "staff_nsw_admin"),
          NavItem(title: "ACT", routeKey: "staff_act_admin"),
        ],
      ),
      NavItem(title: "Add New Staff", routeKey: "staff_add_admin"),
      NavItem(title: "Archive", routeKey: "staff_archive_admin"),
      NavItem(title: "Availability", routeKey: "staff_availability_admin"),

      NavItem(
        title: "Staff Type Settings",
        routeKey: "staff_type_settings_admin",
        children: [
          NavItem(title: "All Staff Type", routeKey: "staff_type_all_admin"),
          NavItem(
            title: "Add New Staff Type",
            routeKey: "staff_type_add_admin",
          ),
        ],
      ),

      NavItem(
        title: "Staff Group Settings",
        routeKey: "staff_group_settings_admin",
        children: [
          NavItem(title: "All Staff Group", routeKey: "staff_group_all_admin"),
          NavItem(
            title: "Add New Staff Group",
            routeKey: "staff_group_add_admin",
          ),
        ],
      ),
    ],
  ),

  NavItem(title: "Message", routeKey: "admin_msg", icon: Icons.message),

  NavItem(
    title: "Policy & procedure",
    routeKey: "admin_poli",
    icon: Icons.policy,
    children: [
      NavItem(title: "All Items", routeKey: "admin_allitem_procedurepoli"),
      NavItem(title: "Add New Item", routeKey: "admin_add_item_procedurepoli"),
    ],
  ),
  NavItem(
    title: "View & Download Form ",
    routeKey: "admin_view_down",
    icon: Icons.upload,
    children: [
      NavItem(
        title: "Tax file number declaration form",
        routeKey: "admin_tax_file",
      ),
      NavItem(
        title: "Superannuation Standard choice form",
        routeKey: "admin_superannuation",
      ),
    ],
  ),

  NavItem(
    title: "Compilance Forms",
    routeKey: "comp_forms",
    icon: Icons.apartment,
    children: [
      NavItem(
        title: "Incident Report Forms",
        routeKey: "inc_repo_form",
        children: [
          NavItem(title: "View All", routeKey: "admin_view_all"),
          NavItem(title: "Create New", routeKey: "admin_create_new"),
        ],
      ),
      NavItem(
        title: "Team Meeting Minutes",
        routeKey: "team_metng_min",
        children: [
          NavItem(title: "View All", routeKey: "admin_view_all2"),
          NavItem(title: "Create New", routeKey: "admin_create_new2"),
        ],
      ),
      NavItem(
        title: "Continous Improvement Register",
        routeKey: "",
        children: [
          NavItem(title: "View All", routeKey: "admin_view_all3"),
          NavItem(title: "Create New", routeKey: "admin_create_new3"),
        ],
      ),
    ],
  ),
  NavItem(
    title: "Site Options",
    routeKey: "part",
    icon: Icons.apartment,
    children: [
      NavItem(title: "General Option", routeKey: "admin_gen_opt"),

      NavItem(
        title: "Director",
        routeKey: "admin_dir",
        children: [
          NavItem(title: "All Director", routeKey: "admin_all_dir"),
          NavItem(title: "Add New Director", routeKey: "admin_add_new_dir"),
        ],
      ),
      NavItem(title: "Sub Admins", routeKey: "sub_admin"),
      NavItem(title: "Line items", routeKey: "line_items"),
    ],
  ),
];
