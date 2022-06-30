import 'package:desafio_mobile/src/data/adapters/position_adapter.dart';
import 'package:desafio_mobile/src/domain/errors/errors.dart';

import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../domain/repositories/position_repository.dart';
import '../datasources/get_current_position_datasource.dart';

class PositionRepository implements IPositionRepository {
  final IGetCurrentPositionDatasource _datasource;

  PositionRepository(this._datasource);

  @override
  Future<Either<IErrorsException, LatLng?>> featchPosition() async {
    try {
      final result = await _datasource.featchLocation();

      final resultPosition = PositionAdapter.fromJson(result);

      return right(resultPosition);
    } on IErrorsException catch (e, s) {
      final error = FalireException(e.message, s);
      return left(error);
    }
  }
}
