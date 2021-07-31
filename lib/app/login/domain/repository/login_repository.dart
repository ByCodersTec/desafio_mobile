import 'package:firebase_auth/firebase_auth.dart';

mixin LoginRepository {
  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
}
