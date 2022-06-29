import 'dart:math';

import 'package:desafio_mobile/route_generator.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/errors/errors.dart';
import '../database/app_database.dart';

class DBDatasource {
  final AppDatabase appDatabase;

  DBDatasource(this.appDatabase);

  /* Map<String, dynamic> getMapUser(User user) {
    return {'uid': user.uid, 'email': user.email};
  } */

  Future<void> addLocalizationDB() async {
    try {
      LocalizationData localization =
          LocalizationData(latitude: '222', longitude: '222', uidUser: '222');
      final result = await appDatabase.localizationDAO.addLocalization(localization);

      //final result = await appDatabase.localizationDAO.deleteLocalization(2);

      print(result);

      /* final authResult = await firebaseAuth.signInWithEmailAndPassword(
          email: authUser.email, password: authUser.password);

      analytics.logLogin(loginMethod: authResult.user!.email);

      return _getMapUser(authResult.user!); */
    } on FirebaseAuthException catch (e, s) {
      /* crashlytics.setCustomKey(
        'outer layer',
        'authUser method in external/datasource/auth_datadource',
      );
      crashlytics.recordError(e.message!, s); */

      throw DatasourcePostException(e.message!, s);
    }
  }
}
