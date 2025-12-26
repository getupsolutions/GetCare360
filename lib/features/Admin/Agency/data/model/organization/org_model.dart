import 'package:getcare360/features/Admin/Agency/domain/entity/org_entity.dart';


class OrgModel extends OrgEntity {
  const OrgModel({
    required super.id,
    required super.name,
    required super.contact,
    required super.services,
    required super.group,
    required super.regDate,
    required super.status,
  });

  factory OrgModel.fromJson(Map<String, dynamic> json) {
    return OrgModel(
      id: json['id'] as int,
      name: json['name'] as String,
      contact: json['contact'] as String,
      services: json['services'] as String,
      group: json['group'] as String,
      regDate: DateTime.parse(json['regDate'] as String),
      status: json['status'] as String,
    );
  }
}
