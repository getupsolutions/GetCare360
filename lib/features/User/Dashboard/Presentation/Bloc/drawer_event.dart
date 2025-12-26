part of 'drawer_bloc.dart';

abstract class DrawerEvent extends Equatable {
  const DrawerEvent();

  @override
  List<Object?> get props => [];
}

class DrawerRouteSelected extends DrawerEvent {
  final DrawerRouteKey route;
  const DrawerRouteSelected(this.route);

  @override
  List<Object?> get props => [route];
}

class DrawerSectionToggled extends DrawerEvent {
  final DrawerSectionKey section;
  const DrawerSectionToggled(this.section);

  @override
  List<Object?> get props => [section];
}
