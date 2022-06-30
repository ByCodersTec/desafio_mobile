import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../errors/errors.dart';
import '../repositories/position_repository.dart';

abstract class IGetCurrentPositionUsecase {
  Future<Either<IErrorsException, LatLng?>> call();
}

class GetCurrentPositionUsecase implements IGetCurrentPositionUsecase {
  final IPositionRepository _repository;

  GetCurrentPositionUsecase(this._repository);

  @override
  Future<Either<IErrorsException, LatLng?>> call() async {
    return await _repository.featchPosition();
  }
}
