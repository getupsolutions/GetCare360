import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/custom_drawer.dart';

final List<NavItem> homecareDrawerItems = const [
  NavItem(title: "Dashboard", routeKey: "dashboard", icon: Icons.home),

  NavItem(
    title: "Consumer",
    routeKey: "con",
    icon: Icons.apartment,
    children: [
      NavItem(
        title: "All Consumer",
        routeKey: "con_all",
        children: [
          NavItem(title: "New South Wales", routeKey: "new_south_homecare"),
          NavItem(title: "Victoria", routeKey: "vic_homecare"),
          NavItem(
            title: "Add New Participants",
            routeKey: "add_new_part_homecare",
          ),
          NavItem(title: "Archive", routeKey: "arch_homecare"),
        ],
      ),
      NavItem(title: "Roster", routeKey: "roster_homecare"),
      NavItem(title: "Timesheet", routeKey: "timesheet_homecare"),
      NavItem(
        title: "Create Care Plan",
        routeKey: "create_carehomecare",
        children: [
          NavItem(title: "All Care Plans", routeKey: "all_careplans_homecare"),
          NavItem(
            title: "Add New Care Plan",
            routeKey: "add_new_care_plan_homecare",
          ),
          NavItem(title: "Archived", routeKey: "homecare_Careplan_archived"),
        ],
      ),
      NavItem(
        title: "Create Chart",
        routeKey: "create_Charthomecare",
        children: [
          NavItem(title: "All Chart", routeKey: "all_charthomecare"),
          NavItem(title: "Add New Chart", routeKey: "add_new_chart_homecare"),
          NavItem(title: "Archived", routeKey: "homecare_Chart_archived"),
        ],
      ),
      NavItem(
        title: "Support items",
        routeKey: "support_items_homecare",
        children: [
          NavItem(title: "All Supprort", routeKey: "all_support_homecare"),
          NavItem(title: "Add New Support", routeKey: "add_new_support_homecare"),
          NavItem(title: "Archived", routeKey: "homecare_support_archived"),
        ],
      ),
    ],
  ),

  NavItem(
    title: "Staff",
    routeKey: "staff_homecare",
    icon: Icons.people,
    children: [
      NavItem(
        title: "All Staffs",
        routeKey: "staff_all_homecare",
        children: [
          NavItem(title: "VIC", routeKey: "staff_vic_homecare"),
          NavItem(title: "NSW", routeKey: "staff_nsw_homecare"),
          NavItem(title: "ACT", routeKey: "staff_act_homecare"),
          NavItem(title: "Add New Staff", routeKey: "add_new_staff_homecare"),
          NavItem(title: "Archive", routeKey: "arch_homecare"),
        ],
      ),
      NavItem(title: "Availability", routeKey: "staff_availability_homecare"),

      NavItem(
        title: "Staff Type Settings",
        routeKey: "staff_type_settings_homecare",
        children: [
          NavItem(title: "All Staff Type", routeKey: "staff_type_all_homecare"),
          NavItem(
            title: "Add New Staff Type",
            routeKey: "staff_type_add_homecare",
          ),
        ],
      ),

      NavItem(
        title: "Staff Group Settings",
        routeKey: "staff_group_settings_homecare",
        children: [
          NavItem(
            title: "All Staff Group",
            routeKey: "staff_group_all_homecare",
          ),
          NavItem(
            title: "Add New Staff Group",
            routeKey: "staff_group_add_homecare",
          ),
        ],
      ),
    ],
  ),
];
