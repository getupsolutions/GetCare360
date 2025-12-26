import 'package:equatable/equatable.dart';
import 'package:getcare360/features/Admin/Agency/data/model/organization/email_row.dart';

class AddOrgState extends Equatable {
  final bool submitting;

  // Simple key/value storage for text fields
  final Map<String, String> fields;

  final DateTime? startDate;
  final DateTime? endDate;

  final List<String> selectedServices;

  final List<EmailRow> emails;
  final List<TimingRow> timings;

  final String status; // Active/Inactive etc.

  final String? message;

  const AddOrgState({
    required this.submitting,
    required this.fields,
    required this.startDate,
    required this.endDate,
    required this.selectedServices,
    required this.emails,
    required this.timings,
    required this.status,
    required this.message,
  });

  factory AddOrgState.initial() => AddOrgState(
    submitting: false,
    fields: {
      "orgName": "",
      "contactName": "",
      "contactPhone": "",
      "addressSearch": "",
      "street": "",
      "suburb": "",
      "postcode": "",
      "username": "",
      "password": "",
      "confirmPassword": "",
      "abn": "",
      "locationGroup": "",
      "state": "",
      "groups": "",
    },
    startDate: null,
    endDate: null,
    selectedServices: const [],
    emails: const [EmailRow(email: "", enabled: false)],
    timings: const [
      TimingRow(label: "AM"),
      TimingRow(label: "PM"),
      TimingRow(label: "Night"),
    ],
    status: "Active",
    message: null,
  );

  AddOrgState copyWith({
    bool? submitting,
    Map<String, String>? fields,
    DateTime? startDate,
    DateTime? endDate,
    List<String>? selectedServices,
    List<EmailRow>? emails,
    List<TimingRow>? timings,
    String? status,
    String? message,
  }) {
    return AddOrgState(
      submitting: submitting ?? this.submitting,
      fields: fields ?? this.fields,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      selectedServices: selectedServices ?? this.selectedServices,
      emails: emails ?? this.emails,
      timings: timings ?? this.timings,
      status: status ?? this.status,
      message: message,
    );
  }

  @override
  List<Object?> get props => [
    submitting,
    fields,
    startDate,
    endDate,
    selectedServices,
    emails,
    timings,
    status,
    message,
  ];
}
