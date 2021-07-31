import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class SembastStorage {
  static final SembastStorage _singleton = SembastStorage._();

  static SembastStorage get instance => _singleton;

  Completer<Database>? _dbOpenCompleter;

  SembastStorage._();

  Future<Database> get database async {
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      await _openDatabase();
    }

    return _dbOpenCompleter!.future;
  }

  Future _openDatabase() async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    final dbPath = join(documentDirectory.path, "sembest_db");

    final database = await databaseFactoryIo.openDatabase(dbPath);
    _dbOpenCompleter!.complete(database);
  }
}
