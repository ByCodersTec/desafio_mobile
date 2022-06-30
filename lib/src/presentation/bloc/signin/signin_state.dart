import '../../../domain/entities/user.dart';
import '../../../domain/errors/errors.dart';

abstract class SigninState {}

class SigninInitialState extends SigninState {}

class SigninLoadingState extends SigninState {}

class SigninStateAuthFinished implements SigninState {
  final User user;

  SigninStateAuthFinished(this.user);
}

class SigninStateAuthFailure implements SigninState {
  final IErrorsException errorException;

  SigninStateAuthFailure(this.errorException);
}
