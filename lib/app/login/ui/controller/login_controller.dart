import 'package:desafio_mobile/app/login/domain/usecase/sign_in_with_email_and_password_usecase.dart';
import 'package:desafio_mobile/core/common/injected/module.dart';
import 'package:mobx/mobx.dart';
part 'login_controller.g.dart';

class LoginController = _LoginController with _$LoginController;

abstract class _LoginController with Store {
  final SignInWithEmailAndPasswordUsecase _signInWithEmailAndPasswordUseCase =
      getIt.get<SignInWithEmailAndPasswordUsecase>();

  @observable
  bool isLoading = false;

  @observable
  bool hasError = false;

  @action
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    isLoading = true;
    final user = await _signInWithEmailAndPasswordUseCase(
      email: email,
      password: password,
    );
    if (user != null) {
      return true;
    }
    return false;
  }
}
