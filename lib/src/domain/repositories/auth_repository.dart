import 'package:dartz/dartz.dart';

import '../../shared/data_struct/auth.dart';
import '../entities/user.dart';
import '../errors/errors.dart';

abstract class IAuthRepository {
  Future<Either<IErrorsException, User>> authUser(AuthUser authUser);
}
