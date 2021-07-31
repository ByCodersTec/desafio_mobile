import 'package:desafio_mobile/app/common/local_storage/local_storage_dao.dart';
import 'package:desafio_mobile/app/common/local_storage/sembest_storage.dart';
import 'package:desafio_mobile/core/common/utils/api_result_utils.dart';

import 'package:sembast/sembast.dart';

class LocalStorageImpDao implements LocalStorageDao {
  Future<Database> get _db async => SembestStorage.instance.database;

  @override
  Future<ApiResult> clearCollection(
    String collectionName,
  ) async {
    try {
      final _store = intMapStoreFactory.store(collectionName);

      final _result = await _store.delete(await _db);

      return SuccessData(data: _result);
    } on Exception catch (_) {
      return ErrorData(
        errorMessage: "",
        data: null,
      );
    }
  }

  @override
  Future<ApiResult> insert(
    String collectionName,
    Map<String, dynamic> value,
  ) async {
    try {
      final _store = intMapStoreFactory.store(collectionName);

      final _result = await _store.add(await _db, value);

      return SuccessData(data: _result);
    } on Exception catch (_) {
      return ErrorData(
        errorMessage: "",
        data: null,
      );
    }
  }

  @override
  Future<ApiResult> delete(
    String collectionName,
    String key,
  ) async {
    try {
      final _store = intMapStoreFactory.store(collectionName);

      final finder = Finder(filter: Filter.byKey(int.parse(key)));

      final _result = await _store.delete(await _db, finder: finder);

      return SuccessData(data: _result);
    } on Exception catch (_) {
      return ErrorData(
        errorMessage: "",
        data: null,
      );
    }
  }

  @override
  Future<ApiResult> findAllFilter(
    String collectionName,
    String filterField,
    String filterValue,
    String sortField,
  ) async {
    try {
      final _store = intMapStoreFactory.store(collectionName);

      final finder = Finder(
        filter: Filter.equals(filterField, filterValue),
        sortOrders: [
          SortOrder(sortField),
        ],
      );

      final recordSnapshot = await _store.find(await _db, finder: finder);

      final dataResult = recordSnapshot
          .map(
            (snapshot) => Map<String, dynamic>.from(snapshot.value)
              ..addAll(
                {"id": snapshot.key.toString()},
              ),
          )
          .toList();

      return SuccessData(data: dataResult);
    } on Exception catch (_) {
      return ErrorData(
        errorMessage: "",
        data: null,
      );
    }
  }

  @override
  Future<ApiResult> findAll(
    String collectionName,
    String sortField,
  ) async {
    try {
      final _store = intMapStoreFactory.store(collectionName);

      final finder = Finder(sortOrders: [SortOrder(sortField)]);

      final recordSnapshot = await _store.find(await _db, finder: finder);

      final dataResult = recordSnapshot
          .map(
            (snapshot) => Map<String, dynamic>.from(snapshot.value)
              ..addAll(
                {"id": snapshot.key.toString()},
              ),
          )
          .toList();

      return SuccessData(data: dataResult);
    } on Exception catch (_) {
      return ErrorData(
        errorMessage: "",
        data: null,
      );
    }
  }

  @override
  Future<ApiResult> deleteFromKeyId(
    String collectionName,
    String key,
    String value,
  ) async {
    try {
      final _store = intMapStoreFactory.store(collectionName);

      final finder = Finder(
        filter: Filter.equals(key, value),
      );

      final _result = await _store.delete(await _db, finder: finder);

      return SuccessData(data: _result);
    } on Exception catch (_) {
      return ErrorData(
        errorMessage: "",
        data: null,
      );
    }
  }
}
