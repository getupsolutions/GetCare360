import 'package:equatable/equatable.dart';

abstract class OrgEvent extends Equatable {
  const OrgEvent();
  @override
  List<Object?> get props => [];
}

class OrgStarted extends OrgEvent {}

class OrgSearchChanged extends OrgEvent {
  final String query;
  const OrgSearchChanged(this.query);
  @override
  List<Object?> get props => [query];
}

class OrgStatusChanged extends OrgEvent {
  final String status; // "All" | "Active" | ...
  const OrgStatusChanged(this.status);
  @override
  List<Object?> get props => [status];
}

class OrgSortChanged extends OrgEvent {
  final String sort; // "Name A-Z" | "Name Z-A" | "Newest" | "Oldest"
  const OrgSortChanged(this.sort);
  @override
  List<Object?> get props => [sort];
}

class OrgClearFilters extends OrgEvent {}
