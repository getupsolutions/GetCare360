import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:getcare360/features/User/Dashboard/Data/Model/drawer_model.dart';

part 'drawer_event.dart';
part 'drawer_state.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  DrawerBloc()
    : super(
        const DrawerState(
          activeRoute: DrawerRouteKey.dashboard,
          expandedSections: {
            DrawerSectionKey.myAccount,
            DrawerSectionKey.participants,
            DrawerSectionKey.roster,
            DrawerSectionKey.timesheet,
            DrawerSectionKey.availableShifts,
            DrawerSectionKey.clockInOut,
          },
        ),
      ) {
    on<DrawerRouteSelected>(_onRouteSelected);
    on<DrawerSectionToggled>(_onSectionToggled);
  }

  void _onRouteSelected(DrawerRouteSelected event, Emitter<DrawerState> emit) {
    emit(state.copyWith(activeRoute: event.route));
  }

  void _onSectionToggled(
    DrawerSectionToggled event,
    Emitter<DrawerState> emit,
  ) {
    final next = Set<DrawerSectionKey>.from(state.expandedSections);
    if (next.contains(event.section)) {
      next.remove(event.section);
    } else {
      next.add(event.section);
    }
    emit(state.copyWith(expandedSections: next));
  }
}
