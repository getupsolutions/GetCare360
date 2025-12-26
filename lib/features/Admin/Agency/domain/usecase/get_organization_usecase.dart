import 'package:getcare360/features/Admin/Agency/domain/entity/org_entity.dart';
import 'package:getcare360/features/Admin/Agency/domain/repository/org_repository.dart';

class GetOrganizations {
  final OrgRepository repo;
  GetOrganizations(this.repo);

  Future<List<OrgEntity>> call() => repo.getOrganizations();
}
