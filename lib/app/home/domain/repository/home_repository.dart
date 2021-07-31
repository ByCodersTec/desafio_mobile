import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class HomeRepository {
  Future<void> saveUserInDb(User userInfo, LatLng position);
}
