import 'package:desafio_mobile/app/common/db_storage/db_storage_dao.dart';
import 'package:desafio_mobile/app/home/data/datasource/home_datasource.dart';
import 'package:desafio_mobile/core/common/injected/module.dart';
import 'package:desafio_mobile/core/common/utils/api_result_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeDatasourceImp implements HomeDatasource {
  final DbStorageDao _dbStorage = getIt.get<DbStorageDao>();

  @override
  Future<void> saveUserInDb(User userInfo, LatLng position) =>
      _dbStorage.insert(
        'users',
        {
          'user_id': userInfo.uid,
          'email': userInfo.email,
          'latitude': position.latitude,
          'longitude': position.longitude,
        },
      );

  @override
  Future<ApiResult> getUsersInfos() => _dbStorage.findAll('users', 'email');
}
