import 'package:desafio_mobile/core/common/utils/api_result_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class HomeDatasource {
  Future<void> saveUserInDb(User userInfo, LatLng position);
  Future<ApiResult> getUsersInfos();
}
