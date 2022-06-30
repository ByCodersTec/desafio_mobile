import 'package:desafio_mobile/src/data/datasources/save_bank_location_datasource.dart';
import 'package:desafio_mobile/src/domain/errors/errors.dart';
import 'package:desafio_mobile/src/domain/entities/location.dart';

import '../database/app_database.dart';

class SaveBankLocationDatasource implements ISaveBankLocationDatasource {
  final AppDatabase appDatabase;

  SaveBankLocationDatasource(this.appDatabase);

  UserLocalizationData convertAddUserLocalization(Location location) {
    return UserLocalizationData(
      uid: location.user.uid,
      email: location.user.email,
      latitude: location.latitude.toString(),
      longitude: location.longitude.toString(),
    );
  }

  UserLocalizationData convertUpdateUserLocalization(Location location) {
    return UserLocalizationData(
      id: location.id,
      uid: location.user.uid,
      email: location.user.email,
      latitude: location.latitude.toString(),
      longitude: location.longitude.toString(),
    );
  }

  @override
  Future<int> saveLocation(Location location) async {
    try {
      if (location.id == null) {
        UserLocalizationData localization = convertAddUserLocalization(location);

        final result = await appDatabase.localizationDAO.addLocalization(localization);

        return result;
      } else {
        UserLocalizationData localization = convertUpdateUserLocalization(location);

        final result = await appDatabase.localizationDAO.updateLocalization(localization);

        return result;
      }
    } catch (e, s) {
      throw FalireException(e.toString(), s);
    }
  }
}
