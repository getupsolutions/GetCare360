import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AddOrgEvent extends Equatable {
  const AddOrgEvent();
  @override
  List<Object?> get props => [];
}

class AddOrgInit extends AddOrgEvent {}

class AddOrgFieldChanged extends AddOrgEvent {
  final String key;
  final String value;
  const AddOrgFieldChanged(this.key, this.value);
  @override
  List<Object?> get props => [key, value];
}

class AddOrgToggleService extends AddOrgEvent {
  final String service;
  const AddOrgToggleService(this.service);
  @override
  List<Object?> get props => [service];
}

class AddOrgAddEmailRow extends AddOrgEvent {}

class AddOrgRemoveEmailRow extends AddOrgEvent {
  final int index;
  const AddOrgRemoveEmailRow(this.index);
  @override
  List<Object?> get props => [index];
}

class AddOrgEmailChanged extends AddOrgEvent {
  final int index;
  final String email;
  const AddOrgEmailChanged(this.index, this.email);
  @override
  List<Object?> get props => [index, email];
}

class AddOrgEmailEnabledChanged extends AddOrgEvent {
  final int index;
  final bool enabled;
  const AddOrgEmailEnabledChanged(this.index, this.enabled);
  @override
  List<Object?> get props => [index, enabled];
}

class AddOrgPickDate extends AddOrgEvent {
  final String key; // startDate/endDate
  final DateTime date;
  const AddOrgPickDate(this.key, this.date);
  @override
  List<Object?> get props => [key, date];
}

class AddOrgPickTime extends AddOrgEvent {
  final String label; // AM/PM/Night
  final bool isStart;
  final TimeOfDay time;
  const AddOrgPickTime({
    required this.label,
    required this.isStart,
    required this.time,
  });
  @override
  List<Object?> get props => [label, isStart, time];
}

class AddOrgGeneratePassword extends AddOrgEvent {}

class AddOrgSubmit extends AddOrgEvent {}

/// ✅ NEW
class AddOrgStatusChanged extends AddOrgEvent {
  final String status;
  const AddOrgStatusChanged(this.status);

  @override
  List<Object?> get props => [status];
}
