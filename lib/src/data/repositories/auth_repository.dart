import 'package:desafio_mobile/src/domain/errors/errors.dart';
import 'package:desafio_mobile/src/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import 'package:desafio_mobile/src/domain/repositories/auth_repository.dart';

import '../adapters/auth.dart';

class AuthRepository extends IAuthRepository {
  @override
  Future<Either<IErrorsException, User>> authUser(AuthUser authUser) {
    throw UnimplementedError();
  }
}
