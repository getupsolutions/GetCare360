import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getcare360/features/Agency/data/model/organization/email_row.dart';
import 'package:getcare360/features/Agency/presentation/bloc/organization/add_org_event.dart';
import 'package:getcare360/features/Agency/presentation/bloc/organization/add_org_state.dart';

class AddOrgBloc extends Bloc<AddOrgEvent, AddOrgState> {
  AddOrgBloc() : super(AddOrgState.initial()) {
    on<AddOrgInit>((e, emit) {});

    on<AddOrgFieldChanged>((e, emit) {
      final next = Map<String, String>.from(state.fields);
      next[e.key] = e.value;
      emit(state.copyWith(fields: next, message: null));
    });

    on<AddOrgToggleService>((e, emit) {
      final list = List<String>.from(state.selectedServices);
      if (list.contains(e.service)) {
        list.remove(e.service);
      } else {
        list.add(e.service);
      }
      emit(state.copyWith(selectedServices: list, message: null));
    });

    on<AddOrgAddEmailRow>((e, emit) {
      final list = List<EmailRow>.from(state.emails)
        ..add(const EmailRow(email: "", enabled: false));
      emit(state.copyWith(emails: list, message: null));
    });

    on<AddOrgRemoveEmailRow>((e, emit) {
      final list = List<EmailRow>.from(state.emails);
      if (list.length <= 1) return;
      list.removeAt(e.index);
      emit(state.copyWith(emails: list, message: null));
    });

    on<AddOrgEmailChanged>((e, emit) {
      final list = List<EmailRow>.from(state.emails);
      list[e.index] = list[e.index].copyWith(email: e.email);
      emit(state.copyWith(emails: list, message: null));
    });

    on<AddOrgEmailEnabledChanged>((e, emit) {
      final list = List<EmailRow>.from(state.emails);
      list[e.index] = list[e.index].copyWith(enabled: e.enabled);
      emit(state.copyWith(emails: list, message: null));
    });

    on<AddOrgPickDate>((e, emit) {
      if (e.key == "startDate")
        emit(state.copyWith(startDate: e.date, message: null));
      if (e.key == "endDate")
        emit(state.copyWith(endDate: e.date, message: null));
    });

    on<AddOrgPickTime>((e, emit) {
      final list = List<TimingRow>.from(state.timings);
      final idx = list.indexWhere((t) => t.label == e.label);
      if (idx == -1) return;

      final row = list[idx];
      list[idx] = e.isStart
          ? row.copyWith(start: e.time)
          : row.copyWith(end: e.time);
      emit(state.copyWith(timings: list, message: null));
    });

    on<AddOrgGeneratePassword>((e, emit) {
      final pwd = _genPassword();
      final next = Map<String, String>.from(state.fields);
      next["password"] = pwd;
      next["confirmPassword"] = pwd;
      emit(state.copyWith(fields: next, message: "Password generated"));
    });

    on<AddOrgSubmit>((e, emit) async {
      emit(state.copyWith(submitting: true, message: null));
      await Future.delayed(const Duration(milliseconds: 500));
      emit(state.copyWith(submitting: false, message: "Saved (UI demo)"));
    });
  }

  String _genPassword() {
    const chars = "ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz23456789@#";
    final now = DateTime.now().millisecondsSinceEpoch;
    final seed = now % 100000;
    // simple deterministic-ish generator (replace with real)
    return "Gc$seed@9";
  }
}
