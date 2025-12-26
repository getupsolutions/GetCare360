import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/custom_drawer.dart';

final List<NavItem> ndisDraweritems = const [
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
          NavItem(title: "New South Wales", routeKey: "new_southNdis"),
          NavItem(title: "Victoria", routeKey: "Ndis_vic"),
          NavItem(title: "Add New Participants", routeKey: "add_new_partNdis"),
          NavItem(title: "Archive", routeKey: "arch_ndis"),
        ],
      ),
      NavItem(title: "Roster", routeKey: "roster_Ndis"),
      NavItem(title: "Timesheet", routeKey: "timesheet_ndis"),
      NavItem(
        title: "Create Care Plan",
        routeKey: "create_careNdis",
        children: [
          NavItem(title: "All Care Plans", routeKey: "all_careplans_ndis"),
          NavItem(
            title: "Add New Care Plan",
            routeKey: "add_new_care_plan_ndis",
          ),
          NavItem(title: "Archived", routeKey: "Ndis_Careplan_archived"),
        ],
      ),
      NavItem(
        title: "Create Chart",
        routeKey: "create_ChartNdis",
        children: [
          NavItem(title: "All Chart", routeKey: "all_chartndis"),
          NavItem(title: "Add New Chart", routeKey: "add_new_chart_ndis"),
          NavItem(title: "Archived", routeKey: "Ndis_Chart_archived"),
        ],
      ),
      NavItem(
        title: "Support items",
        routeKey: "support_items_ndis",
        children: [
          NavItem(title: "All Supprort", routeKey: "all_support_ndis"),
          NavItem(title: "Add New Support", routeKey: "add_new_support_ndis"),
          NavItem(title: "Archived", routeKey: "Ndis_support_archived"),
        ],
      ),
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
          NavItem(title: "VIC", routeKey: "staff_vic_ndis"),
          NavItem(title: "NSW", routeKey: "staff_nsw_ndis"),
          NavItem(title: "ACT", routeKey: "staff_act_ndis"),
          NavItem(title: "Add New Staff", routeKey: "add_new_staff_ndis"),
          NavItem(title: "Archive", routeKey: "staff_arch_ndis"),
        ],
      ),
      NavItem(title: "Availability", routeKey: "staff_availability_ndis"),

      NavItem(
        title: "Staff Type Settings",
        routeKey: "staff_type_settings_ndis",
        children: [
          NavItem(title: "All Staff Type", routeKey: "staff_type_all_ndis"),
          NavItem(title: "Add New Staff Type", routeKey: "staff_type_add_ndis"),
        ],
      ),

      NavItem(
        title: "Staff Group Settings",
        routeKey: "staff_group_settings",
        children: [
          NavItem(title: "All Staff Group", routeKey: "staff_group_all_ndis"),
          NavItem(title: "Add New Staff Group", routeKey: "staff_group_add_ndis"),
        ],
      ),
    ],
  ),
];
