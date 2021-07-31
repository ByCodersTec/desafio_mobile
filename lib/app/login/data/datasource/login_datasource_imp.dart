import 'package:desafio_mobile/app/common/store/global_store.dart';
import 'package:desafio_mobile/app/login/data/datasource/login_datasource.dart';
import 'package:desafio_mobile/app/login/domain/entity/sign_in_with_email_and_password_entity.dart';
import 'package:desafio_mobile/core/common/injected/module.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginDatasourceImp implements LoginDatasource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalStore _globalStore = getIt.get<GlobalStore>();

  Future<User?> signInWithEmailAndPassword({
    required SignInWithEmailAndPasswordEntity userInfo,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: userInfo.email,
        password: userInfo.password,
      );

      _globalStore.setCurrentUser(userCredential.user!);

      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        return null;
      }
    }
  }
}
