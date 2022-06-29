import 'package:desafio_mobile/src/external/database/dao/localization_dao.dart';
import 'package:moor_flutter/moor_flutter.dart';

import 'dao/user_dao.dart';

part 'app_database.g.dart';

class User extends Table {
  TextColumn get uid => text()();
  TextColumn get email => text()();
}

class Localization extends Table {
  Column<int?> get id => integer().nullable().autoIncrement()();
  TextColumn get latitude => text()();
  TextColumn get longitude => text()();
  TextColumn get uidUser => text()();
}

@UseMoor(tables: [User, Localization])
class AppDatabase extends _$AppDatabase {
  static AppDatabase instance = AppDatabase._internal();

  late LocalizationDAO localizationDAO;
  late UserDAO userDAO;

  AppDatabase._internal()
      : super(FlutterQueryExecutor.inDatabaseFolder(
          path: 'app_db.sqlite',
        )) {
    localizationDAO = LocalizationDAO(this);
    userDAO = UserDAO(this);
  }

  @override
  int get schemaVersion => 1;
}
