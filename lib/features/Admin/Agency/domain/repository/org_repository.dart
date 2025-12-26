import 'package:getcare360/features/Admin/Agency/domain/entity/org_entity.dart';

abstract class OrgRepository {
  Future<List<OrgEntity>> getOrganizations();
}
