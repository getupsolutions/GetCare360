import 'package:flutter/material.dart';

/// Routes = actual navigation destinations (leaf pages)
enum DrawerRouteKey {
  dashboard,

  // My Account
  employeeApplicationForm,
  myAccountDocuments,
  myAccountSignedDocument,
  myAccountPersonalDetails,

  // Participants
  participantsList,
  incidentRegisterList, // View All
  incidentRegisterAdd, // Add New
  // My Roster
  rosterCalendar,
  rosterMyRoster,

  // Timesheet
  timesheetList,
  timesheetSubmit,

  // Available Shifts
  availableShiftsList,
  availableShiftsClaimed,

  // Clock In & Out
  clockInOutClockIn,
  clockInOutHistory,
}

/// Sections = expandable groups (these must be UNIQUE for every expandable node)
enum DrawerSectionKey {
  myAccount,
  participants,
  incidentRegister, // ✅ nested expandable menu
  roster,
  timesheet,
  availableShifts,
  clockInOut,
}

/// Drawer node model
class DrawerItem {
  final String title;
  final IconData icon;

  /// For leaf item navigation
  final DrawerRouteKey? routeKey;

  /// For expandable items
  final DrawerSectionKey? sectionKey;

  /// Nested children
  final List<DrawerItem> children;

  /// Indentation for sub-items
  final bool indent;

  const DrawerItem({
    required this.title,
    required this.icon,
    this.routeKey,
    this.sectionKey,
    this.children = const [],
    this.indent = false,
  });

  /// Expandable node
  bool get isSection => sectionKey != null && children.isNotEmpty;

  /// Clickable leaf node
  bool get isLeaf => routeKey != null;
}
