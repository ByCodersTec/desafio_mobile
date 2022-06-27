import 'package:dartz/dartz.dart';
import 'package:desafio_mobile/src/domain/errors/errors.dart';

import '../../data/adapters/auth.dart';
import '../entities/user.dart';

abstract class IAuthRepository {
  Future<Either<IErrorsException, User>> authUser(AuthUser authUser);
}
