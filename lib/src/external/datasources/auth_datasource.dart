import 'package:dartz/dartz.dart';
import 'package:desafio_mobile/src/data/datadources/auth_datasource.dart';
import 'package:desafio_mobile/src/domain/errors/errors.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/adapters/auth.dart';

class AuthDatadource implements IAuthDatasource {
  final FirebaseAuth _firebaseAuth;

  AuthDatadource(this._firebaseAuth);
  @override
  Future<void> authUser(AuthUser authUser) async {
    try {
      final authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: 'jacksonpaulino@gmail.com', password: 'cristorei002');
      print(authResult);
    } catch (e, s) {
      throw DatasourcePostException(e.toString(), s);
    }
  }
}
