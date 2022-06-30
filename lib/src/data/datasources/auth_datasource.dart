import '../../shared/data_struct/auth.dart';

abstract class IAuthDatasource {
  Future<Map<String, dynamic>> authUser(AuthUser authUser);
}
