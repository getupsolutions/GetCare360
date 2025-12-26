import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getcare360/core/constant/app_color.dart';
import 'package:getcare360/features/User/Dashboard/Data/Model/drawer_model.dart';
import 'package:getcare360/features/User/Dashboard/Presentation/Bloc/drawer_bloc.dart';

class SideDrawer extends StatelessWidget {
  final String headerName;
  final String headerSub;
  final bool asPermanent;
  final void Function(DrawerRouteKey route)? onNavigate;

  const SideDrawer({
    super.key,
    required this.headerName,
    required this.headerSub,
    this.asPermanent = false,
    this.onNavigate,
  });

  List<DrawerItem> _items() => const [
    DrawerItem(
      title: 'Dashboard',
      icon: Icons.dashboard_outlined,
      routeKey: DrawerRouteKey.dashboard,
    ),

    DrawerItem(
      title: 'My Account',
      icon: Icons.person_outline,
      sectionKey: DrawerSectionKey.myAccount,
      children: [
        DrawerItem(
          title: 'Employee Application Form',
          icon: Icons.horizontal_rule_outlined,
          routeKey: DrawerRouteKey.employeeApplicationForm,
          indent: true,
        ),
        DrawerItem(
          title: ' Documents',
          icon: Icons.horizontal_rule_outlined,
          routeKey: DrawerRouteKey.myAccountDocuments,
          indent: true,
        ),
        DrawerItem(
          title: ' Signed Documents',
          icon: Icons.horizontal_rule_outlined,
          routeKey: DrawerRouteKey.myAccountSignedDocument,
          indent: true,
        ),
        DrawerItem(
          title: ' Personal Details',
          icon: Icons.horizontal_rule_outlined,
          routeKey: DrawerRouteKey.myAccountPersonalDetails,
          indent: true,
        ),
      ],
    ),

    DrawerItem(
      title: 'Participants',
      icon: Icons.group_outlined,
      sectionKey: DrawerSectionKey.participants,
      children: [
        DrawerItem(
          title: 'My Participants',
          icon: Icons.horizontal_rule_outlined,
          routeKey: DrawerRouteKey.participantsList,
          indent: true,
        ),
        DrawerItem(
          title: 'Incident Register',
          icon: Icons.horizontal_rule_outlined,
          sectionKey: DrawerSectionKey.incidentRegister, // ✅ add this
          children: [
            DrawerItem(
              title: 'View All',
              icon: Icons.horizontal_rule_outlined,
              routeKey: DrawerRouteKey.incidentRegisterList,
              indent: true,
            ),
            DrawerItem(
              title: 'Add New',
              icon: Icons.horizontal_rule_outlined,
              routeKey: DrawerRouteKey.incidentRegisterAdd,
              indent: true,
            ),
          ],
        ),
      ],
    ),

    DrawerItem(
      title: 'My Roster',
      icon: Icons.calendar_month_outlined,
      sectionKey: DrawerSectionKey.roster,
      children: [
        DrawerItem(
          title: 'Participant Roster',
          icon: Icons.horizontal_rule_outlined,
          routeKey: DrawerRouteKey.rosterCalendar,
          indent: true,
        ),
        DrawerItem(
          title: 'Organization Roster',
          icon: Icons.horizontal_rule_outlined,
          routeKey: DrawerRouteKey.rosterMyRoster,
          indent: true,
        ),
      ],
    ),

    DrawerItem(
      title: 'Timesheet',
      icon: Icons.access_time,
      sectionKey: DrawerSectionKey.timesheet,
      children: [
        DrawerItem(
          title: 'Participan Timesheet',
          icon: Icons.horizontal_rule_outlined,
          routeKey: DrawerRouteKey.timesheetList,
          indent: true,
        ),
        DrawerItem(
          title: 'Organization Timesheet',
          icon: Icons.horizontal_rule_outlined,
          routeKey: DrawerRouteKey.timesheetSubmit,
          indent: true,
        ),
      ],
    ),

    DrawerItem(
      title: 'Available Shifts',
      icon: Icons.layers_outlined,
      sectionKey: DrawerSectionKey.availableShifts,
      children: [
        DrawerItem(
          title: 'Participant Shifts',
          icon: Icons.horizontal_rule_outlined,
          routeKey: DrawerRouteKey.availableShiftsList,
          indent: true,
        ),
        DrawerItem(
          title: 'Organization Shifts',
          icon: Icons.horizontal_rule_outlined,
          routeKey: DrawerRouteKey.availableShiftsClaimed,
          indent: true,
        ),
      ],
    ),

    DrawerItem(
      title: 'Clock In & Clock Out',
      icon: Icons.timer_outlined,
      sectionKey: DrawerSectionKey.clockInOut,
      children: [
        DrawerItem(
          title: 'Participant Clock In & Clock Out',
          icon: Icons.horizontal_rule_outlined,
          routeKey: DrawerRouteKey.clockInOutClockIn,
          indent: true,
        ),
        DrawerItem(
          title: 'Organization Clock In & Clock Out',
          icon: Icons.horizontal_rule_outlined,
          routeKey: DrawerRouteKey.clockInOutHistory,
          indent: true,
        ),
      ],
    ),

    DrawerItem(
      title: 'Message',
      icon: Icons.mail_outline,
      routeKey: DrawerRouteKey.dashboard,
    ),
    DrawerItem(
      title: 'Education Portal',
      icon: Icons.school_outlined,
      routeKey: DrawerRouteKey.dashboard,
    ),
    DrawerItem(
      title: 'Policy and Procedure',
      icon: Icons.policy_outlined,
      routeKey: DrawerRouteKey.dashboard,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final content = Container(
      color: AppColors.sideBg2,
      child: Column(
        children: [
          _DrawerHeader(name: headerName, sub: headerSub),
          Expanded(
            child: BlocBuilder<DrawerBloc, DrawerState>(
              builder: (context, state) {
                final items = _items();
                return ListView(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 12),
                  children: items.map((item) {
                    if (item.isSection) {
                      final expanded = state.expandedSections.contains(
                        item.sectionKey,
                      );
                      return _Section(
                        item: item,
                        expanded: expanded,
                        activeRoute: state.activeRoute,
                        onToggle: () => context.read<DrawerBloc>().add(
                          DrawerSectionToggled(item.sectionKey!),
                        ),
                        onLeafTap: (route) => _onLeafTap(context, route),
                      );
                    }

                    return _LeafTile(
                      item: item,
                      active: state.activeRoute == item.routeKey,
                      onTap: () => _onLeafTap(context, item.routeKey!),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );

    if (asPermanent) return content;
    return Drawer(width: 280, child: content);
  }

  void _onLeafTap(BuildContext context, DrawerRouteKey route) {
    context.read<DrawerBloc>().add(DrawerRouteSelected(route));

    // Close drawer on mobile
    if (Navigator.canPop(context)) Navigator.pop(context);

    // Let the page handle actual navigation
    onNavigate?.call(route);
  }
}

class _Section extends StatelessWidget {
  final DrawerItem item;
  final bool expanded;
  final DrawerRouteKey activeRoute;
  final VoidCallback onToggle;
  final void Function(DrawerRouteKey route) onLeafTap;

  const _Section({
    required this.item,
    required this.expanded,
    required this.activeRoute,
    required this.onToggle,
    required this.onLeafTap,
  });

  @override
  Widget build(BuildContext context) {
    bool containsActive(DrawerItem node) {
      if (node.routeKey == activeRoute) return true;
      return node.children.any(containsActive);
    }

    final hasActiveChild = item.children.any(containsActive);
    return Column(
      children: [
        InkWell(
          onTap: onToggle,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: hasActiveChild
                  ? Colors.white.withOpacity(0.08)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(item.icon, color: Colors.white, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    item.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: hasActiveChild
                          ? FontWeight.w800
                          : FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  expanded ? Icons.expand_less : Icons.expand_more,
                  color: Colors.white70,
                ),
              ],
            ),
          ),
        ),
        if (expanded)
          ...item.children.map((child) {
            // If child itself has children, render another Section (nested)
            if (child.children.isNotEmpty) {
              final nestedExpanded = context.select<DrawerBloc, bool>(
                (b) => b.state.expandedSections.contains(child.sectionKey),
              );

              // ✅ IMPORTANT: child must have a unique sectionKey to toggle
              if (child.sectionKey == null) {
                // fallback: show as leaf if no sectionKey
                return _LeafTile(
                  item: child,
                  active: activeRoute == child.routeKey,
                  onTap: child.routeKey == null
                      ? () {}
                      : () => onLeafTap(child.routeKey!),
                );
              }

              return Padding(
                padding: const EdgeInsets.only(left: 14),
                child: _Section(
                  item: child,
                  expanded: nestedExpanded,
                  activeRoute: activeRoute,
                  onToggle: () => context.read<DrawerBloc>().add(
                    DrawerSectionToggled(child.sectionKey!),
                  ),
                  onLeafTap: onLeafTap,
                ),
              );
            }

            // normal leaf
            return Padding(
              padding: const EdgeInsets.only(left: 14),
              child: _LeafTile(
                item: child,
                active: activeRoute == child.routeKey,
                onTap: () => onLeafTap(child.routeKey!),
              ),
            );
          }),
      ],
    );
  }
}

class _LeafTile extends StatelessWidget {
  final DrawerItem item;
  final bool active;
  final VoidCallback onTap;

  const _LeafTile({
    required this.item,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: active ? Colors.green.withOpacity(0.9) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        dense: true,
        visualDensity: const VisualDensity(vertical: -2),
        contentPadding: EdgeInsets.only(left: item.indent ? 24 : 10, right: 10),
        leading: Icon(item.icon, color: Colors.white, size: 20),
        title: Text(
          item.title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: active ? FontWeight.w800 : FontWeight.w600,
          ),
        ),
        trailing: active
            ? const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 14)
            : null,
        onTap: onTap,
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  final String name;
  final String sub;

  const _DrawerHeader({required this.name, required this.sub});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 18, 14, 14),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.sideBg, AppColors.sideBg2],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  sub,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 34,
            width: 34,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.edit, color: Colors.white70, size: 18),
          ),
        ],
      ),
    );
  }
}
