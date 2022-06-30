import 'package:desafio_mobile/src/external/database/app_database.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'user_localization_dao.g.dart';

@UseDao(tables: [UserLocalization])
class UserLocalizationDAO extends DatabaseAccessor<AppDatabase> with _$UserLocalizationDAOMixin {
  Future<UserLocalizationData?> featchLocalization(String uid) async {
    final list = await (select(userLocalization)).get();
    UserLocalizationData? result;

    for (var element in list) {
      if (element.uid == uid) {
        result = element;
      }
    }
    return result;
  }

  Future addLocalization(UserLocalizationData entity) {
    return into(userLocalization).insert(entity);
  }

  Future updateLocalization(UserLocalizationData entity) {
    return update(userLocalization).replace(entity);
  }

  UserLocalizationDAO(AppDatabase db) : super(db);
}
