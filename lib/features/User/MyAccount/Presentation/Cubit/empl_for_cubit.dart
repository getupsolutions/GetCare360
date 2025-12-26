import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class EmployeeFormState extends Equatable {
  final int step; // 0..4

  const EmployeeFormState({required this.step});

  EmployeeFormState copyWith({int? step}) =>
      EmployeeFormState(step: step ?? this.step);

  @override
  List<Object?> get props => [step];
}

class EmployeeFormCubit extends Cubit<EmployeeFormState> {
  EmployeeFormCubit() : super(const EmployeeFormState(step: 0));

  static const int maxStep = 4;

  void goTo(int step) {
    if (step < 0 || step > maxStep) return;
    emit(state.copyWith(step: step));
  }

  void next() => goTo(state.step + 1);
  void previous() => goTo(state.step - 1);
}
