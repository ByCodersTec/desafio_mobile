import 'package:dartz/dartz.dart';
import '../../utils/models/auth.dart';
import '../entities/user.dart';
import '../errors/errors.dart';
import '../repositories/auth_repository.dart';

abstract class IAuthUser {
  Future<Either<IErrorsException, User>> call(AuthUser authUser);
}

class AuthUserUsecase implements IAuthUser {
  final IAuthRepository _repository;

  AuthUserUsecase(this._repository);

  @override
  Future<Either<IErrorsException, User>> call(AuthUser authUser) async =>
      await _repository.authUser(authUser);
}
