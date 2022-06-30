import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../errors/errors.dart';

abstract class IPositionRepository {
  Future<Either<IErrorsException, LatLng?>> featchPosition();
}
