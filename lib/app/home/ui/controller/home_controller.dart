import 'package:desafio_mobile/app/common/store/global_store.dart';
import 'package:desafio_mobile/app/home/domain/usecase/save_user_info_in_db_usecase.dart';
import 'package:desafio_mobile/core/common/injected/module.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

class HomeController = _HomeController with _$HomeController;

abstract class _HomeController with Store {
  Location _location = Location();
  GlobalStore _globalStore = getIt.get<GlobalStore>();
  SaveUserInfoInDbUsecase _saveUserInfoInDbUsecase =
      getIt.get<SaveUserInfoInDbUsecase>();
  final FirebaseAnalytics _analytics = FirebaseAnalytics();

  @observable
  bool isLoading = true;

  @observable
  bool hasError = false;

  @action
  Future<void> saveUserInfoInDb(LatLng position) async {
    if (_globalStore.hasCurrentUser) {
      final user = _globalStore.getCurrentUser!;
      _saveUserInfoInDbUsecase(
        userInfo: user,
        position: position,
      );
      _analytics.logEvent(
        name: 'Rendered_Success',
        parameters: {
          "user_uid": user.uid,
          "user_email": user.email,
          "user_latitude": position.latitude,
          "user_longitude": position.longitude,
        },
      );
    }
  }

  @action
  Future<LatLng> getCurrentLocation() async {
    var location = await _location.getLocation();
    isLoading = false;
    return LatLng(location.latitude!, location.longitude!);
  }
}
