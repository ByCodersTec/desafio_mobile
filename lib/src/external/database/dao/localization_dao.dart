import 'package:desafio_mobile/src/external/database/app_database.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'localization_dao.g.dart';

@UseDao(tables: [Localization, User])
class LocalizationDAO extends DatabaseAccessor<AppDatabase> with _$LocalizationDAOMixin {
  Future<LocalizationData> featchLocalization() {
    return (select(localization)).getSingle();

    /* customSelect(
        'Select userDB.uid, user.email, localizationDB.* from localizationDB inner join userDB on localizationDB.uidUser = userDB.uid',
        readsFrom: {localizationDB, userDB}).map((rows) {
          return rows.map((row) => )
        }).getSingle<LocalizationDBData>(); */
  }

  Future addLocalization(LocalizationData entity) {
    return into(localization).insert(entity);
  }

  Future updateLocalization(LocalizationData entity) {
    return update(localization).replace(entity);
  }

  LocalizationDAO(AppDatabase db) : super(db);
}
