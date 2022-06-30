import 'package:dartz/dartz.dart';
import '../../shared/data_struct/auth.dart';
import '../entities/user.dart';
import '../errors/errors.dart';
import '../repositories/auth_repository.dart';

abstract class IAuthUserUsecase {
  Future<Either<IErrorsException, User>> call(AuthUser authUser);
}

class AuthUserUsecase implements IAuthUserUsecase {
  final IAuthRepository _repository;

  AuthUserUsecase(this._repository);

  @override
  Future<Either<IErrorsException, User>> call(AuthUser authUser) async {
    if (authUser.email.isEmpty || authUser.email == '') {
      return left(const FalireException('login is empty or null'));
    }
    if (authUser.password.isEmpty || authUser.password == '') {
      return left(const FalireException('password is empty or null'));
    }
    final result = await _repository.authUser(authUser);
    return result;
  }
}
