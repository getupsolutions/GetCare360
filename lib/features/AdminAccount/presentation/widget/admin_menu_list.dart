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
          NavItem(title: "New South Wales", routeKey: "new_south"),
          NavItem(title: "Victoria", routeKey: "vic"),
          NavItem(title: "Add New Participants", routeKey: "add_new_part"),
          NavItem(title: "Archive", routeKey: "arch"),
        ],
      ),
      NavItem(title: "Roster", routeKey: "roster"),
      NavItem(title: "Timesheet", routeKey: "timesheet"),
      NavItem(title: "Create Care Plan", routeKey: "create_care"),
      NavItem(title: "Create Chart", routeKey: "create_char"),
      NavItem(title: "Support items", routeKey: "sup_item"),
    ],
  ),

  NavItem(
    title: "Organization",
    routeKey: "org",
    icon: Icons.apartment,
    children: [
      NavItem(
        title: "All Organization",
        routeKey: "org_all",
        children: [
          NavItem(title: "View All Organization", routeKey: "org_view_all"),
          NavItem(title: "Add New Organization", routeKey: "org_add"),
          NavItem(title: "Archive", routeKey: "org_archive"),
        ],
      ),
      NavItem(title: "Roster", routeKey: "roster"),
      NavItem(title: "Timesheet", routeKey: "timesheet"),
      NavItem(title: "Message for all staff", routeKey: "message_all"),
    ],
  ),

  NavItem(
    title: "Staff",
    routeKey: "staff",
    icon: Icons.people,
    children: [
      NavItem(
        title: "All Staffs",
        routeKey: "staff_all",
        children: [
          NavItem(title: "VIC", routeKey: "staff_vic"),
          NavItem(title: "NSW", routeKey: "staff_nsw"),
          NavItem(title: "ACT", routeKey: "staff_act"),
        ],
      ),
      NavItem(title: "Add New Staff", routeKey: "staff_add"),
      NavItem(title: "Archive", routeKey: "staff_archive"),
      NavItem(title: "Availability", routeKey: "staff_availability"),

      NavItem(
        title: "Staff Type Settings",
        routeKey: "staff_type_settings",
        children: [
          NavItem(title: "All Staff Type", routeKey: "staff_type_all"),
          NavItem(title: "Add New Staff Type", routeKey: "staff_type_add"),
        ],
      ),

      NavItem(
        title: "Staff Group Settings",
        routeKey: "staff_group_settings",
        children: [
          NavItem(title: "All Staff Group", routeKey: "staff_group_all"),
          NavItem(title: "Add New Staff Group", routeKey: "staff_group_add"),
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
      NavItem(title: "All Items", routeKey: "admin_allitem"),
      NavItem(title: "Add New Item", routeKey: "admin_add_item"),
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
