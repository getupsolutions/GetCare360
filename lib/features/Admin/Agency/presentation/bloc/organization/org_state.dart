import 'package:equatable/equatable.dart';
import 'package:getcare360/features/Admin/Agency/domain/entity/org_entity.dart';

class OrgState extends Equatable {
  final bool loading;
  final List<OrgEntity> all;
  final List<OrgEntity> filtered;

  final String query;
  final String status;
  final String sort;

  final String? error;

  const OrgState({
    required this.loading,
    required this.all,
    required this.filtered,
    required this.query,
    required this.status,
    required this.sort,
    required this.error,
  });

  factory OrgState.initial() => const OrgState(
    loading: false,
    all: [],
    filtered: [],
    query: "",
    status: "All",
    sort: "Name A-Z",
    error: null,
  );

  OrgState copyWith({
    bool? loading,
    List<OrgEntity>? all,
    List<OrgEntity>? filtered,
    String? query,
    String? status,
    String? sort,
    String? error,
  }) {
    return OrgState(
      loading: loading ?? this.loading,
      all: all ?? this.all,
      filtered: filtered ?? this.filtered,
      query: query ?? this.query,
      status: status ?? this.status,
      sort: sort ?? this.sort,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    loading,
    all,
    filtered,
    query,
    status,
    sort,
    error,
  ];
}
