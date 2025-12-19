import 'package:equatable/equatable.dart';

class OrgEntity extends Equatable {
  final int id;
  final String name;
  final String contact;
  final String services;
  final String group;
  final DateTime regDate;
  final String status; // Active/Inactive/etc.

  const OrgEntity({
    required this.id,
    required this.name,
    required this.contact,
    required this.services,
    required this.group,
    required this.regDate,
    required this.status,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    contact,
    services,
    group,
    regDate,
    status,
  ];
}
