import 'package:desafio_mobile/src/data/datadources/auth_datasource.dart';
import 'package:desafio_mobile/src/domain/errors/errors.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../shared/data_struct/auth.dart';

class AuthDatasource implements IAuthDatasource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseAnalytics _analytics;

  AuthDatasource(this._firebaseAuth, this._analytics);

  Map<String, dynamic> _getMapUser(User user) {
    return {'uid': user.uid, 'email': user.email};
  }

  @override
  Future<Map<String, dynamic>> authUser(AuthUser authUser) async {
    try {
      final authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: authUser.email, password: authUser.password);

      // email: 'jaksonpaulino@gmail.com', password: 'cristorei002');

      _analytics.logLogin(loginMethod: authResult.user!.email);

      return _getMapUser(authResult.user!);
    } on FirebaseAuthException catch (e, s) {
      throw DatasourcePostException(e.message!, s);
    }
  }
}
