import 'package:moor_flutter/moor_flutter.dart';

import 'dao/user_localization_dao.dart';

part 'app_database.g.dart';

class UserLocalization extends Table {
  IntColumn get id => integer().autoIncrement().nullable()();
  TextColumn get uid => text().unique()();
  TextColumn get email => text()();
  TextColumn get latitude => text()();
  TextColumn get longitude => text()();
}

@UseMoor(tables: [UserLocalization])
class AppDatabase extends _$AppDatabase {
  static AppDatabase instance = AppDatabase._internal();

  late UserLocalizationDAO localizationDAO;

  AppDatabase._internal()
      : super(FlutterQueryExecutor.inDatabaseFolder(
          path: 'app_db.sqlite',
        )) {
    localizationDAO = UserLocalizationDAO(this);
  }

  @override
  int get schemaVersion => 1;
}
