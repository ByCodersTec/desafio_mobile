import 'package:desafio_mobile/core/common/utils/api_result_utils.dart';

abstract class LocalStorageDao {
  Future<ApiResult> clearCollection(
    String collectionName,
  );
  Future<ApiResult> insert(
    String collectionName,
    Map<String, dynamic> value,
  );
  Future<ApiResult> delete(
    String collectionName,
    String key,
  );
  Future<ApiResult> deleteFromKeyId(
    String collectionName,
    String key,
    String value,
  );
  Future<ApiResult> findAll(
    String collectionName,
    String sortField,
  );
  Future<ApiResult> findAllFilter(
    String collectionName,
    String filterField,
    String filterValue,
    String sortField,
  );
}
