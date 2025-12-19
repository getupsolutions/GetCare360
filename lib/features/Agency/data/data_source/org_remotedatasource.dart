import 'package:getcare360/features/Agency/presentation/widget/Organization/moc_data.dart';

abstract class OrgRemoteDataSource {
  Future<List<Map<String, dynamic>>> fetchOrganizations();
}

class OrgRemoteDataSourceImpl implements OrgRemoteDataSource {
  @override
  Future<List<Map<String, dynamic>>> fetchOrganizations() async {
    await Future.delayed(const Duration(milliseconds: 450));
    return List<Map<String, dynamic>>.from(mockOrgsJson);
  }
}
