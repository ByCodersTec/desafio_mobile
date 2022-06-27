import '../adapters/auth.dart';

abstract class IAuthDatasource {
  Future<void> authUser(AuthUser authUser);
}
