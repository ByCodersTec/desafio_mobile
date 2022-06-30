import 'package:desafio_mobile/src/data/adapters/location_adapter.dart';
import 'package:desafio_mobile/src/domain/errors/errors.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/location.dart';
import '../../domain/repositories/bank_repository.dart';
import '../datasources/featch_bank_location_datasource.dart';
import '../datasources/save_bank_location_datasource.dart';

class BankRepository extends IBankRepository {
  final ISaveBankLocationDatasource _saveLocation;
  final IFeatchBankLocationDatasource _featchLocation;

  BankRepository(this._saveLocation, this._featchLocation);

  @override
  Future<Either<IErrorsException, int>> saveLocation(Location location) async {
    try {
      final result = await _saveLocation.saveLocation(location);

      return right(result);
    } on IErrorsException catch (e, s) {
      final error = FalireException(e.message, s);
      return left(error);
    }
  }

  @override
  Future<Either<IErrorsException, Location?>> featchLocation(String uid) async {
    try {
      final result = await _featchLocation.featchLocation(uid);

      Location? location;

      if (result != null) {
        location = LocationAdapter.fromJson(result);
      }

      return right(location);
    } on IErrorsException catch (e, s) {
      final error = FalireException(e.message, s);
      return left(error);
    }
  }
}
