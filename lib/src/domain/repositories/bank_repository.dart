import 'package:dartz/dartz.dart';

import '../entities/location.dart';
import '../errors/errors.dart';

abstract class IBankRepository {
  Future<Either<IErrorsException, int>> saveLocation(Location location);
  Future<Either<IErrorsException, Location?>> featchLocation(String uid);
}
