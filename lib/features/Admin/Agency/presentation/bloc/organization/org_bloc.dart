import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getcare360/features/Admin/Agency/domain/entity/org_entity.dart';
import 'package:getcare360/features/Admin/Agency/domain/usecase/get_organization_usecase.dart';

import 'org_event.dart';
import 'org_state.dart';

class OrgBloc extends Bloc<OrgEvent, OrgState> {
  final GetOrganizations getOrganizations;

  OrgBloc(this.getOrganizations) : super(OrgState.initial()) {
    on<OrgStarted>(_onStarted);
    on<OrgSearchChanged>(_onSearchChanged);
    on<OrgStatusChanged>(_onStatusChanged);
    on<OrgSortChanged>(_onSortChanged);
    on<OrgClearFilters>(_onClear);
  }

  Future<void> _onStarted(OrgStarted event, Emitter<OrgState> emit) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final data = await getOrganizations();
      final filtered = _apply(
        all: data,
        query: state.query,
        status: state.status,
        sort: state.sort,
      );
      emit(
        state.copyWith(
          loading: false,
          all: data,
          filtered: filtered,
          error: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  void _onSearchChanged(OrgSearchChanged event, Emitter<OrgState> emit) {
    final filtered = _apply(
      all: state.all,
      query: event.query,
      status: state.status,
      sort: state.sort,
    );
    emit(state.copyWith(query: event.query, filtered: filtered, error: null));
  }

  void _onStatusChanged(OrgStatusChanged event, Emitter<OrgState> emit) {
    final filtered = _apply(
      all: state.all,
      query: state.query,
      status: event.status,
      sort: state.sort,
    );
    emit(state.copyWith(status: event.status, filtered: filtered, error: null));
  }

  void _onSortChanged(OrgSortChanged event, Emitter<OrgState> emit) {
    final filtered = _apply(
      all: state.all,
      query: state.query,
      status: state.status,
      sort: event.sort,
    );
    emit(state.copyWith(sort: event.sort, filtered: filtered, error: null));
  }

  void _onClear(OrgClearFilters event, Emitter<OrgState> emit) {
    final filtered = _apply(
      all: state.all,
      query: "",
      status: "All",
      sort: "Name A-Z",
    );
    emit(
      state.copyWith(
        query: "",
        status: "All",
        sort: "Name A-Z",
        filtered: filtered,
        error: null,
      ),
    );
  }

  List<OrgEntity> _apply({
    required List<OrgEntity> all,
    required String query,
    required String status,
    required String sort,
  }) {
    Iterable<OrgEntity> out = all;

    // status
    if (status != "All") {
      out = out.where((e) => e.status.toLowerCase() == status.toLowerCase());
    }

    // search
    final q = query.trim().toLowerCase();
    if (q.isNotEmpty) {
      out = out.where(
        (e) =>
            e.name.toLowerCase().contains(q) ||
            e.contact.toLowerCase().contains(q) ||
            e.services.toLowerCase().contains(q) ||
            e.group.toLowerCase().contains(q),
      );
    }

    final list = out.toList();

    // sort
    switch (sort) {
      case "Name Z-A":
        list.sort((a, b) => b.name.compareTo(a.name));
        break;
      case "Newest":
        list.sort((a, b) => b.regDate.compareTo(a.regDate));
        break;
      case "Oldest":
        list.sort((a, b) => a.regDate.compareTo(b.regDate));
        break;
      case "Name A-Z":
      default:
        list.sort((a, b) => a.name.compareTo(b.name));
        break;
    }

    return list;
  }
}
