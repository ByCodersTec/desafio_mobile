import 'package:desafio_mobile/src/data/adapters/user_adapter.dart';
import 'package:desafio_mobile/src/domain/errors/errors.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../shared/data_struct/auth.dart';
import '../datadources/auth_datasource.dart';

class AuthRepository extends IAuthRepository {
  final IAuthDatasource _authDatasource;

  AuthRepository(this._authDatasource);
  @override
  Future<Either<IErrorsException, User>> authUser(AuthUser authUser) async {
    try {
      final user = await _authDatasource.authUser(authUser);

      return right(UserAdapter.fromJson(user));
    } on IErrorsException catch (e) {
      return left(e);
    }
  }
}
