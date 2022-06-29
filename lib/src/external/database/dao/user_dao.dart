import 'package:desafio_mobile/src/external/database/app_database.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'user_dao.g.dart';

@UseDao(tables: [Localization, User])
class UserDAO extends DatabaseAccessor<AppDatabase> with _$UserDAOMixin {
  UserDAO(AppDatabase db) : super(db);
}
