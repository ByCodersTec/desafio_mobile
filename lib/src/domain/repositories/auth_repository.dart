import 'package:dartz/dartz.dart';
import 'package:desafio_mobile/src/domain/errors/errors.dart';

import '../entities/user.dart';

abstract class IAuthRepository {
  Future<Either<IErrorsException, User>> authUser(authUser);
}
