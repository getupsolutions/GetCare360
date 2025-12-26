part of 'drawer_bloc.dart';


class DrawerState extends Equatable {
  final DrawerRouteKey activeRoute;
  final Set<DrawerSectionKey> expandedSections;

  const DrawerState({
    required this.activeRoute,
    required this.expandedSections,
  });

  DrawerState copyWith({
    DrawerRouteKey? activeRoute,
    Set<DrawerSectionKey>? expandedSections,
  }) {
    return DrawerState(
      activeRoute: activeRoute ?? this.activeRoute,
      expandedSections: expandedSections ?? this.expandedSections,
    );
  }

  @override
  List<Object?> get props => [activeRoute, expandedSections];
}
