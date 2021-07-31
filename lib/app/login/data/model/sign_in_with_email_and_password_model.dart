import 'package:desafio_mobile/app/login/domain/entity/sign_in_with_email_and_password_entity.dart';

class SignInWithEmailAndPasswordModel extends SignInWithEmailAndPasswordEntity {
  SignInWithEmailAndPasswordModel({
    required String email,
    required String password,
  }) : super(email: email, password: password);
}
