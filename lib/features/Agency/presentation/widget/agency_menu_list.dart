import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/custom_drawer.dart';

final List<NavItem> agencyDrawerItems = const [
  NavItem(title: "Dashboard", routeKey: "dashboard", icon: Icons.home),

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
];
