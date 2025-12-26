import 'package:getcare360/features/Admin/Agency/presentation/widget/Organization/view_org_widget.dart';

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
