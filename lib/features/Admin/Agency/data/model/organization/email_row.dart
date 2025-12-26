import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class EmailRow extends Equatable {
  final String email;
  final bool enabled;
  const EmailRow({required this.email, required this.enabled});

  EmailRow copyWith({String? email, bool? enabled}) =>
      EmailRow(email: email ?? this.email, enabled: enabled ?? this.enabled);

  @override
  List<Object?> get props => [email, enabled];
}

class TimingRow extends Equatable {
  final String label; // AM/PM/Night
  final TimeOfDay? start;
  final TimeOfDay? end;

  const TimingRow({required this.label, this.start, this.end});

  TimingRow copyWith({TimeOfDay? start, TimeOfDay? end}) =>
      TimingRow(label: label, start: start ?? this.start, end: end ?? this.end);

  @override
  List<Object?> get props => [label, start, end];
}
