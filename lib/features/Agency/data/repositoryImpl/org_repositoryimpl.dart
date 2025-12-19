

import 'package:getcare360/features/Agency/data/data_source/org_remotedatasource.dart';
import 'package:getcare360/features/Agency/data/model/organization/org_model.dart';
import 'package:getcare360/features/Agency/domain/entity/org_entity.dart';
import 'package:getcare360/features/Agency/domain/repository/org_repository.dart';

class OrgRepositoryImpl implements OrgRepository {
  final OrgRemoteDataSource remote;
  OrgRepositoryImpl(this.remote);

  @override
  Future<List<OrgEntity>> getOrganizations() async {
    final res = await remote.fetchOrganizations();
    return res.map((e) => OrgModel.fromJson(e)).toList();
  }
}
