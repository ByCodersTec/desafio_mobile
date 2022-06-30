import 'package:desafio_mobile/src/data/datasources/auth_datasource.dart';
import 'package:desafio_mobile/src/domain/errors/errors.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import '../../shared/data_struct/auth.dart';

class AuthDatasource implements IAuthDatasource {
  final FirebaseAuth firebaseAuth;
  final FirebaseAnalytics analytics;
  final FirebaseCrashlytics crashlytics;

  AuthDatasource({
    required this.firebaseAuth,
    required this.analytics,
    required this.crashlytics,
  });

  Map<String, dynamic> _getMapUser(User user) {
    return {'uid': user.uid, 'email': user.email};
  }

  @override
  Future<Map<String, dynamic>> authUser(AuthUser authUser) async {
    try {
      final authResult = await firebaseAuth.signInWithEmailAndPassword(
          email: authUser.email, password: authUser.password);

      analytics.logLogin(loginMethod: authResult.user!.email);

      return _getMapUser(authResult.user!);
    } on FirebaseAuthException catch (e, s) {
      crashlytics.setCustomKey(
        'outer layer',
        'authUser method in external/datasource/auth_datadource',
      );
      crashlytics.recordError(e.message!, s);

      throw FalireException(e.message!, s);
    }
  }
}
