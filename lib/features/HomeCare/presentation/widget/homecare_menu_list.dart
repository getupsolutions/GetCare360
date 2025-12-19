import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/custom_drawer.dart';

final List<NavItem> homecareDrawerItems = const [
  NavItem(title: "Dashboard", routeKey: "dashboard", icon: Icons.home),

  NavItem(
    title: "Consumer",
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
          NavItem(title: "Add New Staff", routeKey: "add_new_staff"),
          NavItem(title: "Archive", routeKey: "arch"),
        ],
      ),
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
];
