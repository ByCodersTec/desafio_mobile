import 'package:desafio_mobile/app/login/domain/entity/sign_in_with_email_and_password_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginDatasource {
  Future<User?> signInWithEmailAndPassword({
    required SignInWithEmailAndPasswordEntity userInfo,
  });
}
