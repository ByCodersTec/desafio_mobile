import 'package:desafio_mobile/src/domain/entities/user.dart';

import '../../domain/entities/location.dart';
import '../../external/database/app_database.dart';

class LocationAdapter {
  LocationAdapter._();

  static Location fromJson(UserLocalizationData data) {
    return Location(
      id: data.id,
      latitude: double.parse(data.latitude),
      longitude: double.parse(data.longitude),
      user: User(uid: data.uid, email: data.email),
    );
  }
}
