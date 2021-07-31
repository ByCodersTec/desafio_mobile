import 'package:desafio_mobile/app/login/domain/repository/login_repository.dart';
import 'package:desafio_mobile/core/common/injected/module.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInWithEmailAndPasswordUsecase {
  final LoginRepository _repository = getIt.get<LoginRepository>();

  Future<User?> call({
    required String email,
    required String password,
  }) async =>
      _repository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
}
