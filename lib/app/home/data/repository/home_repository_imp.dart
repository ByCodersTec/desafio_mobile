import 'package:desafio_mobile/app/home/data/datasource/home_datasource.dart';
import 'package:desafio_mobile/app/home/domain/repository/home_repository.dart';

import 'package:desafio_mobile/core/common/injected/module.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeRepositoryImp implements HomeRepository {
  final HomeDatasource _datasource = getIt.get<HomeDatasource>();

  @override
  Future<void> saveUserInDb(User userInfo, LatLng position) {
    return _datasource.saveUserInDb(userInfo, position);
  }
}
